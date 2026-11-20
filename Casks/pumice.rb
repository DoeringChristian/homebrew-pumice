cask "pumice" do
  arch arm: "arm64", intel: "x64"

  version "0.1.0"
  sha256 arm:   "ef96d76edc64568413c4edfa046459017f8e1276f534548d1f222e8385721490",
         intel: "e282282540f4add4bb9b230a580748c1009e4b2abb695e4103b8aa5efdbd6eae"

  url "https://github.com/DoeringChristian/pumice/releases/download/v#{version}/Pumice-#{version}-mac-#{arch}.dmg"
  name "Pumice"
  desc "Extensible, Obsidian-compatible markdown editor"
  homepage "https://github.com/DoeringChristian/pumice"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :big_sur"

  app "Pumice.app"

  # Pumice is not signed with an Apple Developer certificate. Without this, macOS refuses to
  # open the downloaded app.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Pumice.app"]
  end

  zap trash: [
    "~/Library/Application Support/Pumice",
    "~/Library/Logs/Pumice",
    "~/Library/Preferences/app.pumice.desktop.plist",
    "~/Library/Saved Application State/app.pumice.desktop.savedState",
  ]
end
