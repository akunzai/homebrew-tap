class SkillsManager < Formula
  desc "Keep skills in sync across AI coding agents"
  homepage "https://akunzai.github.io/skills-manager/"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/akunzai/skills-manager/releases/download/v0.21.0/skills_darwin_amd64.tar.gz"
      sha256 "7cd1d31fc461a50f426cfbeee54984e9709795cd313a65a50aef83417dc9da68"
    end
    if Hardware::CPU.arm?
      url "https://github.com/akunzai/skills-manager/releases/download/v0.21.0/skills_darwin_arm64.tar.gz"
      sha256 "e6242a5ff064a7e47300320b77ef62b1718da768ee2f62eda178c8fb31059487"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/akunzai/skills-manager/releases/download/v0.21.0/skills_linux_amd64.tar.gz"
      sha256 "fda30ab34af8adf70804683d4ac7fbcfac68fa3d1c7483a2a85bcf4b819ccb92"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/akunzai/skills-manager/releases/download/v0.21.0/skills_linux_arm64.tar.gz"
      sha256 "bd19e3a8b8e0ffd71c076faeb658f1679b9bf24e25d24da0a165f41f7ea6e44c"
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
