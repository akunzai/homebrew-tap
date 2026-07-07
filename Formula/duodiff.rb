class Duodiff < Formula
  desc "Fast, cross-platform terminal user interface (TUI) directory comparison tool"
  homepage "https://github.com/akunzai/duodiff"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/akunzai/duodiff/releases/download/v0.2.0/duodiff-v0.2.0-x86_64-apple-darwin.tar.gz"
      sha256 "d2fcd94b4df8033bfa6b58d30389b0240155d3867a02d05a1deb509a0b9792e8"
    end
    if Hardware::CPU.arm?
      url "https://github.com/akunzai/duodiff/releases/download/v0.2.0/duodiff-v0.2.0-aarch64-apple-darwin.tar.gz"
      sha256 "53fd47528cbcbba9ecab909eb2e9dd615d936caf8a351de829d33b1f61bb7d9d"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/akunzai/duodiff/releases/download/v0.2.0/duodiff-v0.2.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e5cbcc148c0df76052e860b84c9eb42f1647c22155b972bfb9927721a0bc3ddd"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/akunzai/duodiff/releases/download/v0.2.0/duodiff-v0.2.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "fadbe91a891b23ab59348bb8adbd05a724d2d1661255272d7394c683bc0e2e5c"
    end
  end

  def install
    bin.install "duodiff"
  end

  test do
    assert_match "duodiff", shell_output("#{bin}/duodiff --help")
  end
end
