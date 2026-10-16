class Whykey < Formula
  desc "Explain where a Linux key combination is handled"
  homepage "https://github.com/agustinrojas1/whykey"
  license "MIT"

  depends_on :linux

  # Fully static musl builds, so they run regardless of the host glibc.
  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/agustinrojas1/whykey/releases/download/v2.4.0/whykey-2.4.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "18e6f932c15de3de9486d55000840db895a8972df90b07bcfbd22f496098bc86"
    else
      url "https://github.com/agustinrojas1/whykey/releases/download/v2.4.0/whykey-2.4.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "ba62ef2024b9770793a270d5fed04db2f86dd737035b76a1d488029d1e91cd54"
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
