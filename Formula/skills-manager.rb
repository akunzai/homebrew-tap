class SkillsManager < Formula
  desc "Keep skills in sync across AI coding agents"
  homepage "https://akunzai.github.io/skills-manager/"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/akunzai/skills-manager/releases/download/v0.22.1/skills_darwin_amd64.tar.gz"
      sha256 "004a255b2f781aab0f07163c6f3249b20efbc8e3f030f92ff19256ad78f72f88"
    end
    if Hardware::CPU.arm?
      url "https://github.com/akunzai/skills-manager/releases/download/v0.22.1/skills_darwin_arm64.tar.gz"
      sha256 "294c5f7b8178f11907206c3a82fb28e972c595f88cdacef2a2fd5a47ef9ce6b7"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/akunzai/skills-manager/releases/download/v0.22.1/skills_linux_amd64.tar.gz"
      sha256 "95e702d655e4cbde1099ff1846c4170fa54b8b4f561f2d1c11b557edbf091db0"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/akunzai/skills-manager/releases/download/v0.22.1/skills_linux_arm64.tar.gz"
      sha256 "433d4ab75376ccd54aad34091791131d6463a60bb6bbe51e1ff3b6a659e0f7de"
    end
  end

  # homebrew-core ships a different, Node-based formula also named "skills"
  # that installs its own `skills` executable.
  conflicts_with "skills", because: "both install a skills executable"

  def install
    bin.install "skills"
  end

  test do
    assert_match "skills-manager #{version}", shell_output("#{bin}/skills version")
  end
end
