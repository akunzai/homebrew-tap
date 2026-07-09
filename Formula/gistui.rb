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
      url "https://github.com/akunzai/gistui/releases/download/v0.17.0/gistui-v0.17.0-x86_64-apple-darwin.tar.gz"
      sha256 "df47b8585dca4d653bf3d17537c7928e1f11251ccc4e3f8bc88ad581e5717aec"
    end
    if Hardware::CPU.arm?
      url "https://github.com/akunzai/gistui/releases/download/v0.17.0/gistui-v0.17.0-aarch64-apple-darwin.tar.gz"
      sha256 "e5bc585e1ca66190d68ab41273f3dc8e377e10afabf1048df23cc04ff14f0a6d"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/akunzai/gistui/releases/download/v0.17.0/gistui-v0.17.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "80984e6e863946c37e02df7883e890609183d9cbc8785c216735e3aac12f9060"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/akunzai/gistui/releases/download/v0.17.0/gistui-v0.17.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e2694fd917c614ed0b8da086876bb9855757e3eda83d205af9a1332c0799a40d"
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
