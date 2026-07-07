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
      url "https://github.com/akunzai/gistui/releases/download/v0.15.0/gistui-v0.15.0-x86_64-apple-darwin.tar.gz"
      sha256 "8956fa3e440df7971ef417a170239c39f5f59771bf528c32176706030bcea69d"
    end
    if Hardware::CPU.arm?
      url "https://github.com/akunzai/gistui/releases/download/v0.15.0/gistui-v0.15.0-aarch64-apple-darwin.tar.gz"
      sha256 "5615f7cc67471c8b8cfd54751bda700d0b56b513396d644b6a8e7121bc900454"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/akunzai/gistui/releases/download/v0.15.0/gistui-v0.15.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "4cdb17c5a03341bd48afc24e425dc3f3739f6869a68658ee9847540452a2b45b"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/akunzai/gistui/releases/download/v0.15.0/gistui-v0.15.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "43f96ea43340050c8c40193938af344e995517186ec77cebfc6e3d3b3cf7e28f"
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
