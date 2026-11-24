cask "pumice" do
  arch arm: "arm64", intel: "x64"

  version "0.2.15"
  sha256 arm:   "153a9ec4fe7968bb946ff539c02e2690bdeec7bda3115f339a2b8372bcf416bd",
         intel: "7e81ad44069813ec09e93506de957f8d2a7b1edcf3880c04ebdfc3a237993c27"

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
  postflight_steps do
    run "/usr/bin/xattr",
        args: ["-dr", "com.apple.quarantine", "{{appdir}}/Pumice.app"]
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
