cask "pumice" do
  arch arm: "arm64", intel: "x64"

  version "0.2.4"
  sha256 arm:   "ecbf56bc6b7243c2375e7c867e9c281879735bb24337fde1604fa691334e4809",
         intel: "c38d69a44dc525e8b88f580e770068508f89038d52a585852f19e5cdc0d61e0d"

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
