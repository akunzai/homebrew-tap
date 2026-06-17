class Gistui < Formula
  desc "Terminal UI for managing GitHub Gists"
  homepage "https://akunzai.github.io/gistui/"
  url "https://github.com/akunzai/gistui/archive/refs/tags/v0.11.0.tar.gz"
  sha256 "d6daa85f60098616c1c4fabee8ea99fefec8f73bd5a695aa8e56e3ecbc45c3df"
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
