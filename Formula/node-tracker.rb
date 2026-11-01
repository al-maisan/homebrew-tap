class NodeTracker < Formula
  desc "Telegram alerts when a Bitcoin node falls behind the chain tip"
  homepage "https://github.com/al-maisan/node-tracker"
  version "1.0.0"
  license "GPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/al-maisan/node-tracker/releases/download/v1.0.0/node-tracker_1.0.0_darwin_arm64.tar.gz"
      sha256 "926cb1c62e961b57d55d71c6869ee5c4a6ec112fe29897b9b54804012cc0540f"
    end
    on_intel do
      url "https://github.com/al-maisan/node-tracker/releases/download/v1.0.0/node-tracker_1.0.0_darwin_amd64.tar.gz"
      sha256 "e827b80ccd1bfe5f8355a8ed7431400f4c348baa7638b14a99776924d59a2bc2"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/al-maisan/node-tracker/releases/download/v1.0.0/node-tracker_1.0.0_linux_arm64.tar.gz"
      sha256 "dcd79dd89cea8a12402b9e30f3e3e03a4e89e6ca0d9fcfdca9359636f0939312"
    end
    on_intel do
      url "https://github.com/al-maisan/node-tracker/releases/download/v1.0.0/node-tracker_1.0.0_linux_amd64.tar.gz"
      sha256 "a068672d96f19537856111e726fb3a7f2d1b5d9e5b2779105b3a68b9797ad1fd"
    end
  end

  def install
    bin.install "node-tracker"
    doc.install "README.md", "assets", "docs"
    pkgshare.install "deploy", "examples"
  end

  test do
    assert_match "node-tracker v#{version} (", shell_output("#{bin}/node-tracker version")
  end
end
