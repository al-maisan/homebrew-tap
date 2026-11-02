class NodeTracker < Formula
  desc "Telegram alerts when a Bitcoin node falls behind the chain tip"
  homepage "https://github.com/al-maisan/node-tracker"
  version "1.3.1"
  license "GPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/al-maisan/node-tracker/releases/download/v1.3.1/node-tracker_1.3.1_darwin_arm64.tar.gz"
      sha256 "a35787d09dbde1a1ecd527d4e940e72092155859f98d0cdc0a95ad6c3529160d"
    end
    on_intel do
      url "https://github.com/al-maisan/node-tracker/releases/download/v1.3.1/node-tracker_1.3.1_darwin_amd64.tar.gz"
      sha256 "725aa207ee47e6f84dbfac68cc6777fc3ffc1ed1b523877b992216dd5ac410dc"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/al-maisan/node-tracker/releases/download/v1.3.1/node-tracker_1.3.1_linux_arm64.tar.gz"
      sha256 "b0f3e528813bb4cfddaa04829ef60aa6c7ae387912933ca9d13ba6cf67bdc9d5"
    end
    on_intel do
      url "https://github.com/al-maisan/node-tracker/releases/download/v1.3.1/node-tracker_1.3.1_linux_amd64.tar.gz"
      sha256 "c9c823fdc582220510fa7c8525c8b0b14d7740c24f6946851b68dc001ba5bb74"
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
