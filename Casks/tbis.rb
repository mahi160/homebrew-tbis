cask "tbis" do
  # version and sha256 are bumped by tbis's release workflow on every release
  version "0.10.0"
  sha256 "5faf45cffdad04583bc0bf83b2bc16b38ecac8b638ec1f45c22cddcffc04aaa0"

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
