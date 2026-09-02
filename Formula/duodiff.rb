class Duodiff < Formula
  desc "Fast, cross-platform terminal user interface (TUI) directory comparison tool"
  homepage "https://github.com/akunzai/duodiff"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/akunzai/duodiff/releases/download/v0.9.0/duodiff-v0.9.0-x86_64-apple-darwin.tar.gz"
      sha256 "69c22d07e9cb8bd29fde0d1614b4fa2224d2cecac2e9e04c68dbb8669591221d"
    end
    if Hardware::CPU.arm?
      url "https://github.com/akunzai/duodiff/releases/download/v0.9.0/duodiff-v0.9.0-aarch64-apple-darwin.tar.gz"
      sha256 "7c9b0ef89930555f367af93eef58fc1bc21c7cddde96d202291bd660e2d8bfbd"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/akunzai/duodiff/releases/download/v0.9.0/duodiff-v0.9.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "7b3e67b9e70c0585c583e5b580d6c8fa2e237eab9119352ceecdf20f16a958fc"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/akunzai/duodiff/releases/download/v0.9.0/duodiff-v0.9.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "229aa31d7230520c92808f55d927908e50fd94b577a98c67d3c2c7b3a003aab1"
    end
  end

  def install
    bin.install "duodiff"
  end

  test do
    assert_match "duodiff", shell_output("#{bin}/duodiff --help")
  end
end
