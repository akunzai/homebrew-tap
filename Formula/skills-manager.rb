class SkillsManager < Formula
  desc "Keep skills in sync across AI coding agents"
  homepage "https://akunzai.github.io/skills-manager/"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/akunzai/skills-manager/releases/download/v0.19.0/skills_darwin_amd64.tar.gz"
      sha256 "1c37913bb35eae47076f93d719478a89665e55935942ace83650f4b0a0227096"
    end
    if Hardware::CPU.arm?
      url "https://github.com/akunzai/skills-manager/releases/download/v0.19.0/skills_darwin_arm64.tar.gz"
      sha256 "f6b8fa66853f152e92c429196bc08039017b27168d2bb2f4001545aebe9d0dad"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/akunzai/skills-manager/releases/download/v0.19.0/skills_linux_amd64.tar.gz"
      sha256 "a69d995c7d5f33f6c8ff70b4f3167d5068f677071739ad25edefea3d912330cd"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/akunzai/skills-manager/releases/download/v0.19.0/skills_linux_arm64.tar.gz"
      sha256 "c24b5d033d7ba5f4014e6e28bb283f7145d5d4ff16a6aa080df9228a18eb669f"
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
