# homebrew-tap

A [Homebrew](https://brew.sh) tap for [`gistui`](https://github.com/akunzai/gistui) — a
terminal UI for managing GitHub Gists.

## Install

```bash
brew install akunzai/tap/gistui
```

Or tap first, then install:

```bash
brew tap akunzai/tap
brew install gistui
```

`gistui` shells out to the GitHub CLI (`gh`) at runtime; the formula installs it as a
dependency. Authenticate once with `gh auth login`.

### Latest `main`

```bash
brew install --HEAD akunzai/tap/gistui
```

## Updating the formula

When a new `gistui` version is released, bump `url` and `sha256` in
[`Formula/gistui.rb`](Formula/gistui.rb):

```bash
curl -sL https://github.com/akunzai/gistui/archive/refs/tags/vX.Y.Z.tar.gz | shasum -a 256
```

Then update the `url` tag and paste the new checksum.
