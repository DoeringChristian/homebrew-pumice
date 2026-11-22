cask "pumice" do
  arch arm: "arm64", intel: "x64"

  version "0.2.10"
  sha256 arm:   "2ee2560a9cd6b089e0ff62093ef1aed78e03cf9fb222cea2305f6ecbb78d6b92",
         intel: "73f607af3e10e6585b33615f342b613c7c2310861fc7bdbeecb530f859a31e7b"

  url "https://github.com/DoeringChristian/pumice/releases/download/v#{version}/Pumice-#{version}-mac-#{arch}.dmg"
  name "Pumice"
  desc "Extensible, Obsidian-compatible markdown editor"
  homepage "https://github.com/DoeringChristian/pumice"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on :macos

  app "Pumice.app"

  # Pumice is not signed with an Apple Developer certificate. Without this, macOS refuses to
  # open the downloaded app.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Pumice.app"]
  end

  # Replacing the app under a running copy breaks it (it reads the new files with the old
  # layout), so quit it first.
  uninstall quit: "app.pumice.desktop"

  zap trash: [
    "~/Library/Application Support/Pumice",
    "~/Library/Logs/Pumice",
    "~/Library/Preferences/app.pumice.desktop.plist",
    "~/Library/Saved Application State/app.pumice.desktop.savedState",
  ]
end
