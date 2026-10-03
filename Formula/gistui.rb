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
      url "https://github.com/akunzai/gistui/releases/download/v0.24.1/gistui-v0.24.1-x86_64-apple-darwin.tar.gz"
      sha256 "616b70f8e6ee5879ed4a26cb54c0a01377346f7f004ebdf9c2b2ee82b2a65c2a"
    end
    if Hardware::CPU.arm?
      url "https://github.com/akunzai/gistui/releases/download/v0.24.1/gistui-v0.24.1-aarch64-apple-darwin.tar.gz"
      sha256 "d5018ef152146f5231b70499bb241790dfbac289f5eaad48f48dccb1fa05bbfa"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/akunzai/gistui/releases/download/v0.24.1/gistui-v0.24.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "ac88b0d2766587d4e332103ee5e86808fcebef5e1862719c1f8fbaaaa542e203"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/akunzai/gistui/releases/download/v0.24.1/gistui-v0.24.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "0ec523981597f983b92a076fdb5c669c7056253c61e08bc3dfcdb6a1240971b2"
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
