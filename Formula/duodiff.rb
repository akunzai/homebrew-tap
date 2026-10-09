class Duodiff < Formula
  desc "Fast, cross-platform terminal user interface (TUI) directory comparison tool"
  homepage "https://github.com/akunzai/duodiff"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/akunzai/duodiff/releases/download/v0.15.1/duodiff-v0.15.1-x86_64-apple-darwin.tar.gz"
      sha256 "7232695e6dce0cbbe2753c6d8a321573d8ce9235a288a3e303facca18cf376a8"
    end
    if Hardware::CPU.arm?
      url "https://github.com/akunzai/duodiff/releases/download/v0.15.1/duodiff-v0.15.1-aarch64-apple-darwin.tar.gz"
      sha256 "bc4941fe56bff231e3dffcbd5c994a8ce19409204adf2a9d2d35e0d53b053328"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/akunzai/duodiff/releases/download/v0.15.1/duodiff-v0.15.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a8cb5445b0ce5e480bb7d0c36920065eb496bd80c87acc70724f54c18f473161"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/akunzai/duodiff/releases/download/v0.15.1/duodiff-v0.15.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "922317b19c94a7366b26a6d5e466fe44f4ba06bda3ff36b7a6b0481d4664f075"
    end
  end

  def install
    bin.install "duodiff"
  end

  test do
    assert_match "duodiff", shell_output("#{bin}/duodiff --help")
  end
end
