class Whykey < Formula
  desc "Explain where a Linux key combination is handled"
  homepage "https://github.com/agustinrojas1/whykey"
  license "MIT"

  depends_on :linux

  # Fully static musl builds, so they run regardless of the host glibc.
  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/agustinrojas1/whykey/releases/download/v2.4.1/whykey-2.4.1-aarch64-unknown-linux-musl.tar.gz"
      sha256 "11c1cba1dce42d65b9c60fa86ad5a7589a4669f40d07d60038394af7dbe40119"
    else
      url "https://github.com/agustinrojas1/whykey/releases/download/v2.4.1/whykey-2.4.1-x86_64-unknown-linux-musl.tar.gz"
      sha256 "d84181c4e6705ae85ca3dd35316c67ea4d96ed7b08a990288f86412dca9b40d3"
    end
  end

  def install
    bin.install "whykey"
    bin.install "extensions/whykey-nvim", "extensions/whykey-vscode", "extensions/whykey-emacs"
    # whykey-vscode looks for its defaults table in ../share/whykey.
    pkgshare.install "extensions/whykey-vscode-defaults.json"
    man1.install "whykey.1"
    doc.install "README.md", "SPEC.md", "CHANGELOG.md", "SUPPORT_MATRIX.md", "ADAPTER_INVENTORY.md",
                "DEPENDENCY_PROVENANCE.md", "DEFECT_REGISTER.md", "support-matrix.json"
  end

  def caveats
    <<~EOS
      The whykey-nvim, whykey-vscode, and whykey-emacs extensions need python3.
    EOS
  end

  test do
    assert_equal "whykey #{version}", shell_output("#{bin}/whykey --version").strip
  end
end
