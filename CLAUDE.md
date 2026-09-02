# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

A personal dotfiles repository — configuration files for shell, editors, and terminal multiplexer, plus scripts to bootstrap a new machine. There is no build, lint, or test suite; changes are validated by sourcing/reloading the relevant tool and checking it behaves as expected.

## Layout and how pieces connect

- `bootstrap-mac.sh` — idempotent bootstrap for a fresh macOS machine. Installs Xcode CLT, Homebrew, clones this repo to `~/work/dotfiles`, runs `brew bundle` against `Brewfile`, installs Oh My Zsh, then symlinks config files into place (`zshrc` → `~/.zshrc`, `zprofile` → `~/.zprofile`, `vim/vimrc` → `~/.vimrc`, `tmux.conf` → `~/.tmux.conf`, `gitconfig` → `~/.gitconfig`, `ssh/config` → `~/.ssh/config`). It backs up any pre-existing real file as `<file>.bak` before symlinking. It also points iTerm2 at `iterm2/` as its custom prefs folder, then finishes by calling `macos-defaults.sh`.
- `macos-defaults.sh` — standalone, re-runnable `defaults write` tweaks (keyboard repeat rate, trackpad, Finder, Dock, screenshots). Can be run on its own or via `bootstrap-mac.sh`.
- There is no Linux bootstrap script currently (the old `install.sh` was stale and removed) — only `ubuntu.bashrc`/`vdi.bashrc` and `vdi.tmux.conf` exist for Linux, meant to be wired up manually or restored by hand until a replacement script exists.
- `Brewfile` — Homebrew bundle (formulae, casks, VS Code extensions, Mac App Store apps via `mas`). Kept in sync with what's actually installed; regenerate/diff with `brew bundle dump --force` on the Mac and fold in intentional additions (skip one-off/experimental installs). To snapshot currently installed App Store apps: `brew install mas && mas list >> Brewfile` (then hand-format each line as `mas "Name", id: NNNN`).
- `zshrc` / `zprofile` / `.bashrc` / `ubuntu.bashrc` / `vdi.bashrc` — shell configs for different environments (macOS zsh w/ Oh My Zsh, generic bash, Ubuntu, and a VDI/remote environment). These are separate, not layered — check which one is relevant to the environment being edited rather than assuming a single shared shell config. `zprofile` detects the Homebrew prefix (`/opt/homebrew` vs `/usr/local`) at shell startup so the same file works on Apple Silicon and Intel.
- `vdi.tmux.conf` vs `tmux.conf` — separate tmux configs for the VDI environment vs. normal use.
- `vim/vimrc` — Vim config (plain vimscript). There is no tracked Neovim config in this repo.
- `gitconfig` — symlinked to `~/.gitconfig`; note `user.email` is set here.
- `clangd` — clangd LSP config; not currently wired into any install script.
- `ssh/config` — symlinked to `~/.ssh/config`. Contains host aliases only (VDI box, personal VPS port-forwards) — never add private keys or credentials here.
- `iterm2/com.googlecode.iterm2.plist` — iTerm2's full preferences export. `bootstrap-mac.sh` configures iTerm2 to load/save prefs from this folder directly, so once linked, changes made in iTerm2's GUI write back here — re-export isn't needed. Re-run `defaults export com.googlecode.iterm2 iterm2/com.googlecode.iterm2.plist` only if that auto-sync wasn't set up on the machine being scavenged. **Before committing changes to this file, re-check it for secrets** (e.g. `grep -i apikey`) — iTerm2's AI integration can persist an API key into these prefs.

## Making changes

- When adding a new tool config, follow the existing pattern: add the file at the repo root (or under its own subdirectory, as `vim/` and `ssh/` do), then add a corresponding `link` call in `bootstrap-mac.sh`.
- Since these files are symlinked into `$HOME`, edits take effect for the user immediately without re-running the install script — only new files need a new symlink.
- Scripts use `set -euo pipefail` and are written to be safely re-run (idempotent); preserve that when editing them.
- The goal of this repo is that a fresh Mac or Linux box can be fully restored by running one script. When something is customized on a live machine but not tracked here, that's a gap — track it (respecting the secrets rule above) rather than leaving it as tribal knowledge on one machine.
