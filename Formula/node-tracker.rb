class NodeTracker < Formula
  desc "Telegram alerts when a Bitcoin node falls behind the chain tip"
  homepage "https://github.com/al-maisan/node-tracker"
  version "1.5.2"
  license "GPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/al-maisan/node-tracker/releases/download/v1.5.2/node-tracker_1.5.2_darwin_arm64.tar.gz"
      sha256 "c88e5558b277817d97d09b2c9d34733fd806ab41743b2987cf23a5fd03d2868a"
    end
    on_intel do
      url "https://github.com/al-maisan/node-tracker/releases/download/v1.5.2/node-tracker_1.5.2_darwin_amd64.tar.gz"
      sha256 "19ac06d3058848b855875c471a69cb91fde4ab39011ab17bc8abd6b0960af0e4"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/al-maisan/node-tracker/releases/download/v1.5.2/node-tracker_1.5.2_linux_arm64.tar.gz"
      sha256 "c981c96b7886b658ce387272932774796b8f5c9453c9988bcd690c7d767161b3"
    end
    on_intel do
      url "https://github.com/al-maisan/node-tracker/releases/download/v1.5.2/node-tracker_1.5.2_linux_amd64.tar.gz"
      sha256 "806409a5a636fb54899c53064b8d7a311628ecb7599419cafb0f551a8f3ae3d2"
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
