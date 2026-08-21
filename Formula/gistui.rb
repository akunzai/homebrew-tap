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
      url "https://github.com/akunzai/gistui/releases/download/v0.18.0/gistui-v0.18.0-x86_64-apple-darwin.tar.gz"
      sha256 "3345b7de17fa417568a989f6b3fdc3113d891575549aba9c26f82d1e322d4074"
    end
    if Hardware::CPU.arm?
      url "https://github.com/akunzai/gistui/releases/download/v0.18.0/gistui-v0.18.0-aarch64-apple-darwin.tar.gz"
      sha256 "569cd775e217e3ae4795ff56b0154aabba2cc402ecc42c3aa63270b9d9425e32"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/akunzai/gistui/releases/download/v0.18.0/gistui-v0.18.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "367114620c4f7961f093b0f452b066f3c4da7ea1056ea7caa86331e07191dabc"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/akunzai/gistui/releases/download/v0.18.0/gistui-v0.18.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "a4d45475e633c381ef17a3fb79dcc56b06a3aa706a4b669274d8435056416303"
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
