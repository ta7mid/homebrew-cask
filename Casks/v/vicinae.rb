cask "vicinae" do
  url_end = on_system_conditional macos: "dmg", linux: "AppImage"

  version "0.28.2"
  sha256 arm:          "774ab055c8033799d7190ec8a5e958811fc835d3e7ac9253ac9b14eaa94cdd35",
         arm64_linux:  "13c524217f9fc9bb3b0b512074c3ab5ac2e42f78639ca891d1debd40d52a2f89",
         x86_64_linux: "4d32f7589f857ee6229da95269c6a3109fc3093152c2d6f29042f7d924fe86bc"

  on_macos do
    depends_on arch: :arm64
    depends_on macos: :sonoma

    app "Vicinae.app"
    binary "#{appdir}/Vicinae.app/Contents/MacOS/vicinae-cli", target: "vicinae"

    zap trash: [
      "~/.cache/vicinae",
      "~/.config/vicinae",
      "~/.local/share/vicinae",
      "~/.local/state/vicinae",
      "~/Library/Caches/com.vicinaehq.Vicinae",
      "~/Library/Caches/vicinae",
      "~/Library/HTTPStorages/com.vicinaehq.Vicinae",
    ]
  end
  on_linux do
    arch arm: "-aarch64", intel: "-x86_64"

    app_image "Vicinae#{arch}.AppImage", target: "Vicinae.AppImage"
    binary "Vicinae-#{arch}.AppImage", "vicinae"

    zap trash: [
      "~/.cache/vicinae",
      "~/.config/vicinae",
      "~/.local/share/vicinae",
      "~/.local/state/vicinae",
    ]
  end

  url "https://github.com/vicinaehq/vicinae/releases/download/v#{version}/Vicinae#{arch}.#{url_end}"
  name "Vicinae"
  desc "Application launcher and command palette"
  homepage "https://vicinae.com/"
end
