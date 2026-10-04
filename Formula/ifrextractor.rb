class Ifrextractor < Formula
  desc "Extract UEFI Internal Form Representation (IFR) into human-readable text"
  homepage "https://github.com/LongSoft/IFRExtractor-RS"
  url "https://github.com/LongSoft/IFRExtractor-RS/releases/download/v1.6.1/ifrextractor_1.6.1_macos.zip"
  sha256 "5cd745dd58b07977d97adc3b07c6211cc8e51614f7628da3822ce154ff2e8308"
  license "BSD-2-Clause"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on :macos

  def install
    bin.install "ifrextractor"
  end

  test do
    assert_match "IFRExtractor RS v#{version}", shell_output(bin/"ifrextractor", 1)
  end
end
