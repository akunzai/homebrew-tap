class SkillsManager < Formula
  desc "Keep skills in sync across AI coding agents"
  homepage "https://akunzai.github.io/skills-manager/"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/akunzai/skills-manager/releases/download/v0.22.0/skills_darwin_amd64.tar.gz"
      sha256 "9f44f9a3af48f5f6408a5a4a46c90deb4989c6ef77e16af5c96dca96b8be28b8"
    end
    if Hardware::CPU.arm?
      url "https://github.com/akunzai/skills-manager/releases/download/v0.22.0/skills_darwin_arm64.tar.gz"
      sha256 "6bd7f0700bb7baaecf3b5d8764198614bd5873c952a9dad69648b88a1368db95"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/akunzai/skills-manager/releases/download/v0.22.0/skills_linux_amd64.tar.gz"
      sha256 "cba7e3440ea04a8f70dfe8f78f3701489c39f0d4068bb821d24b0d0d544b2bfc"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/akunzai/skills-manager/releases/download/v0.22.0/skills_linux_arm64.tar.gz"
      sha256 "7fc62c65aeb1f9dcd1f74ac51714f8cff33d398b8a392abcaeb9f40d509ecc12"
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
