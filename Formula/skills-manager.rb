class SkillsManager < Formula
  desc "Keep skills in sync across AI coding agents"
  homepage "https://akunzai.github.io/skills-manager/"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/akunzai/skills-manager/releases/download/v0.18.0/skills_darwin_amd64.tar.gz"
      sha256 "16d16ac0481e013475e29b51344c07f7a57ee4f5609fc498d648656c81a4ec24"
    end
    if Hardware::CPU.arm?
      url "https://github.com/akunzai/skills-manager/releases/download/v0.18.0/skills_darwin_arm64.tar.gz"
      sha256 "caa7732268e4afc324a64881d1bd541e0193153a190357df0b2a8c001a692f41"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/akunzai/skills-manager/releases/download/v0.18.0/skills_linux_amd64.tar.gz"
      sha256 "95d8b18b903d9d69cc99ee253fbddf4a54f2c9da9af609d87946d107c878bfc7"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/akunzai/skills-manager/releases/download/v0.18.0/skills_linux_arm64.tar.gz"
      sha256 "f5e0707e53aeb405d21aea22c7059a2ee46a50d11d3fcc680315cec310086ae5"
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
