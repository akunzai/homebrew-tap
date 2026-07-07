# AGENTS.md

Guidance for AI assistants and maintainers working in this Homebrew tap.

> `CLAUDE.md` is a symbolic link to this file, so Claude Code reads the same guidance.
> Edit `AGENTS.md` — never edit `CLAUDE.md` directly.

## What this repo is

A [Homebrew](https://brew.sh) tap that ships the `gistui` formula. The single formula,
[`Formula/gistui.rb`](Formula/gistui.rb), installs a prebuilt binary from each GitHub release
(per OS/arch), with `brew install --HEAD` building from source; depends on `gh` at runtime.
User-facing install and tap-trust docs live in [`README.md`](README.md).

## Validating a formula change

```bash
brew style Formula/gistui.rb
brew audit --strict --online akunzai/tap/gistui
brew install akunzai/tap/gistui        # prebuilt-binary path
brew install --HEAD akunzai/tap/gistui # source-build path
```

## Updating the formula

`gistui`'s own [release.yml](https://github.com/akunzai/gistui/blob/main/.github/workflows/release.yml)
pushes the formula update directly — no manual step, no PR, no polling:

- On every `vX.Y.Z` tag, after the GitHub Release and its per-platform assets
  (and `.sha256` sidecars) are published, a step in that workflow clones this
  repo, regenerates `Formula/gistui.rb` in full from the new version's
  checksums, and pushes straight to `main`.
- Requires the `HOMEBREW_BUMP_TOKEN` repository secret **in the `gistui`
  repo** (not here) — a Personal Access Token scoped to this tap (Contents
  read/write). If that secret is unset, the step is skipped and the formula
  is left for a manual bump.
- The formula uses `on_macos`/`on_linux` conditionals with a distinct
  `url`/`sha256` pair per OS/arch, which `brew bump-formula-pr` (and tools
  built on it, like `dawidd6/action-homebrew-bump-formula`) cannot update —
  see its own `# TODO: ... resources inside on_os or on_arch blocks` comment
  in `dev-cmd/bump-formula-pr.rb`. That's why this repo no longer runs its
  own daily bump workflow.

### Manual bump (fallback)

```bash
VERSION=vX.Y.Z
for target in x86_64-apple-darwin aarch64-apple-darwin x86_64-unknown-linux-gnu aarch64-unknown-linux-gnu; do
  curl -sL "https://github.com/akunzai/gistui/releases/download/${VERSION}/gistui-${VERSION}-${target}.tar.gz.sha256"
done
```

Paste the four checksums into the matching `on_macos`/`on_linux` blocks in
`Formula/gistui.rb` alongside the new version in each `url`.
