# homebrew-tbis

Homebrew tap for [tbis](https://github.com/mahi160/tbis), a native macOS client for Jellyfin with embedded mpv playback.

```sh
brew install --cask mahi160/tbis/tbis
```

The cask clears the Gatekeeper quarantine for you, because tbis is ad-hoc signed and not notarized.

- **Apple Silicon only**, on macOS 11 or later. The app bundles its own mpv, so you don't need the `mpv` formula.
- **Updates:** tbis updates itself from GitHub Releases, so the cask is marked `auto_updates`. `brew upgrade` skips it unless you pass `--greedy`. The cask's version is bumped automatically by tbis's release workflow.
