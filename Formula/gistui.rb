class Gistui < Formula
  desc "Terminal UI for managing GitHub Gists"
  homepage "https://akunzai.github.io/gistui/"
  url "https://github.com/akunzai/gistui/archive/refs/tags/v0.9.0.tar.gz"
  sha256 "75fd557b7fadf6a8dfdeac884d954197529959689b21beffd691bec87ae7a99f"
  license "MIT"
  head "https://github.com/akunzai/gistui.git", branch: "main"

  depends_on "rust" => :build
  depends_on "gh" # gistui shells out to the GitHub CLI at runtime

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match "gistui", shell_output("#{bin}/gistui --help")
  end
end
