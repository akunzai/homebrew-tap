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
      url "https://github.com/akunzai/gistui/releases/download/v0.24.0/gistui-v0.24.0-x86_64-apple-darwin.tar.gz"
      sha256 "39789c2b6b8f7dfc8998d8b5096cf3c7fa95011740943d5017ccf83af934eed9"
    end
    if Hardware::CPU.arm?
      url "https://github.com/akunzai/gistui/releases/download/v0.24.0/gistui-v0.24.0-aarch64-apple-darwin.tar.gz"
      sha256 "cf565ce3bab5ed3c3481a663f0bcc14b63cc5c9d3f3652ce80f19253702b10a2"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/akunzai/gistui/releases/download/v0.24.0/gistui-v0.24.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "648fe858c813a27350a8b8a9f548147d9cc25b5150ba6642e571c6bc188f5604"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/akunzai/gistui/releases/download/v0.24.0/gistui-v0.24.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "488e60154bab21f9dbcf12b3b22f70542c694338252f5941ccba1ac3a7c6ea8c"
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
