class Duodiff < Formula
  desc "Fast, cross-platform terminal user interface (TUI) directory comparison tool"
  homepage "https://github.com/akunzai/duodiff"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/akunzai/duodiff/releases/download/v0.12.0/duodiff-v0.12.0-x86_64-apple-darwin.tar.gz"
      sha256 "4635850617e1a3f499623ba20f4aab36004e2e925226dd97d04886cb11f562f2"
    end
    if Hardware::CPU.arm?
      url "https://github.com/akunzai/duodiff/releases/download/v0.12.0/duodiff-v0.12.0-aarch64-apple-darwin.tar.gz"
      sha256 "7d8fdaf39e0fafa4f738d842dea09bb06c49ce965801b25436c53f64191ad938"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/akunzai/duodiff/releases/download/v0.12.0/duodiff-v0.12.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "6000d2eaeeb562e7b7b99d6d88b30869b088b36a5327d059c4118138709cbf0a"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/akunzai/duodiff/releases/download/v0.12.0/duodiff-v0.12.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "16fb917a2ab73f8dc60fde2dadd5cb6057db0d41d94dd9b30962048d5da80870"
    end
  end

  def install
    bin.install "duodiff"
  end

  test do
    assert_match "duodiff", shell_output("#{bin}/duodiff --help")
  end
end
