cask "rex@beta" do
  version "0.1.0,1717"
  sha256 "9dab37ac7745a048fe0b02fff3bb5080b2f87e7bf81e4e902c4cfbb2192e2a28"

  url "https://blob.superlogical.com/public/rex-app/snapshot/Rex-#{version.csv.first}-#{version.csv.second}.dmg"
  name "Rex Beta"
  desc "Terminal emulator and multiplexer with persistent sessions"
  homepage "https://www.superlogical.com/rex/"

  livecheck do
    url "https://blob.superlogical.com/public/rex-app/snapshot/appcast.xml"
    strategy :sparkle
  end

  auto_updates true
  depends_on macos: :sequoia

  app "Rex Beta.app"

  uninstall launchctl: "com.superlogical.rex.server.*",
            quit:      "com.superlogical.rex"

  zap trash: [
    "~/Library/Application Support/com.superlogical.rex",
    "~/Library/Application Support/rex",
    "~/Library/Caches/com.superlogical.rex",
    "~/Library/HTTPStorages/com.superlogical.rex",
    "~/Library/Preferences/com.superlogical.rex.plist",
  ]
end
