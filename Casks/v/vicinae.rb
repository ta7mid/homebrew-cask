cask "vicinae" do
  version "0.29.1"
  sha256 arm:          "e83cef0f9ad5cff3172d4520054528e4f41de7d92cd0a4c0a7890ece4efd6e1f",
         x86_64_linux: "9d1130a64bbaf037ca21f8c4281f07caf7f03126f3fe299ff8aef8116ebf1546"

  on_macos do
    url "https://github.com/vicinaehq/vicinae/releases/download/v#{version}/Vicinae.dmg"

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
    url "https://github.com/vicinaehq/vicinae/releases/download/v#{version}/vicinae-linux-x86_64-v#{version}.tar.gz"

    depends_on arch: :x86_64

    binary "bin/vicinae"
    service "lib/systemd/user/vicinae.service"
    artifact "share/applications/vicinae.desktop", target: "~/.local/share/applications/vicinae.desktop"
    artifact "share/applications/vicinae-url-handler.desktop",
             target: "~/.local/share/applications/vicinae-url-handler.desktop"

    preflight_steps do
      inreplace "lib/systemd/user/vicinae.service", "ExecStart=vicinae",
                "ExecStart={{HOMEBREW_PREFIX}}/bin/vicinae"
      inreplace "share/applications/vicinae.desktop", "Exec=vicinae",
                "Exec={{HOMEBREW_PREFIX}}/bin/vicinae"
      inreplace "share/applications/vicinae.desktop", "Icon=vicinae",
                "Icon={{staged_path}}/vicinae.app/share/icons/hicolor/512x512/apps/vicinae.png"
      inreplace "share/applications/vicinae-url-handler.desktop", "Exec=vicinae",
                "Exec={{HOMEBREW_PREFIX}}/bin/vicinae"
      inreplace "share/applications/vicinae-url-handler.desktop", "Icon=vicinae",
                "Icon={{staged_path}}/vicinae.app/share/icons/hicolor/512x512/apps/vicinae.png"
    end
  end

  name "Vicinae"
  desc "Application launcher and command palette"
  homepage "https://vicinae.com/"
end
