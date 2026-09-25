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
      url "https://github.com/akunzai/gistui/releases/download/v0.22.0/gistui-v0.22.0-x86_64-apple-darwin.tar.gz"
      sha256 "9f994f23ac7275fb59c6315f925dc56d810b7becd0114d5c535215946ca23a3f"
    end
    if Hardware::CPU.arm?
      url "https://github.com/akunzai/gistui/releases/download/v0.22.0/gistui-v0.22.0-aarch64-apple-darwin.tar.gz"
      sha256 "6dca48f31b0708a4edd7d557c572866e727350f91949b790f28c3306f49005a1"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/akunzai/gistui/releases/download/v0.22.0/gistui-v0.22.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e85c71e8e75bc77e3f9396cc0fc8f99ed961a8996b4b7a5b7a55502f4d832945"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/akunzai/gistui/releases/download/v0.22.0/gistui-v0.22.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "bdbda325e51a923c3c6ddb79f6b964b9722ef80f292b3a4b1fec45e54aa3075c"
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
