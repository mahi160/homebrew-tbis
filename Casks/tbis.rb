cask "tbis" do
  # version and sha256 are bumped by tbis's release workflow on every release
  version "0.7.0"
  sha256 "97c87fb730bb92ff32965e80506b1fef433c349fc5b8dabc49c2106a691e1470"

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
