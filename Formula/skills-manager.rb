class SkillsManager < Formula
  desc "Keep skills in sync across AI coding agents"
  homepage "https://akunzai.github.io/skills-manager/"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/akunzai/skills-manager/releases/download/v0.26.0/skills_darwin_amd64.tar.gz"
      sha256 "3404d7feb759660ac2fcca4341ad9117e7acb7c1c21d0425ebad23b93aff09cf"
    end
    if Hardware::CPU.arm?
      url "https://github.com/akunzai/skills-manager/releases/download/v0.26.0/skills_darwin_arm64.tar.gz"
      sha256 "636a89e8bd1c2c115b629d8cbb24135f43583f5c0cf2455e1ebeb87a9621b97c"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/akunzai/skills-manager/releases/download/v0.26.0/skills_linux_amd64.tar.gz"
      sha256 "5bf067c6dde62277ce504bc967ea2e5d2f7b035e2944296d387d97ea5b987bce"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/akunzai/skills-manager/releases/download/v0.26.0/skills_linux_arm64.tar.gz"
      sha256 "53d8fb063f8aecd84d4728100d54c8f5ae994cc2f16ffdfac38c24187fc67d60"
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
