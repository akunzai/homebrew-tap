class Duodiff < Formula
  desc "Fast, cross-platform terminal user interface (TUI) directory comparison tool"
  homepage "https://github.com/akunzai/duodiff"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/akunzai/duodiff/releases/download/v0.6.0/duodiff-v0.6.0-x86_64-apple-darwin.tar.gz"
      sha256 "5b3714035752c00846a3d9ead5380808647149c975dae9481482e32f585bcd2b"
    end
    if Hardware::CPU.arm?
      url "https://github.com/akunzai/duodiff/releases/download/v0.6.0/duodiff-v0.6.0-aarch64-apple-darwin.tar.gz"
      sha256 "c2478d31950b84ab15d5b6d7a7c8df44210a735968fffad7b9c8b93bb79f3173"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/akunzai/duodiff/releases/download/v0.6.0/duodiff-v0.6.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d190fba791fd8b2ce0d30125569ed1999d02de97d7b97585926935d7bc7b5df7"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/akunzai/duodiff/releases/download/v0.6.0/duodiff-v0.6.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "b87a1a51b61fabb7537f1d021d267de0cc5a234d69c438a5fa5e098a5f33d4d0"
    end
  end

  def install
    bin.install "duodiff"
  end

  test do
    assert_match "duodiff", shell_output("#{bin}/duodiff --help")
  end
end
