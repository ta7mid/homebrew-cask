cask "vicinae" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: ".dmg", linux: "-#{arch}.AppImage"

  version "0.27.1"

  on_macos do
    sha256 "20d685d4f03845f8a555a14bc898dcd4d7e7d5f9ff3c9cf69e6cee945c653c65"

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
    sha256 arm64_linux:  "a4b85d0a2d24a949c4c23b22fc6e47ca98c3b5af51ed96b540942971a40f9b34",
           x86_64_linux: "060a3bf2dde7483404a39faee0a5695fc721aa1ac9c18eb5bcbee8a8406c8e6b"

    app_image "Vicinae-#{arch}.AppImage", target: "Vicinae.AppImage"

    zap trash: [
      "~/.cache/vicinae",
      "~/.config/vicinae",
      "~/.local/share/vicinae",
      "~/.local/state/vicinae",
    ]
  end

  url "https://github.com/vicinaehq/vicinae/releases/download/v#{version}/Vicinae#{os}",
      verified: "github.com/vicinaehq/vicinae/"
  name "Vicinae"
  desc "Application launcher and command palette"
  homepage "https://vicinae.com/"
end
