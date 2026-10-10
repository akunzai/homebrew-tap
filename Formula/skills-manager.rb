class SkillsManager < Formula
  desc "Keep skills in sync across AI coding agents"
  homepage "https://akunzai.github.io/skills-manager/"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/akunzai/skills-manager/releases/download/v0.24.0/skills_darwin_amd64.tar.gz"
      sha256 "5c505243d805341834dba8f1b43de09ca530b2fc4df16e4a15dcad80fe7aec73"
    end
    if Hardware::CPU.arm?
      url "https://github.com/akunzai/skills-manager/releases/download/v0.24.0/skills_darwin_arm64.tar.gz"
      sha256 "6f20a4268f76440ea738eb9c89ee955baa6a7ff46bee7e9b4a99e882fca84656"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/akunzai/skills-manager/releases/download/v0.24.0/skills_linux_amd64.tar.gz"
      sha256 "fb794394fe380577a5f2e0eedf3ee95b4d1e59bddac969d6cc588bbf449caeda"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/akunzai/skills-manager/releases/download/v0.24.0/skills_linux_arm64.tar.gz"
      sha256 "2b23bc5355587ebb242159681812ce8af1b71aa9fbdd5ea3240548aca28e2f89"
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
