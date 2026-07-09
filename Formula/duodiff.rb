class Duodiff < Formula
  desc "Fast, cross-platform terminal user interface (TUI) directory comparison tool"
  homepage "https://github.com/akunzai/duodiff"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/akunzai/duodiff/releases/download/v0.5.0/duodiff-v0.5.0-x86_64-apple-darwin.tar.gz"
      sha256 "05e182b9d72d6aa4fdf10d342d004b9411859cb0842f032ced1e9617e033b1ae"
    end
    if Hardware::CPU.arm?
      url "https://github.com/akunzai/duodiff/releases/download/v0.5.0/duodiff-v0.5.0-aarch64-apple-darwin.tar.gz"
      sha256 "d48b6e7495b3ef33ffce7c47489add99f0bb4a99dc27cf9df7763385703456b2"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/akunzai/duodiff/releases/download/v0.5.0/duodiff-v0.5.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c7ec5439fcdc19cc938800b4ee8f4cdacd3654e1fa37c6eb08107c27c38ef283"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/akunzai/duodiff/releases/download/v0.5.0/duodiff-v0.5.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "dc066711acd39c0485c7e6f709fc335fff1a8b3bbc579c865907bc023cad42a9"
    end
  end

  def install
    bin.install "duodiff"
  end

  test do
    assert_match "duodiff", shell_output("#{bin}/duodiff --help")
  end
end
