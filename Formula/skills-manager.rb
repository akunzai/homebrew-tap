class SkillsManager < Formula
  desc "Keep skills in sync across AI coding agents"
  homepage "https://akunzai.github.io/skills-manager/"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/akunzai/skills-manager/releases/download/v0.25.0/skills_darwin_amd64.tar.gz"
      sha256 "0168891cbb4bf5e312700f945dea1ad569480f4800b54de0d23c38f0a68496a4"
    end
    if Hardware::CPU.arm?
      url "https://github.com/akunzai/skills-manager/releases/download/v0.25.0/skills_darwin_arm64.tar.gz"
      sha256 "58765f8238acca322bc1b047ea1699f831243b821512aa38a945a395e2cb2df1"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/akunzai/skills-manager/releases/download/v0.25.0/skills_linux_amd64.tar.gz"
      sha256 "fedea6dc59c2dfe339b9b1f94d35ca9f7e1498561d365bd5e84f3087202fc9c8"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/akunzai/skills-manager/releases/download/v0.25.0/skills_linux_arm64.tar.gz"
      sha256 "3749292e7aa6711d6c9f6e11be460450c7ab2dc1d2de80e206a6e4bd97eef2df"
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
