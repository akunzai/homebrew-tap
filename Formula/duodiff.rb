class Duodiff < Formula
  desc "Fast, cross-platform terminal user interface (TUI) directory comparison tool"
  homepage "https://github.com/akunzai/duodiff"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/akunzai/duodiff/releases/download/v0.15.0/duodiff-v0.15.0-x86_64-apple-darwin.tar.gz"
      sha256 "952ec868e2d11ff4bf2af9a0fc90a4cbec8f2c80a6be4d0d02101d77cf681837"
    end
    if Hardware::CPU.arm?
      url "https://github.com/akunzai/duodiff/releases/download/v0.15.0/duodiff-v0.15.0-aarch64-apple-darwin.tar.gz"
      sha256 "4bf9b8b39993b075e346e6b70a53b3111e3ab0a7573d0cfb8a9f8a5f877ec224"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/akunzai/duodiff/releases/download/v0.15.0/duodiff-v0.15.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "b12d2f86cc8011882efbc3ccbb14ab007c552e042b6f992bdc997f7b22490026"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/akunzai/duodiff/releases/download/v0.15.0/duodiff-v0.15.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "06abfda9fa896ef80a1093ad2fc6056816f816c7dcabd6c77e78856d5a53c8c7"
    end
  end

  def install
    bin.install "duodiff"
  end

  test do
    assert_match "duodiff", shell_output("#{bin}/duodiff --help")
  end
end
