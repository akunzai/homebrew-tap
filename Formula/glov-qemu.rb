class GlovQemu < Formula
  desc "QEMU for glov's Windows VMs, patched so virtio-balloon frees memory on macOS"
  homepage "https://github.com/akunzai/glov"
  url "https://download.qemu.org/qemu-11.1.3.tar.xz"
  sha256 "5a8289c7940dc77d3873c81a6c29ba3afe1446fc9d36e77fa1658cdbecb84b22"
  license "GPL-2.0-only"

  livecheck do
    formula "qemu"
  end

  # Installs the same executables as homebrew-core's qemu.
  keg_only "it is a patched build of qemu for glov"

  depends_on "bison" => :build # >= 3.0
  depends_on "libtool" => :build
  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkgconf" => :build
  depends_on "python-setuptools" => :build
  depends_on "python@3.15" => :build # keep aligned with meson
  depends_on "spice-protocol" => :build

  depends_on arch: :arm64
  depends_on "capstone"
  depends_on "dtc"
  depends_on "glib"
  depends_on "gnutls"
  depends_on "jpeg-turbo"
  depends_on "libpng"
  depends_on "libslirp"
  depends_on "libssh"
  depends_on "libusb"
  depends_on "lzo"
  depends_on :macos
  depends_on "ncurses"
  depends_on "pixman"
  depends_on "snappy"
  depends_on "vde"
  depends_on "zstd"

  uses_from_macos "flex" => :build
  uses_from_macos "bzip2"

  # On macOS, MADV_DONTNEED keeps the pages, so a virtio-balloon inflate frees
  # nothing (https://gitlab.com/qemu-project/qemu/-/work_items/4170). This
  # discards with MADV_FREE_REUSABLE, undoes it with MADV_FREE_REUSE on deflate
  # and on device reset (for the pages still ballooned), and tracks every
  # partly ballooned 16 KiB host page instead of one, since guests with 4 KiB
  # pages (Windows) balloon the subpages of a host page far apart. QEMU
  # declines AI-assisted patches, so this one is not sent upstream.
  patch :DATA

  def install
    ENV["LIBTOOL"] = "glibtool"

    # Same as homebrew-core's qemu: keep only the pure-python wheels.
    rm(Dir["python/wheels/*"] - Dir["python/wheels/{pycotap,qemu_qmp}-*-none-any.whl"])
    # Python 3.15 no longer bundles `wheel` and setuptools builds wheels without it
    inreplace "pythondeps.toml", /^"wheel" = .*\n/, ""

    # glov runs only aarch64 guests on HVF.
    args = %W[
      --prefix=#{prefix}
      --cc=#{ENV.cc}
      --host-cc=#{ENV.cc}
      --target-list=aarch64-softmmu
      --with-pkgversion=glov-balloon
      --disable-bsd-user
      --disable-download
      --disable-guest-agent
      --disable-pvg
      --disable-sdl
      --disable-gtk
      --enable-cocoa
      --enable-slirp
      --enable-capstone
      --enable-curses
      --enable-fdt=system
      --enable-libssh
      --enable-vde
      --enable-virtfs
      --enable-zstd
      --extra-cflags=-DNCURSES_WIDECHAR=1
      --smbd=#{HOMEBREW_PREFIX}/sbin/samba-dot-org-smbd
    ]

    system "./configure", *args
    system "make", "V=1", "install"
  end

  test do
    output = shell_output("#{bin}/qemu-system-aarch64 --version")
    assert_match version.to_s, output
    assert_match "glov-balloon", output

    system bin/"qemu-img", "create", "-f", "qcow2", "test.qcow2", "1440k"
    assert_match "file format: qcow2", shell_output("#{bin}/qemu-img info test.qcow2")

    # HVF needs the hypervisor entitlement the install signs in.
    output = shell_output("codesign -d --entitlements - #{bin}/qemu-system-aarch64 2>&1")
    assert_match "com.apple.security.hypervisor", output
  end
end

__END__
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -4182,7 +4182,12 @@
             if (qemu_ram_is_shared(rb) && rb->fd < 0) {
                 ret = madvise(host_startaddr, length, QEMU_MADV_REMOVE);
             } else {
+#if defined(CONFIG_DARWIN) && defined(MADV_FREE_REUSABLE)
+                /* MADV_DONTNEED keeps the pages on macOS; only this frees them. */
+                ret = madvise(host_startaddr, length, MADV_FREE_REUSABLE);
+#else
                 ret = madvise(host_startaddr, length, QEMU_MADV_DONTNEED);
+#endif
             }
             if (ret) {
                 ret = -errno;
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -39,32 +39,33 @@
 
 #define BALLOON_PAGE_SIZE  (1 << VIRTIO_BALLOON_PFN_SHIFT)
 
-typedef struct PartiallyBalloonedPage {
-    ram_addr_t base_gpa;
-    unsigned long *bitmap;
-} PartiallyBalloonedPage;
-
-static void virtio_balloon_pbp_free(PartiallyBalloonedPage *pbp)
+/*
+ * On macOS, discarded pages are MADV_FREE_REUSABLE: undo that before the
+ * guest uses them again, so the footprint counts them and the kernel no
+ * longer treats them as free to reclaim.
+ */
+static void balloon_reuse_page(void *host_addr, size_t size)
 {
-    if (!pbp->bitmap) {
-        return;
-    }
-    g_free(pbp->bitmap);
-    pbp->bitmap = NULL;
+#if defined(CONFIG_DARWIN) && defined(MADV_FREE_REUSE)
+    (void)madvise(host_addr, size, MADV_FREE_REUSE);
+#endif
 }
 
-static void virtio_balloon_pbp_alloc(PartiallyBalloonedPage *pbp,
-                                     ram_addr_t base_gpa,
-                                     long subpages)
+static void balloon_reuse_all(VirtIOBalloon *s)
 {
-    pbp->base_gpa = base_gpa;
-    pbp->bitmap = bitmap_new(subpages);
-}
+    GHashTableIter iter;
+    gpointer host_addr;
 
-static bool virtio_balloon_pbp_matches(PartiallyBalloonedPage *pbp,
-                                       ram_addr_t base_gpa)
-{
-    return pbp->base_gpa == base_gpa;
+    g_hash_table_iter_init(&iter, s->discarded_pages);
+    while (g_hash_table_iter_next(&iter, &host_addr, NULL)) {
+        ram_addr_t offset;
+        RAMBlock *rb = qemu_ram_block_from_host(host_addr, false, &offset);
+
+        if (rb) {
+            balloon_reuse_page(host_addr, qemu_ram_pagesize(rb));
+        }
+    }
+    g_hash_table_remove_all(s->discarded_pages);
 }
 
 static bool virtio_balloon_inhibited(void)
@@ -78,8 +79,7 @@
 }
 
 static void balloon_inflate_page(VirtIOBalloon *balloon,
-                                 MemoryRegion *mr, hwaddr mr_offset,
-                                 PartiallyBalloonedPage *pbp)
+                                 MemoryRegion *mr, hwaddr mr_offset)
 {
     void *addr = memory_region_get_ram_ptr(mr) + mr_offset;
     ram_addr_t rb_offset, rb_aligned_offset, base_gpa;
@@ -96,6 +96,7 @@
         /* Easy case */
 
         ram_block_discard_range(rb, rb_offset, rb_page_size);
+        g_hash_table_add(balloon->discarded_pages, addr);
         /* We ignore errors from ram_block_discard_range(), because it
          * has already reported them, and failing to discard a balloon
          * page is not fatal */
@@ -113,33 +114,38 @@
 
     rb_aligned_offset = QEMU_ALIGN_DOWN(rb_offset, rb_page_size);
     subpages = rb_page_size / BALLOON_PAGE_SIZE;
+    if (subpages > 64) {
+        /* Too many subpages to track in a 64-bit mask; never discard. */
+        return;
+    }
     base_gpa = memory_region_get_ram_addr(mr) + mr_offset -
                (rb_offset - rb_aligned_offset);
 
-    if (pbp->bitmap && !virtio_balloon_pbp_matches(pbp, base_gpa)) {
-        /* We've partially ballooned part of a host page, but now
-         * we're trying to balloon part of a different one.  Too hard,
-         * give up on the old partial page */
-        virtio_balloon_pbp_free(pbp);
-    }
+    /*
+     * Track every partly ballooned host page, not just the last one: guests
+     * with 4 KiB pages (Windows) hand pages over in no particular order, so
+     * on 16 KiB hosts (Apple silicon) the subpages of one host page arrive
+     * far apart.
+     */
+    uint64_t full = subpages == 64 ? UINT64_MAX : (1ULL << subpages) - 1;
+    gpointer key = GSIZE_TO_POINTER(base_gpa);
+    uint64_t mask = GPOINTER_TO_SIZE(
+        g_hash_table_lookup(balloon->partial_pages, key));
 
-    if (!pbp->bitmap) {
-        virtio_balloon_pbp_alloc(pbp, base_gpa, subpages);
+    mask |= 1ULL << ((rb_offset - rb_aligned_offset) / BALLOON_PAGE_SIZE);
+    if (mask != full) {
+        g_hash_table_insert(balloon->partial_pages, key, GSIZE_TO_POINTER(mask));
+        return;
     }
 
-    set_bit((rb_offset - rb_aligned_offset) / BALLOON_PAGE_SIZE,
-            pbp->bitmap);
-
-    if (bitmap_full(pbp->bitmap, subpages)) {
-        /* We've accumulated a full host page, we can actually discard
-         * it now */
-
-        ram_block_discard_range(rb, rb_aligned_offset, rb_page_size);
-        /* We ignore errors from ram_block_discard_range(), because it
-         * has already reported them, and failing to discard a balloon
-         * page is not fatal */
-        virtio_balloon_pbp_free(pbp);
-    }
+    /* We've accumulated a full host page, we can actually discard it now */
+    g_hash_table_remove(balloon->partial_pages, key);
+    ram_block_discard_range(rb, rb_aligned_offset, rb_page_size);
+    g_hash_table_add(balloon->discarded_pages,
+                     qemu_ram_get_host_addr(rb) + rb_aligned_offset);
+    /* We ignore errors from ram_block_discard_range(), because it
+     * has already reported them, and failing to discard a balloon
+     * page is not fatal */
 }
 
 static void balloon_deflate_page(VirtIOBalloon *balloon,
@@ -159,8 +165,34 @@
 
     host_addr = (void *)((uintptr_t)addr & ~(rb_page_size - 1));
 
+    if (rb_page_size > BALLOON_PAGE_SIZE &&
+        rb_page_size / BALLOON_PAGE_SIZE <= 64) {
+        long subpages = rb_page_size / BALLOON_PAGE_SIZE;
+        ram_addr_t sub = (rb_offset & (rb_page_size - 1)) / BALLOON_PAGE_SIZE;
+        gpointer key = GSIZE_TO_POINTER(memory_region_get_ram_addr(mr) +
+                                        mr_offset -
+                                        (rb_offset & (rb_page_size - 1)));
+        uint64_t full = subpages == 64 ? UINT64_MAX : (1ULL << subpages) - 1;
+        gpointer val;
+        /* Not tracked: the whole host page was ballooned and discarded. */
+        uint64_t mask = g_hash_table_lookup_extended(balloon->partial_pages,
+                                                     key, NULL, &val)
+                        ? GPOINTER_TO_SIZE(val) : full;
+
+        mask &= ~(1ULL << sub);
+        if (mask) {
+            g_hash_table_insert(balloon->partial_pages, key,
+                                GSIZE_TO_POINTER(mask));
+        } else {
+            g_hash_table_remove(balloon->partial_pages, key);
+        }
+    }
+
     /* When a page is deflated, we hint the whole host page it lives
      * on, since we can't do anything smaller */
+    if (g_hash_table_remove(balloon->discarded_pages, host_addr)) {
+        balloon_reuse_page(host_addr, rb_page_size);
+    }
     ret = qemu_madvise(host_addr, rb_page_size, QEMU_MADV_WILLNEED);
     if (ret != 0) {
         warn_report("Couldn't MADV_WILLNEED on balloon deflate: %s",
@@ -407,7 +439,6 @@
     MemoryRegionSection section;
 
     for (;;) {
-        PartiallyBalloonedPage pbp = {};
         size_t offset = 0;
         uint32_t pfn;
 
@@ -442,7 +473,7 @@
             if (!virtio_balloon_inhibited()) {
                 if (vq == s->ivq) {
                     balloon_inflate_page(s, section.mr,
-                                         section.offset_within_region, &pbp);
+                                         section.offset_within_region);
                 } else if (vq == s->dvq) {
                     balloon_deflate_page(s, section.mr, section.offset_within_region);
                 } else {
@@ -455,7 +486,6 @@
         virtqueue_push(vq, elem, 0);
         virtio_notify(vdev, vq);
         g_free(elem);
-        virtio_balloon_pbp_free(&pbp);
     }
 }
 
@@ -873,6 +903,9 @@
     VirtIOBalloon *s = VIRTIO_BALLOON(dev);
     int ret;
 
+    s->partial_pages = g_hash_table_new(NULL, NULL);
+    s->discarded_pages = g_hash_table_new(NULL, NULL);
+
     virtio_init(vdev, VIRTIO_ID_BALLOON, virtio_balloon_config_size(s));
 
     ret = qemu_add_balloon_handler(virtio_balloon_to_target,
@@ -943,6 +976,8 @@
     }
     balloon_stats_destroy_timer(s);
     qemu_remove_balloon_handler(s);
+    g_hash_table_destroy(s->partial_pages);
+    g_hash_table_destroy(s->discarded_pages);
 
     virtio_delete_queue(s->ivq);
     virtio_delete_queue(s->dvq);
@@ -964,6 +999,13 @@
         virtio_balloon_free_page_stop(s);
     }
 
+    /*
+     * The guest starts over with an empty balloon and uses the ballooned
+     * pages again without deflating them.
+     */
+    g_hash_table_remove_all(s->partial_pages);
+    balloon_reuse_all(s);
+
     if (s->stats_vq_elem != NULL) {
         virtqueue_unpop(s->svq, s->stats_vq_elem, 0);
         g_free(s->stats_vq_elem);
--- a/include/hw/virtio/virtio-balloon.h
+++ b/include/hw/virtio/virtio-balloon.h
@@ -49,6 +49,13 @@
     uint32_t num_pages;
     uint32_t actual;
     uint32_t free_page_hint_cmd_id;
+    /*
+     * Host pages larger than BALLOON_PAGE_SIZE that are only partly in the
+     * balloon: base GPA -> bitmask of the ballooned subpages.
+     */
+    GHashTable *partial_pages;
+    /* Host addresses of the host pages discarded and not deflated since. */
+    GHashTable *discarded_pages;
     uint64_t stats[VIRTIO_BALLOON_S_NR];
     VirtQueueElement *stats_vq_elem;
     size_t stats_vq_offset;
