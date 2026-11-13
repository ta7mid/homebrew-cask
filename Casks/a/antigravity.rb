cask "antigravity" do
  arch arm: "arm", intel: "x64"
  livecheck_arch = on_arch_conditional arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"
  livecheck_os on_system_conditional macos: "mac", linux: "linux"
  file_ext on_system_conditional macos: "dmg", linux: "tar.gz"

  version "2.31.2,6470801290035200"
  sha256 arm:          "bf10914c6b28afb77bbbf553418315b2c9c5aa3d3a6f7b9b26868250603bc3e6",
         intel:        "f104596d88c34bbbc3f95293f5e612fbb4ffb4bf3f953cdf928e111a476cc678",
         arm64_linux:  "89e1deeb2ab77aedc6ddbcec53516b180745c6ba6c9ceaac3f6041eca358f902",
         x86_64_linux: "2bae263e1227bac7360456c167fbfc48a962f797af615e0dc206d7b13da85061"

  on_macos do
    auto_updates true
    depends_on macos: :ventura

    app "Antigravity.app"

    uninstall quit: "com.google.antigravity"

    zap trash: [
      "~/.antigravity",
      "~/.gemini/antigravity",
      "~/Library/Application Support/Antigravity",
      "~/Library/Application Support/com.apple.sharedfilelist/com.apple.LSSharedFileList.ApplicationRecentDocuments/com.google.antigravity.sfl*",
      "~/Library/Caches/com.google.antigravity",
      "~/Library/Caches/com.google.antigravity.ShipIt",
      "~/Library/HTTPStorages/com.google.antigravity",
      "~/Library/Logs/Antigravity",
      "~/Library/Preferences/ByHost/com.google.antigravity.ShipIt.*.plist",
      "~/Library/Preferences/com.google.antigravity.plist",
      "~/Library/Saved Application State/com.google.Antigravity.savedState",
    ]
  end
  on_linux do
  end

  url "https://storage.googleapis.com/antigravity-public/antigravity-hub/#{version.csv.first}-#{version.csv.second}/#{os}-#{arch}/Antigravity.#{file_ext}"
  name "Google Antigravity"
  desc "Agent orchestration platform"
  homepage "https://antigravity.google/product/antigravity-2"

  livecheck do
    url "https://antigravity-hub-auto-updater-974169037036.us-central1.run.app/manifest/latest-#{livecheck_arch}-#{livecheck_os}.yml?noCache=#{Time.now.to_i}"
    regex(%r{/v?(\d+(?:\.\d+)+)(?:-(\d+)?)/#{os}-#{arch}/Antigravity\.(?:dmg|zip|t)}i)
    strategy :electron_builder do |yaml, regex|
      yaml["files"]&.map do |item|
        match = item["url"]&.match(regex)
        next if match.blank?

        match[2].present? ? "#{match[1]},#{match[2]}" : match[1]
      end
    end
  end
end
