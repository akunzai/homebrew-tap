class SkillsManager < Formula
  desc "Keep skills in sync across AI coding agents"
  homepage "https://akunzai.github.io/skills-manager/"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/akunzai/skills-manager/releases/download/v0.28.0/skills_darwin_amd64.tar.gz"
      sha256 "59f0871f78d531a5da573ce3917a1b075ba32288c1be665a8752d4fd21e2d7a5"
    end
    if Hardware::CPU.arm?
      url "https://github.com/akunzai/skills-manager/releases/download/v0.28.0/skills_darwin_arm64.tar.gz"
      sha256 "a90e547744f0cb6bf23cc0d5a71e3417f8daff6329f61f7cdbf6c9c7f6d484cd"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/akunzai/skills-manager/releases/download/v0.28.0/skills_linux_amd64.tar.gz"
      sha256 "d24d6937ddf84a7fc6467e5eff36050c0bc1575c66ddd822ddf2b5c28f4a3c1f"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/akunzai/skills-manager/releases/download/v0.28.0/skills_linux_arm64.tar.gz"
      sha256 "ec0554810d4e5846514b2bb84782792b314e3d4b60e11f15366996279299a0ad"
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
