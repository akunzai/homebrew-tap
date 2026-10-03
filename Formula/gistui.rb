class Gistui < Formula
  desc "Terminal UI for managing GitHub Gists"
  homepage "https://akunzai.github.io/gistui/"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  head do
    url "https://github.com/akunzai/gistui.git", branch: "main"
    depends_on "rust" => :build
  end

  depends_on "gh" # gistui shells out to the GitHub CLI at runtime

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/akunzai/gistui/releases/download/v0.25.0/gistui-v0.25.0-x86_64-apple-darwin.tar.gz"
      sha256 "f0b9b3d5a0332e9add92cc8dfbcd261e32f5624c8f8d0f535e40eb8279fc755c"
    end
    if Hardware::CPU.arm?
      url "https://github.com/akunzai/gistui/releases/download/v0.25.0/gistui-v0.25.0-aarch64-apple-darwin.tar.gz"
      sha256 "9e0612c5dac303d901e7d48bb9800737bae8cfd4efd60420bad5857bc3d726de"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/akunzai/gistui/releases/download/v0.25.0/gistui-v0.25.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "ed512c35a899803a537ee6e300009f4f9f229a7db7a9b21ed40c723852389134"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/akunzai/gistui/releases/download/v0.25.0/gistui-v0.25.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "6c5a0a3320fedb31651817061628e52d4cee930a73e948cc46d9b544b000d0a0"
    end
  end

  def install
    if build.head?
      system "cargo", "install", *std_cargo_args
    else
      bin.install "gistui"
    end
  end

  test do
    assert_match "gistui", shell_output("#{bin}/gistui --help")
  end
end
