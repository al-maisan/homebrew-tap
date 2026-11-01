class NodeTracker < Formula
  desc "Telegram alerts when a Bitcoin node falls behind the chain tip"
  homepage "https://github.com/al-maisan/node-tracker"
  version "1.2.0"
  license "GPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/al-maisan/node-tracker/releases/download/v1.2.0/node-tracker_1.2.0_darwin_arm64.tar.gz"
      sha256 "2de74ea13163b2410fde05907b374d500f73b4aadd4107850dbfe1250a215068"
    end
    on_intel do
      url "https://github.com/al-maisan/node-tracker/releases/download/v1.2.0/node-tracker_1.2.0_darwin_amd64.tar.gz"
      sha256 "61102e1e9e6d1a722b7bc645e3078eaf09c568ebf9379acb470954c9d55ac073"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/al-maisan/node-tracker/releases/download/v1.2.0/node-tracker_1.2.0_linux_arm64.tar.gz"
      sha256 "3ac78d14da66a617b89eca522df5bccf447ff2128730763f698fe99b70674bc9"
    end
    on_intel do
      url "https://github.com/al-maisan/node-tracker/releases/download/v1.2.0/node-tracker_1.2.0_linux_amd64.tar.gz"
      sha256 "12556d6c1e9fccfaf3d02999af96110716ecd5daf09f6d898a144339b7dc3ddb"
    end
  end

  def install
    bin.install "node-tracker"
    man1.install "node-tracker.1"
    doc.install "README.md", "assets", "docs"
    pkgshare.install "deploy", "examples"
  end

  # brew services start node-tracker: launchd on macOS, a systemd user
  # service on Linux. node-tracker logs to stderr.
  service do
    run [opt_bin/"node-tracker", "run"]
    keep_alive true
    log_path var/"log/node-tracker.log"
    error_log_path var/"log/node-tracker.log"
  end

  test do
    assert_match "node-tracker v#{version} (", shell_output("#{bin}/node-tracker version")
  end
end
