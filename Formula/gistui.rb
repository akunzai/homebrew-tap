class Gistui < Formula
  desc "Terminal UI for managing GitHub Gists"
  homepage "https://akunzai.github.io/gistui/"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  head do
    url "https://github.com/akunzai/gistui.git", branch: "main"
    depends_on "rust" => :build
  end

  depends_on "gh" # gistui shells out to the GitHub CLI at runtime

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/akunzai/gistui/releases/download/v0.23.0/gistui-v0.23.0-x86_64-apple-darwin.tar.gz"
      sha256 "4958e7ab359d4e191a4a56ecc7ce76c3f940da2ab84db260f2fbd6a062992f8a"
    end
    if Hardware::CPU.arm?
      url "https://github.com/akunzai/gistui/releases/download/v0.23.0/gistui-v0.23.0-aarch64-apple-darwin.tar.gz"
      sha256 "92e4c935b405be76645da0668314d2147f62987449be304e9f0f64f5925d5db1"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/akunzai/gistui/releases/download/v0.23.0/gistui-v0.23.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "43b63aa8d327a6b9cf1a6fba5df326d231b915fe05b1e8f3dfc38c235c16541d"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/akunzai/gistui/releases/download/v0.23.0/gistui-v0.23.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "9d322a1b5a41cfa3b48af5c6cdeb98908cb8ec6124391650d8f536386f300f8a"
    end
  end

  def install
    if build.head?
      system "cargo", "install", *std_cargo_args
    else
      bin.install "gistui"
    end
  end

  test do
    assert_match "gistui", shell_output("#{bin}/gistui --help")
  end
end
