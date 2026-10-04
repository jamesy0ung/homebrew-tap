class Uefiextract < Formula
  desc "Extract and dump UEFI firmware images"
  homepage "https://github.com/LongSoft/UEFITool"
  url "https://github.com/LongSoft/UEFITool/releases/download/A75/UEFIExtract_NE_A75_universal_mac.zip"
  version "A75"
  sha256 "8cbdd6d42193d6fb8a0c37dc860b4695c618f923b8ecfff9c0042fbdd80aaa80"
  license "BSD-2-Clause"

  livecheck do
    url :stable
    regex(/^(A\d+)$/i)
    strategy :github_latest
  end

  depends_on :macos

  def install
    bin.install "UEFIExtract"
  end

  test do
    assert_match "NE alpha #{version.to_s.delete_prefix("A")}", shell_output("#{bin}/UEFIExtract --version")
  end
end
