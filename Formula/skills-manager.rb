class SkillsManager < Formula
  desc "Keep skills in sync across AI coding agents"
  homepage "https://akunzai.github.io/skills-manager/"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/akunzai/skills-manager/releases/download/v0.23.0/skills_darwin_amd64.tar.gz"
      sha256 "98a23f45d57b6be2e1e90eba0cf08df77e3abd9e2e2618a775e03e0732fb883f"
    end
    if Hardware::CPU.arm?
      url "https://github.com/akunzai/skills-manager/releases/download/v0.23.0/skills_darwin_arm64.tar.gz"
      sha256 "659a93b2d6db9292fd0eafa6abea96d22f0bfde7b60a1769e3eb2e8e91b0caeb"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/akunzai/skills-manager/releases/download/v0.23.0/skills_linux_amd64.tar.gz"
      sha256 "dc05c29ea4f3623b1089a84fefd32105191ad1afa84d5f778b42f1c81ddd203b"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/akunzai/skills-manager/releases/download/v0.23.0/skills_linux_arm64.tar.gz"
      sha256 "0b4e5e547421e7fda6de7a61476499848d005e2498cfb3b2dc585e89a492cf97"
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
