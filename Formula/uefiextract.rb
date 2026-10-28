class Uefiextract < Formula
  desc "Extract and dump UEFI firmware images"
  homepage "https://github.com/LongSoft/UEFITool"
  url "https://github.com/LongSoft/UEFITool/releases/download/A76/UEFIExtract_NE_A76_universal_mac.zip"
  version "A76"
  sha256 "f3c5ca9402df3c14b28242dcd04b527791a12c1c0bf3c1cbbb3d1a0445168ec5"
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
