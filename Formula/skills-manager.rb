class SkillsManager < Formula
  desc "Keep skills in sync across AI coding agents"
  homepage "https://akunzai.github.io/skills-manager/"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/akunzai/skills-manager/releases/download/v0.27.0/skills_darwin_amd64.tar.gz"
      sha256 "b7ecb827f141bc876ecaea0e97d548f4d0a140364768fa6d00e88730166aea14"
    end
    if Hardware::CPU.arm?
      url "https://github.com/akunzai/skills-manager/releases/download/v0.27.0/skills_darwin_arm64.tar.gz"
      sha256 "814f320433335dc85c012c3a66c5a8103ffd3e694bc27de366ad0d07f2838004"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/akunzai/skills-manager/releases/download/v0.27.0/skills_linux_amd64.tar.gz"
      sha256 "5fda2119baa1a7753b390a7b19b8d0656201345d3c008366d840b990efd53caa"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/akunzai/skills-manager/releases/download/v0.27.0/skills_linux_arm64.tar.gz"
      sha256 "90bc043efc281e4f80a9c21c386300ea7801a9637e852bcdb94cc4c25941634c"
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
