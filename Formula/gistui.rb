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
      url "https://github.com/akunzai/gistui/releases/download/v0.15.1/gistui-v0.15.1-x86_64-apple-darwin.tar.gz"
      sha256 "601bdf5c2c21a1f48e9472a7a8bde0f8acfaa6f91b799fbead82290bd30cebad"
    end
    if Hardware::CPU.arm?
      url "https://github.com/akunzai/gistui/releases/download/v0.15.1/gistui-v0.15.1-aarch64-apple-darwin.tar.gz"
      sha256 "c46d0a768ffd23cf592959ddf869b23bd931aa9aa752c4b6f5e3824953a9760b"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/akunzai/gistui/releases/download/v0.15.1/gistui-v0.15.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c60947e5b6dc7dc911bfa82054ffa1f6ba1ea3afa2bbccea8a62fbe84e4531ee"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/akunzai/gistui/releases/download/v0.15.1/gistui-v0.15.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "3414a20a1d78298ae1cba97bf8f5c39c0afe8bb19419cdaa1f348b3d0690ba75"
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
