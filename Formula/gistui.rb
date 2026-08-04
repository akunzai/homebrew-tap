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
      url "https://github.com/akunzai/gistui/releases/download/v0.17.1/gistui-v0.17.1-x86_64-apple-darwin.tar.gz"
      sha256 "364560a81d24d80daac5df9c95ab63a306191a7202bc9a7695da9b3de296c676"
    end
    if Hardware::CPU.arm?
      url "https://github.com/akunzai/gistui/releases/download/v0.17.1/gistui-v0.17.1-aarch64-apple-darwin.tar.gz"
      sha256 "faf4c694255d1b97e1af3810a5bcc01ce2b17924021984fca6923529818de624"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/akunzai/gistui/releases/download/v0.17.1/gistui-v0.17.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e68e53a484a35e2c9f757c3009e1c69aec6fd0c4626ad2ef80e91b55ddda9837"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/akunzai/gistui/releases/download/v0.17.1/gistui-v0.17.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "f49ae66b53767fd2b02b6b60288d4d7d316ee1d2ee4062bd540058c29690694c"
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
