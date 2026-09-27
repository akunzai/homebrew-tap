class Duodiff < Formula
  desc "Fast, cross-platform terminal user interface (TUI) directory comparison tool"
  homepage "https://github.com/akunzai/duodiff"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/akunzai/duodiff/releases/download/v0.14.0/duodiff-v0.14.0-x86_64-apple-darwin.tar.gz"
      sha256 "f63afdb8b407198de5d0a6b872f5458c485594f7c1c558e8820fd130d26a7f0b"
    end
    if Hardware::CPU.arm?
      url "https://github.com/akunzai/duodiff/releases/download/v0.14.0/duodiff-v0.14.0-aarch64-apple-darwin.tar.gz"
      sha256 "b737467faeb70112a3612d556cb21c7589e682803d27215509a1db3ba066a847"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/akunzai/duodiff/releases/download/v0.14.0/duodiff-v0.14.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "098f604040faf8b174ae4abb0f80510eaeb1f3708e2b6ff7e8d24394b09666a8"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/akunzai/duodiff/releases/download/v0.14.0/duodiff-v0.14.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "bade248d94d5ba3069df78be383664d1de3c645119500b82bb67da03bab25789"
    end
  end

  def install
    bin.install "duodiff"
  end

  test do
    assert_match "duodiff", shell_output("#{bin}/duodiff --help")
  end
end
