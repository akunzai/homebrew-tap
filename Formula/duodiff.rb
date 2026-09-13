class Duodiff < Formula
  desc "Fast, cross-platform terminal user interface (TUI) directory comparison tool"
  homepage "https://github.com/akunzai/duodiff"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/akunzai/duodiff/releases/download/v0.10.0/duodiff-v0.10.0-x86_64-apple-darwin.tar.gz"
      sha256 "3e2b47b835c89849bcb4725d3be7d1dd0b4bce0bfd160e0313878d5b1c122eb1"
    end
    if Hardware::CPU.arm?
      url "https://github.com/akunzai/duodiff/releases/download/v0.10.0/duodiff-v0.10.0-aarch64-apple-darwin.tar.gz"
      sha256 "f5e5ee89b0380ca7dada313c982fbf71069ea7c4edf26ea8a8601206c3e1eb53"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/akunzai/duodiff/releases/download/v0.10.0/duodiff-v0.10.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "9a0aba34a4c3677bd2cb49f8c7074ede19ff6db12e39e18969a0634061a1bd37"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/akunzai/duodiff/releases/download/v0.10.0/duodiff-v0.10.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "8b4b3133bf9727f3ccc2eb5473a821e7b15b39c232f1b68bf82c089a5a0ff44f"
    end
  end

  def install
    bin.install "duodiff"
  end

  test do
    assert_match "duodiff", shell_output("#{bin}/duodiff --help")
  end
end
