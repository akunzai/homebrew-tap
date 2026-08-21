class Duodiff < Formula
  desc "Fast, cross-platform terminal user interface (TUI) directory comparison tool"
  homepage "https://github.com/akunzai/duodiff"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/akunzai/duodiff/releases/download/v0.7.0/duodiff-v0.7.0-x86_64-apple-darwin.tar.gz"
      sha256 "31dd8d6412839e64fdee5152f3faeeeccd36e89c74eeb01b93933378a8319436"
    end
    if Hardware::CPU.arm?
      url "https://github.com/akunzai/duodiff/releases/download/v0.7.0/duodiff-v0.7.0-aarch64-apple-darwin.tar.gz"
      sha256 "31a4eaafeccb730e7ea8486b315c38c086e9f341562cfeb1806df214a03811b8"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/akunzai/duodiff/releases/download/v0.7.0/duodiff-v0.7.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "ab31488a6f609e46f79cfb8c2e2f84192d12287780c4c1bf8de85e1006745453"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/akunzai/duodiff/releases/download/v0.7.0/duodiff-v0.7.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "4ce21f585e24950ec24f9d433f113ffd2ce47ee79c18dccea253aa9e2afb6569"
    end
  end

  def install
    bin.install "duodiff"
  end

  test do
    assert_match "duodiff", shell_output("#{bin}/duodiff --help")
  end
end
