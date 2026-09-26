class Duodiff < Formula
  desc "Fast, cross-platform terminal user interface (TUI) directory comparison tool"
  homepage "https://github.com/akunzai/duodiff"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/akunzai/duodiff/releases/download/v0.13.0/duodiff-v0.13.0-x86_64-apple-darwin.tar.gz"
      sha256 "e5f503a1bf81e6597c2888daacc2cf912dfeaee3646770dc828baf51b97dc640"
    end
    if Hardware::CPU.arm?
      url "https://github.com/akunzai/duodiff/releases/download/v0.13.0/duodiff-v0.13.0-aarch64-apple-darwin.tar.gz"
      sha256 "df600a55148b51d95f5a7bafc0d01c40b73f14f6ce6a93a4a1b3542c4abdfdbe"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/akunzai/duodiff/releases/download/v0.13.0/duodiff-v0.13.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "65c691f96196f7086ed6482c174f7a2614abae0c84eb2e88f95c707fe680fff7"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/akunzai/duodiff/releases/download/v0.13.0/duodiff-v0.13.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "4ef74206782edbffa6567cd55ce6bd6371a28366dc5e4db1ca837cc730ad5aca"
    end
  end

  def install
    bin.install "duodiff"
  end

  test do
    assert_match "duodiff", shell_output("#{bin}/duodiff --help")
  end
end
