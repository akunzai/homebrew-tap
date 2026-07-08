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
      url "https://github.com/akunzai/gistui/releases/download/v0.16.0/gistui-v0.16.0-x86_64-apple-darwin.tar.gz"
      sha256 "6c42cae03c819e3a2972c30c0b5f2999966db43b45f3285696778dfd97ed138e"
    end
    if Hardware::CPU.arm?
      url "https://github.com/akunzai/gistui/releases/download/v0.16.0/gistui-v0.16.0-aarch64-apple-darwin.tar.gz"
      sha256 "57f349f0150a39ccba8343dbb7a925a9e23f7dc3c90f3cf8cb472310b5e6fda4"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/akunzai/gistui/releases/download/v0.16.0/gistui-v0.16.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "7d27dbabc369c4b1e594631da676aebbb2829a8097e6ecd5efcbb7030a67009e"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/akunzai/gistui/releases/download/v0.16.0/gistui-v0.16.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "d7927a2a9ed39358eb6dc103f0ba49b06cc71bcf1a3d131a4a2e1cd458986ce8"
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
