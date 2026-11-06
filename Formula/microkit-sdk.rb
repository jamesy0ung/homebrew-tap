class MicrokitSdk < Formula
  desc "SDK for building seL4 Microkit systems"
  homepage "https://github.com/seL4/microkit"
  url "https://github.com/seL4/microkit/releases/download/2.4.0/microkit-sdk-2.4.0-macos-aarch64.tar.gz"
  sha256 "37b710257ac1f6e2a511d8acb7adb4d0953e3b8ac2f4c5ab3b021f81b1ecc094"
  license all_of: ["BSD-2-Clause", "GPL-2.0-only", "CC-BY-SA-4.0"]

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on :macos

  def install
    # Keep the SDK layout intact so MICROKIT_SDK can point at a stable opt path.
    libexec.install Dir["*"]
    # The tool infers the SDK from its own path, which a symlink would break.
    bin.write_exec_script libexec/"bin/microkit"
  end

  def caveats
    <<~EOS
      To use the SDK in your builds, add this to your ~/.zprofile (or equivalent):
        export MICROKIT_SDK="#{opt_libexec}"
    EOS
  end

  test do
    assert_equal version.to_s, (libexec/"VERSION").read.strip
    assert_path_exists libexec/"board/qemu_virt_aarch64/debug/elf"

    (testpath/"empty.system").write "<system />\n"
    output = shell_output("#{bin}/microkit --board qemu_virt_aarch64 --config debug empty.system 2>&1", 1)
    assert_match "at least one protection domain must be defined", output
  end
end
