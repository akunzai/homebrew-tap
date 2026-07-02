class Gistui < Formula
  desc "Terminal UI for managing GitHub Gists"
  homepage "https://akunzai.github.io/gistui/"
  url "https://github.com/akunzai/gistui/archive/refs/tags/v0.15.0.tar.gz"
  sha256 "8ed42234845de56e00fb554848e333ea9c0575e0d4cd8b63328b3678f9e0986d"
  license "MIT"
  head "https://github.com/akunzai/gistui.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "rust" => :build
  depends_on "gh" # gistui shells out to the GitHub CLI at runtime

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match "gistui", shell_output("#{bin}/gistui --help")
  end
end
