# AGENTS.md

Guidance for AI assistants and maintainers working in this Homebrew tap.

> `CLAUDE.md` is a symbolic link to this file, so Claude Code reads the same guidance.
> Edit `AGENTS.md` — never edit `CLAUDE.md` directly.

## What this repo is

A [Homebrew](https://brew.sh) tap with one formula per app it ships, each installing a
prebuilt binary from that app's GitHub releases (per OS/arch):

- [`Formula/gistui.rb`](Formula/gistui.rb) — also supports `brew install --HEAD`
  (builds from source); depends on `gh` at runtime.
- [`Formula/duodiff.rb`](Formula/duodiff.rb) — prebuilt binaries only, no `head` build.
- [`Formula/skills-manager.rb`](Formula/skills-manager.rb) — prebuilt binaries only, no
  `head` build; declares `conflicts_with "skills"` because homebrew-core ships a
  different, Node-based formula of that name which also installs a `skills` executable.

User-facing install and tap-trust docs live in [`README.md`](README.md).

## Validating a formula change

```bash
brew style Formula/<name>.rb
brew audit --strict --online akunzai/tap/<name>
brew install akunzai/tap/<name>        # prebuilt-binary path
brew install --HEAD akunzai/tap/<name> # source-build path (gistui only)
```

## Updating a formula

Each app's own release workflow pushes its formula update directly — no manual step, no
PR, no polling:

- On every `vX.Y.Z` tag, after the GitHub Release and its per-platform assets are
  published, a step in that workflow clones this repo, regenerates the formula in full
  from the new version's checksums, and pushes straight to `main`.
- Requires the `HOMEBREW_BUMP_TOKEN` repository secret **in the app's own repo** (not
  here) — a Personal Access Token scoped to this tap (Contents read/write). If that
  secret is unset, the step is skipped and the formula is left for a manual bump.
- Every formula here uses `on_macos`/`on_linux` conditionals with a distinct
  `url`/`sha256` pair per OS/arch, which `brew bump-formula-pr` (and tools built on it,
  like `dawidd6/action-homebrew-bump-formula`) cannot update — see its own
  `# TODO: ... resources inside on_os or on_arch blocks` comment in
  `dev-cmd/bump-formula-pr.rb`. That's why this repo runs no daily bump workflow of its
  own.

### Manual bump (fallback)

gistui and duodiff publish one `.sha256` sidecar file per archive:

```bash
VERSION=vX.Y.Z
for target in x86_64-apple-darwin aarch64-apple-darwin x86_64-unknown-linux-gnu aarch64-unknown-linux-gnu; do
  curl -sL "https://github.com/akunzai/<app>/releases/download/${VERSION}/<app>-${VERSION}-${target}.tar.gz.sha256"
done
```

skills-manager publishes one combined `checksums.txt` instead:

```bash
VERSION=vX.Y.Z
curl -sL "https://github.com/akunzai/skills-manager/releases/download/${VERSION}/checksums.txt"
```

Either way, paste the new checksums into the matching `on_macos`/`on_linux` blocks in
the app's `Formula/<name>.rb` alongside the new version in each `url`.
