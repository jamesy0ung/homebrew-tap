class InsertDylib < Formula
  desc "Command-line utility for inserting a dylib load command into a Mach-O binary"
  homepage "https://github.com/tyilo/insert_dylib"
  head "https://github.com/tyilo/insert_dylib.git", branch: "master"

  livecheck do
    skip "No releases; head-only formula"
  end

  depends_on xcode: :build
  depends_on :macos

  def install
    xcodebuild "-project", "insert_dylib.xcodeproj",
               "-target", "insert_dylib",
               "-configuration", "Release",
               "SYMROOT=#{buildpath}/build",
               "MACOSX_DEPLOYMENT_TARGET=#{MacOS.version}",
               "CODE_SIGNING_ALLOWED=NO"
    bin.install "build/Release/insert_dylib"
  end

  test do
    (testpath/"test.c").write <<~C
      #include <stdio.h>
      int main(void) { printf("test\\n"); return 0; }
    C
    system ENV.cc, "test.c", "-o", "#{testpath}/test_bin"
    output = shell_output(
      "#{bin}/insert_dylib --all-yes /usr/lib/libfoo.dylib #{testpath}/test_bin #{testpath}/test_bin_patched 2>&1",
    )
    assert_match "Added LC_LOAD_DYLIB", output
  end
end
