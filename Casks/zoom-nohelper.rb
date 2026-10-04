cask "zoom-nohelper" do
  arch arm: "arm64/"

  version "7.2.2.88465"
  sha256 arm:   "4cfee3ee21dcf8281584e3aa0ffe02e950bf7a4b40b8ac952f8e30e1af063ce9",
         intel: "e4fe2dea4a7cb6ece874186f9c4b90c996cdbc682cd8fd6c024c799492a413d2"

  url "https://cdn.zoom.us/prod/#{version}/#{arch}Zoom.pkg"
  name "Zoom"
  desc "Video communication and virtual meeting platform, without the ZoomDaemon helper"
  homepage "https://www.zoom.us/"

  livecheck do
    url "https://zoom.us/client/latest/Zoom.pkg"
    regex(%r{/prod/v?(\d+(?:\.\d+)+)/}i)
    strategy :header_match
  end

  conflicts_with cask: "zoom"
  depends_on :macos

  app "expanded/zoomus.pkg/Payload/zoom.us.app"

  # Extract the app from the pkg payload instead of running the installer,
  # so the postinstall script (which installs ZoomDaemon) never runs.
  preflight_steps do
    run "/usr/sbin/pkgutil",
        args:           ["--expand-full", "{{staged_path}}/Zoom.pkg", "{{staged_path}}/expanded"],
        writable_paths: ["{{staged_path}}"]
    remove "Zoom.pkg"
  end

  uninstall quit: "us.zoom.xos"

  zap trash: [
    "~/.zoomus",
    "~/Library/Application Support/zoom.us",
    "~/Library/Caches/us.zoom.xos",
    "~/Library/Cookies/us.zoom.xos.binarycookies",
    "~/Library/HTTPStorages/us.zoom.xos",
    "~/Library/Logs/zoom.us",
    "~/Library/Logs/zoominstall.log",
    "~/Library/Preferences/us.zoom.*.plist",
    "~/Library/Preferences/ZoomChat.plist",
    "~/Library/Saved Application State/us.zoom.xos.savedState",
    "~/Library/WebKit/us.zoom.xos",
  ]
end
