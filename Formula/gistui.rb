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
      url "https://github.com/akunzai/gistui/releases/download/v0.23.1/gistui-v0.23.1-x86_64-apple-darwin.tar.gz"
      sha256 "d2479efc5ef09d6cc7c8138027b09ac692d93e1b102f0c73a41b0fe7f3ef9511"
    end
    if Hardware::CPU.arm?
      url "https://github.com/akunzai/gistui/releases/download/v0.23.1/gistui-v0.23.1-aarch64-apple-darwin.tar.gz"
      sha256 "a10147cddc399b4487e7c828de0ca5b381d5dd0dd76f3330a7e6c1d114cfde6f"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/akunzai/gistui/releases/download/v0.23.1/gistui-v0.23.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c9d63813564a28e9d6ba423256f213a3339d1b0e71f2b8176581be64382a2c98"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/akunzai/gistui/releases/download/v0.23.1/gistui-v0.23.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "3e44ed5d6278673b5e1574b608f531cd800b4cb2e430e180bf3d1b56bf500359"
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
