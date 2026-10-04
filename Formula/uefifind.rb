class Uefifind < Formula
  desc "Search UEFI firmware images for byte patterns"
  homepage "https://github.com/LongSoft/UEFITool"
  url "https://github.com/LongSoft/UEFITool/releases/download/A75/UEFIFind_NE_A75_universal_mac.zip"
  version "A75"
  sha256 "0de0261c407274a734b70b1a126e1fc334f572c93d340d2bafd58b4aee44ab88"
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
