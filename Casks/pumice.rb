cask "pumice" do
  arch arm: "arm64", intel: "x64"

  version "0.2.2"
  sha256 arm:   "50bdfe11890060de02b23b8698a971b350a04b4ea7b04491585162c81d0b3dbc",
         intel: "326dc882b1a58936fcb90c09e699e4970e26b2fe1df499a8026bbb52b784206a"

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
