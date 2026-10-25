cask "signal@beta" do
  arch arm: "arm64", intel: "x64"
  os macos: "mac", linux: "linux"
  separator = on_system_conditional macos: "-mac-#{arch}-", linux: "_"
  url_end = on_system_conditional macos: ".zip", linux: "_x86_64.AppImage"

  version "8.33.0-beta.1"
  sha256 arm:          "d019385f6f70f536749c8ba1e52ce0a8b8c38eecd37f2e56d51fc5171b2ef111",
         intel:        "aebab1a6dae61e2aa4aa7ffc1e5c806483f9f5e32d0e8a651e3fb46076c34ae7",
         x86_64_linux: "67dc5a9487121d32dc85ae70178dadf655cc0a01d9894de06b86b45192d35cf0"

  on_macos do
    depends_on macos: :ventura

    app "Signal Beta.app"

    zap trash: [
      "~/Library/Application Support/com.apple.sharedfilelist/com.apple.LSSharedFileList.ApplicationRecentDocuments/org.whispersystems.signal-desktop-beta.sfl*",
      "~/Library/Application Support/Signal Beta",
      "~/Library/Application Support/Signal",
      "~/Library/Preferences/org.whispersystems.signal-desktop-beta.plist",
      "~/Library/Preferences/org.whispersystems.signal-desktop.helper.plist",
      "~/Library/Preferences/org.whispersystems.signal-desktop.plist",
      "~/Library/Saved Application State/org.whispersystems.signal-desktop.savedState",
    ]
  end
  on_linux do
    depends_on arch: :x86_64

    app_image "signal-desktop.AppImage", target: "Signal.AppImage"

    zap trash: "~/.config/Signal AppImage"
  end

  url "https://updates.signal.org/desktop/signal-desktop#{separator}#{version}#{url_end}"
  name "Signal Beta"
  desc "Instant messaging application focusing on security"
  homepage "https://signal.org/"

  livecheck do
    url "https://updates.signal.org/desktop/beta-#{os}.yml"
    strategy :electron_builder
  end

  auto_updates true
end
