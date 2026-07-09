class Duodiff < Formula
  desc "Fast, cross-platform terminal user interface (TUI) directory comparison tool"
  homepage "https://github.com/akunzai/duodiff"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/akunzai/duodiff/releases/download/v0.5.1/duodiff-v0.5.1-x86_64-apple-darwin.tar.gz"
      sha256 "13036b5c427dcf4acaad201a2ee4896cbfef3d01f9ee24a69813796bc5ea25ed"
    end
    if Hardware::CPU.arm?
      url "https://github.com/akunzai/duodiff/releases/download/v0.5.1/duodiff-v0.5.1-aarch64-apple-darwin.tar.gz"
      sha256 "5ddbcce6b859c1b58b391290949936f4d43e530780f0908afc870ae1f58edd6a"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/akunzai/duodiff/releases/download/v0.5.1/duodiff-v0.5.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c8ddf0a7918ef10cc459ce1421288d5a6f96f53301d25688510bc94730f1108d"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/akunzai/duodiff/releases/download/v0.5.1/duodiff-v0.5.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "2fac50d4951912117ad5c69c52f7b9200c23adaa2cd53e32b519381b739de773"
    end
  end

  def install
    bin.install "duodiff"
  end

  test do
    assert_match "duodiff", shell_output("#{bin}/duodiff --help")
  end
end
