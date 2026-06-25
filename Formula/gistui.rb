class Gistui < Formula
  desc "Terminal UI for managing GitHub Gists"
  homepage "https://akunzai.github.io/gistui/"
  url "https://github.com/akunzai/gistui/archive/refs/tags/v0.14.2.tar.gz"
  sha256 "e8f3c7a8a328a5f4ea0981951d424141d6f6509102a5a847cf1e2c01b00355b3"
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
