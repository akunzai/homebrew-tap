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
      url "https://github.com/akunzai/gistui/releases/download/v0.15.2/gistui-v0.15.2-x86_64-apple-darwin.tar.gz"
      sha256 "53cefed0fb6023054d72b8b2fb0c53baf8b06310d1fcf451a59bcdf0415722e8"
    end
    if Hardware::CPU.arm?
      url "https://github.com/akunzai/gistui/releases/download/v0.15.2/gistui-v0.15.2-aarch64-apple-darwin.tar.gz"
      sha256 "26e7dc84b369c56ce7a92f29589d1ca840bd853c4e31bddca799b51684645019"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/akunzai/gistui/releases/download/v0.15.2/gistui-v0.15.2-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "f2f3f81606dfa7898e70873286575bff158bf2cd55d054b1ab2f2d1267c5dea5"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/akunzai/gistui/releases/download/v0.15.2/gistui-v0.15.2-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "c8f80d2c412af5c02459ae4171c8dcb85c299e27f10c85eea17ac5b7f8e0b804"
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
