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
      url "https://github.com/akunzai/gistui/releases/download/v0.19.0/gistui-v0.19.0-x86_64-apple-darwin.tar.gz"
      sha256 "60c4d667268a3dcf29dec4255bcd189efc6a4148d1821116c5a134f1be07c013"
    end
    if Hardware::CPU.arm?
      url "https://github.com/akunzai/gistui/releases/download/v0.19.0/gistui-v0.19.0-aarch64-apple-darwin.tar.gz"
      sha256 "9f444eabcc5cea2952cd13aa83f484064348353903e627b676558951e3295aa4"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/akunzai/gistui/releases/download/v0.19.0/gistui-v0.19.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "1ff7a39f1e0fdee7f1eede3dc7e59fe63ca010aa27b0067794b98ff00bd07d43"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/akunzai/gistui/releases/download/v0.19.0/gistui-v0.19.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "7b7a124e9bc8f4d0217710f30c69a9918fb889dd0d1a06fa189acfc570fb7b01"
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
