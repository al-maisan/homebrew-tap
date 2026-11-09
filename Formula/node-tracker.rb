class NodeTracker < Formula
  desc "Telegram alerts when a Bitcoin node falls behind the chain tip"
  homepage "https://github.com/al-maisan/node-tracker"
  version "1.4.0"
  license "GPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/al-maisan/node-tracker/releases/download/v1.4.0/node-tracker_1.4.0_darwin_arm64.tar.gz"
      sha256 "5869f3919ab21db8c94b0236a89e7366963bf9679c31d599fe761d7b4de6fcd7"
    end
    on_intel do
      url "https://github.com/al-maisan/node-tracker/releases/download/v1.4.0/node-tracker_1.4.0_darwin_amd64.tar.gz"
      sha256 "276db0a694d2443e2f275b09c9e0975c035695aa3c2e3e2c7d9683f1ad563712"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/al-maisan/node-tracker/releases/download/v1.4.0/node-tracker_1.4.0_linux_arm64.tar.gz"
      sha256 "6eab3ee71bac67991a6f963ed3c2b2d2ccb01ce287b62ae870d9aa35aba8b68b"
    end
    on_intel do
      url "https://github.com/al-maisan/node-tracker/releases/download/v1.4.0/node-tracker_1.4.0_linux_amd64.tar.gz"
      sha256 "caea1c0f68f92e21580a4c448b0b3cea0960aaa691295222b8224d79a1208f7d"
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
