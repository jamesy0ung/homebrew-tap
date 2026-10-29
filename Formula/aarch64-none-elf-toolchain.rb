class Aarch64NoneElfToolchain < Formula
  desc "Arm GNU Toolchain for aarch64-none-elf (bare-metal AArch64 targets)"
  homepage "https://gitlab.arm.com/tooling/gnu-toolchains-for-arm"
  url "https://gitlab.arm.com/api/v4/projects/tooling%2Fgnu-toolchains-for-arm/packages/generic/gnu-toolchain/15.3.rel2/arm-gnu-toolchain-15.3.rel2-darwin-arm64-aarch64-none-elf.tar.xz"
  sha256 "33b43fb45fdb231b7785afdf67e5c3ebc06c0b55f4eec00eaf130d86db218de0"
  license all_of: ["GPL-3.0-or-later", "LGPL-3.0-or-later", "BSD-3-Clause"]

  livecheck do
    url "https://gitlab.arm.com/tooling/gnu-toolchains-for-arm/-/raw/main/README.md"
    regex(%r{\([^)]*?releases/v?(\d+(?:\.\d+)+(?:[._-]rel\d+)?)[?)]}i)
  end

  depends_on arch: :arm64
  depends_on :macos
  # aarch64-none-elf-gdb-py links against Homebrew's Python framework.
  depends_on "python@3.14"

  def install
    # Keep the toolchain layout intact; only expose the prefixed tools so the
    # bundled man/info pages don't clash with other GNU toolchains.
    libexec.install Dir["*"]
    bin.install_symlink Dir[libexec/"bin/*"]
  end

  test do
    (testpath/"test.c").write <<~C
      int add(int a, int b) { return a + b; }
      int main(void) { return add(1, 2); }
    C
    system bin/"aarch64-none-elf-gcc", "-c", "test.c", "-o", "test.o"
    assert_match "elf64-littleaarch64", shell_output("#{bin}/aarch64-none-elf-objdump -f test.o")
    assert_match version.to_s.sub(".rel", ".Rel"), shell_output("#{bin}/aarch64-none-elf-gcc --version")
  end
end
