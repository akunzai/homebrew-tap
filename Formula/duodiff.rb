class Duodiff < Formula
  desc "Fast, cross-platform terminal user interface (TUI) directory comparison tool"
  homepage "https://github.com/akunzai/duodiff"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/akunzai/duodiff/releases/download/v0.1.0/duodiff-v0.1.0-x86_64-apple-darwin.tar.gz"
      sha256 "cc3e238374780bb64576e678b32f2e2a9830ccd4eb5138efc5a5c37fdbd1b643"
    end
    if Hardware::CPU.arm?
      url "https://github.com/akunzai/duodiff/releases/download/v0.1.0/duodiff-v0.1.0-aarch64-apple-darwin.tar.gz"
      sha256 "f13b99ae33927e2f9af62171b4e97513f5abd455cca104c959255f095c3986f9"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/akunzai/duodiff/releases/download/v0.1.0/duodiff-v0.1.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "ed6da01030392e8ddaddea0804d588ec764f84ea9b78108f902001500ab9909f"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/akunzai/duodiff/releases/download/v0.1.0/duodiff-v0.1.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "a9b65732f8a11a21a1f3fe052e84b509b5075d6c2bbca933fa0ef16d76bb2ec4"
    end
  end

  def install
    bin.install "duodiff"
  end

  test do
    assert_match "duodiff", shell_output("#{bin}/duodiff --help")
  end
end
