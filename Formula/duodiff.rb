class Duodiff < Formula
  desc "Fast, cross-platform terminal user interface (TUI) directory comparison tool"
  homepage "https://github.com/akunzai/duodiff"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/akunzai/duodiff/releases/download/v0.4.0/duodiff-v0.4.0-x86_64-apple-darwin.tar.gz"
      sha256 "fc3b4fc3e0ecde9c37f1aff162616e78afb90a5b62ccd7b30a64774ded61832f"
    end
    if Hardware::CPU.arm?
      url "https://github.com/akunzai/duodiff/releases/download/v0.4.0/duodiff-v0.4.0-aarch64-apple-darwin.tar.gz"
      sha256 "d6284fcfb62e485b454c6eb6bcfee79c1b3b17ba27e1438c931991da21bd558c"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/akunzai/duodiff/releases/download/v0.4.0/duodiff-v0.4.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "8e700c6ff3765267126738a5ebbea870d98045e093f5c814fe7cf4b44473037a"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/akunzai/duodiff/releases/download/v0.4.0/duodiff-v0.4.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "9595f8d18defe2804d2603bc0efd3e3ac14466a8d5849b5955e1b7fd6add17dc"
    end
  end

  def install
    bin.install "duodiff"
  end

  test do
    assert_match "duodiff", shell_output("#{bin}/duodiff --help")
  end
end
