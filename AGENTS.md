# AGENTS.md

Guidance for AI assistants and maintainers working in this Homebrew tap.

> `CLAUDE.md` is a symbolic link to this file, so Claude Code reads the same guidance.
> Edit `AGENTS.md` — never edit `CLAUDE.md` directly.

## What this repo is

A [Homebrew](https://brew.sh) tap that ships the `gistui` formula. The single formula,
[`Formula/gistui.rb`](Formula/gistui.rb), builds gistui from each GitHub release's source
tarball and depends on `gh` at runtime. User-facing install and tap-trust docs live in
[`README.md`](README.md).

## Validating a formula change

```bash
brew style Formula/gistui.rb
brew audit --strict --online akunzai/tap/gistui
brew install --build-from-source akunzai/tap/gistui   # full build + test
```

## Updating the formula

The [Bump formula](.github/workflows/bump.yml) workflow keeps the formula current
automatically — no manual step on release:

- Runs daily on a schedule and on demand (**Actions → Bump formula → Run workflow**).
- `brew livecheck` resolves the latest GitHub release via the formula's `livecheck` block
  (`strategy :github_latest`); [`dawidd6/action-homebrew-bump-formula`](https://github.com/dawidd6/action-homebrew-bump-formula)
  then opens a PR bumping `url` + `sha256`.

**Required secret — `HOMEBREW_BUMP_TOKEN`.** The action rejects the default `GITHUB_TOKEN`,
so a Personal Access Token must be set as a repository secret (Settings → Secrets and
variables → Actions):

- Classic PAT: `public_repo` + `workflow`, or
- Fine-grained, scoped to this tap: Contents read/write + Pull requests read/write.

Without it the workflow fails at the bump step.

### Manual bump (fallback)

```bash
curl -sL https://github.com/akunzai/gistui/archive/refs/tags/vX.Y.Z.tar.gz | shasum -a 256
```

Update the `url` tag and paste the new checksum into `Formula/gistui.rb`.
