class Duodiff < Formula
  desc "Fast, cross-platform terminal user interface (TUI) directory comparison tool"
  homepage "https://github.com/akunzai/duodiff"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/akunzai/duodiff/releases/download/v0.11.0/duodiff-v0.11.0-x86_64-apple-darwin.tar.gz"
      sha256 "5b795450baa8fca9e91e982b41b3f847a748e21210375c4172a6350aa37ce523"
    end
    if Hardware::CPU.arm?
      url "https://github.com/akunzai/duodiff/releases/download/v0.11.0/duodiff-v0.11.0-aarch64-apple-darwin.tar.gz"
      sha256 "2322accf0b2e744e2ed557750836558d08b4c790cb3f199a9e2621f9035d28b2"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/akunzai/duodiff/releases/download/v0.11.0/duodiff-v0.11.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "1ddaf30aa49a9998bef32e3f104bce90553550773b51e0b47a486f916fa7bfeb"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/akunzai/duodiff/releases/download/v0.11.0/duodiff-v0.11.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "7b085b780cd24ec9263bc40ebd411b9176d63bc48c338171b793bd3819341777"
    end
  end

  def install
    bin.install "duodiff"
  end

  test do
    assert_match "duodiff", shell_output("#{bin}/duodiff --help")
  end
end
