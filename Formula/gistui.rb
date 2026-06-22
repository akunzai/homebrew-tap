class Gistui < Formula
  desc "Terminal UI for managing GitHub Gists"
  homepage "https://akunzai.github.io/gistui/"
  url "https://github.com/akunzai/gistui/archive/refs/tags/v0.14.1.tar.gz"
  sha256 "8c0d3401bc7b88cf2fb1fefb2116a13381e94615cf4b790efdc0b4d3854ace84"
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
