cask "tbis" do
  # version and sha256 are bumped by tbis's release workflow on every release
  version "0.3.0"
  sha256 "ffa0b8c8d4d699a3b02116e171d475379de45e5fa7642431ae8fc1a276eb6e92"

  url "https://github.com/mahi160/tbis/releases/download/v#{version}/tbis-#{version}-macos-arm64.zip"
  name "tbis"
  desc "Native Jellyfin client with embedded mpv playback"
  homepage "https://github.com/mahi160/tbis"

  livecheck do
    url :url
    strategy :github_latest
  end

  # tbis updates itself from GitHub Releases; brew upgrade leaves it alone
  # unless run with --greedy
  auto_updates true
  # the release bundles arm64 Homebrew libraries, including libmpv
  depends_on arch: :arm64
  depends_on :macos

  app "tbis.app"

  # tbis is ad-hoc signed, not notarized (no Apple Developer ID yet), so
  # Gatekeeper blocks it until the quarantine attribute is cleared
  postflight_steps do
    run "/usr/bin/xattr",
        args:           ["-cr", "{{appdir}}/tbis.app"],
        writable_paths: ["tbis.app"],
        writable_base:  :appdir
  end

  zap trash: [
    "~/Library/Application Support/tbis",
    "~/Library/Saved Application State/io.github.mahi160.tbis.savedState",
  ]
end
