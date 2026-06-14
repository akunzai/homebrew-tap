class Gistui < Formula
  desc "Terminal UI for managing GitHub Gists"
  homepage "https://akunzai.github.io/gistui/"
  url "https://github.com/akunzai/gistui/archive/refs/tags/v0.8.0.tar.gz"
  sha256 "108de3cbcd8ad727d7166656c5dd743b81cf4fb3c1b65945e008f83c5454a2e7"
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
