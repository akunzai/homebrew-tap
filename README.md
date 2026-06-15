# homebrew-tap

A [Homebrew](https://brew.sh) tap for [`gistui`](https://github.com/akunzai/gistui) — a
terminal UI for managing GitHub Gists.

## Install

Installing by the **fully-qualified name** trusts only this formula and works in one step:

```bash
brew install akunzai/tap/gistui
```

`gistui` shells out to the GitHub CLI (`gh`) at runtime; the formula installs it as a
dependency. Authenticate once with `gh auth login`.

## Tap trust (Homebrew 6.0.0+)

A tap can contain arbitrary Ruby that runs with your privileges, so since
[Homebrew 6.0.0](https://brew.sh/2026/06/11/homebrew-6.0.0/) a non-official tap must be
**explicitly trusted** before Homebrew evaluates its code (see the
[Tap-Trust docs](https://docs.brew.sh/Tap-Trust)).

- The fully-qualified `brew install akunzai/tap/gistui` above **trusts only the `gistui`
  formula** — nothing else from the tap — so no extra step is needed. This is the
  recommended form.
- If you instead tap and install by short name, trust the formula (or the whole tap) first:

  ```bash
  brew tap akunzai/tap
  brew trust --formula akunzai/tap/gistui   # trust just gistui (preferred)
  # or: brew trust akunzai/tap              # trust every current & future item in the tap
  brew install gistui
  ```

- In a [`Brewfile`](https://docs.brew.sh/Brew-Bundle-and-Brewfile), mark the entry trusted:

  ```ruby
  brew "akunzai/tap/gistui", trusted: true
  ```

### Latest `main`

```bash
brew install --HEAD akunzai/tap/gistui
```

Maintainer and automation notes (formula auto-bump, validation) live in
[`AGENTS.md`](AGENTS.md).
