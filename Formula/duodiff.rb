class Duodiff < Formula
  desc "Fast, cross-platform terminal user interface (TUI) directory comparison tool"
  homepage "https://github.com/akunzai/duodiff"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/akunzai/duodiff/releases/download/v0.3.0/duodiff-v0.3.0-x86_64-apple-darwin.tar.gz"
      sha256 "8ea403125b9b5e473aae9c261bbc8ad3d3b3e7cb0ed467a38d41792ea0c5de12"
    end
    if Hardware::CPU.arm?
      url "https://github.com/akunzai/duodiff/releases/download/v0.3.0/duodiff-v0.3.0-aarch64-apple-darwin.tar.gz"
      sha256 "d3595b7748a250122f34cf332f9faf360fc7584279f9a97c7df5869909e2365f"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/akunzai/duodiff/releases/download/v0.3.0/duodiff-v0.3.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "ad73d6d1bf08925212322f0c0e7d18bc37e53fd97b0c1efcf774d39d92c9e198"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/akunzai/duodiff/releases/download/v0.3.0/duodiff-v0.3.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "bacb5a6dce8659a1be936bb0606026523db6c2c369bad40a997ab79c98015187"
    end
  end

  def install
    bin.install "duodiff"
  end

  test do
    assert_match "duodiff", shell_output("#{bin}/duodiff --help")
  end
end
