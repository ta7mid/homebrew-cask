cask "seaquel" do
  arch arm: "aarch64", intel: on_system_conditional(macos: "x64", linux: "amd64")
  file_ext = on_system_conditional macos: "dmg", linux: "AppImage"

  version "2026.9.2"
  sha256 arm:          "ef7c08a62b4237408f51cab1588708a7348036f6514a4337c70f74d38aa80696",
         intel:        "78806282e740cd41c159ec6065652ceb0b7e6e7322a72b08f141d208f30a4f10",
         arm64_linux:  "b785f8aa5ecae981fcf0fc7c99d1ed3987da67693753ef92d05aefc443737408",
         x86_64_linux: "25380895bd75cdf508adda8f931ba84f3ebf2ab77418b012e2421d11aeab7ef6"

  on_macos do
    auto_updates true

    app "Seaquel.app"

    zap trash: [
      "~/Library/Application Support/app.seaquel.desktop",
      "~/Library/Caches/seaquel",
      "~/Library/Logs/app.seaquel.desktop",
      "~/Library/Preferences/seaquel.plist",
      "~/Library/WebKit/seaquel",
    ]
  end
  on_linux do
    app_image "Seaquel_#{version}_#{arch}.AppImage", target: "Seaquel.AppImage"
  end

  url "https://github.com/webstonehq/seaquel/releases/download/v#{version}/Seaquel_#{version}_#{arch}.#{file_ext}"
  name "Seaquel"
  desc "Database client for exploring, querying and visualising data"
  homepage "https://seaquel.app/"
end
