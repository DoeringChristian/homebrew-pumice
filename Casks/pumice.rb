cask "pumice" do
  arch arm: "arm64", intel: "x64"

  version "0.2.11"
  sha256 arm:   "a357cfab76473ec14a38176fa4fc9978f8f26bbdc1ca4bae94a0b84406d4bcf9",
         intel: "ead071d0b408d726018ca18102b81f3f3db81546189d22c3afa3a14bf440a4eb"

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
