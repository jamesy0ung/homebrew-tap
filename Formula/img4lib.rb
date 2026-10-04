class Img4lib < Formula
  desc "Parse, decrypt and modify Apple IMG4 firmware images"
  homepage "https://github.com/xerub/img4lib"
  url "https://github.com/xerub/img4lib/archive/69772c72f3c08f021ec9fa4c386f2b3df60a38b7.tar.gz"
  version "1.0-20211121"
  sha256 "ce224c5089ff58579950188c12138844ed4a062d046cbe4c29800358e56ba2ab"
  head "https://github.com/xerub/img4lib.git", branch: "master"

  livecheck do
    skip "No releases; pinned to the latest commit"
  end

  depends_on :macos

  def install
    # Use macOS libcompression for lzfse; the dylib only exists in the shared cache
    inreplace "Makefile", "/usr/lib/libcompression.dylib", "#{MacOS.sdk_path}/usr/lib/libcompression.tbd"
    system "make", "img4", "COMMONCRYPTO=1", "CC=#{ENV.cc}", "LD=#{ENV.cc}"
    bin.install "img4"
  end

  test do
    (testpath/"plain.bin").write "hello img4\n"
    system bin/"img4", "-i", "plain.bin", "-o", "test.im4p", "-A", "-T", "krnl", "-V", "1.0"
    assert_equal "1.0\n", shell_output("#{bin}/img4 -i test.im4p -v")
    system bin/"img4", "-i", "test.im4p", "-o", "out.bin"
    assert_equal "hello img4\n", (testpath/"out.bin").read
  end
end
