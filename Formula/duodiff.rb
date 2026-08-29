class Duodiff < Formula
  desc "Fast, cross-platform terminal user interface (TUI) directory comparison tool"
  homepage "https://github.com/akunzai/duodiff"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/akunzai/duodiff/releases/download/v0.8.0/duodiff-v0.8.0-x86_64-apple-darwin.tar.gz"
      sha256 "0952dcbd459fe81a2aa98ee5c25198d982a2b5997a9bb9fbadd36465983d2e09"
    end
    if Hardware::CPU.arm?
      url "https://github.com/akunzai/duodiff/releases/download/v0.8.0/duodiff-v0.8.0-aarch64-apple-darwin.tar.gz"
      sha256 "8c952d5ae3792446fe6568cd7b70e8fa3d86f6f1afd6cea09269ac92f1db3943"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/akunzai/duodiff/releases/download/v0.8.0/duodiff-v0.8.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "5b6ee896f22a10bc0a9fb901dd7bb51f29374e1009fe59ef0797f2c9b41e4e15"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/akunzai/duodiff/releases/download/v0.8.0/duodiff-v0.8.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "eb0d35b8ddd1694b43c75bbb404b75df202b578ad75df274af0041d1e32eb72c"
    end
  end

  def install
    bin.install "duodiff"
  end

  test do
    assert_match "duodiff", shell_output("#{bin}/duodiff --help")
  end
end
