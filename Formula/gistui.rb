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
      url "https://github.com/akunzai/gistui/releases/download/v0.20.0/gistui-v0.20.0-x86_64-apple-darwin.tar.gz"
      sha256 "28582c80b617618522cbd8b84bcdbfa56b5ec84188ac87c2f3c4047e92313eef"
    end
    if Hardware::CPU.arm?
      url "https://github.com/akunzai/gistui/releases/download/v0.20.0/gistui-v0.20.0-aarch64-apple-darwin.tar.gz"
      sha256 "7da2b530940f8e0984a3daaf0ade1212276e0465502d0d512b9a9125b64349c9"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/akunzai/gistui/releases/download/v0.20.0/gistui-v0.20.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "cb5b8fc882a18981a15a5ee3a50e10e2f32d66d27a0a45e0d6ec8ade25461ca5"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/akunzai/gistui/releases/download/v0.20.0/gistui-v0.20.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "5a9ba1b7f1e95f96eea5f83304db562c67d19382a6114a2be01a25b66a1715eb"
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
