class SkillsManager < Formula
  desc "Keep skills in sync across AI coding agents"
  homepage "https://akunzai.github.io/skills-manager/"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/akunzai/skills-manager/releases/download/v0.20.0/skills_darwin_amd64.tar.gz"
      sha256 "2f5feaefc8d8a5f69f6e11f83b35b4b5e6f92b173de0390a0d941cb448e929cd"
    end
    if Hardware::CPU.arm?
      url "https://github.com/akunzai/skills-manager/releases/download/v0.20.0/skills_darwin_arm64.tar.gz"
      sha256 "bc00a5e294b13df71820dea49721e3ebdb9ac4c820f3c8f7ac4364394fb2914d"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/akunzai/skills-manager/releases/download/v0.20.0/skills_linux_amd64.tar.gz"
      sha256 "1b78519b2d1e87f2c728b1bf2f488fa3e1a0cd43aecde01d8618dd88f9b80c75"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/akunzai/skills-manager/releases/download/v0.20.0/skills_linux_arm64.tar.gz"
      sha256 "d076b2002547988b5f20b4da0534e5647f4b6885800038b7156e58e62df4a769"
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
