class Uefifind < Formula
  desc "Search UEFI firmware images for byte patterns"
  homepage "https://github.com/LongSoft/UEFITool"
  url "https://github.com/LongSoft/UEFITool/releases/download/A76/UEFIFind_NE_A76_universal_mac.zip"
  version "A76"
  sha256 "390d3f6290a159d9424c6dcad08d2e3b0dade250f9f351ad922018965cadd0ae"
  license "BSD-2-Clause"

  livecheck do
    url :stable
    regex(/^(A\d+)$/i)
    strategy :github_latest
  end

  depends_on :macos

  def install
    bin.install "UEFIFind"
  end

  test do
    assert_match "NE alpha #{version.to_s.delete_prefix("A")}", shell_output("#{bin}/UEFIFind --version")
  end
end
