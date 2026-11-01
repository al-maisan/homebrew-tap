class NodeTracker < Formula
  desc "Telegram alerts when a Bitcoin node falls behind the chain tip"
  homepage "https://github.com/al-maisan/node-tracker"
  version "1.1.0"
  license "GPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/al-maisan/node-tracker/releases/download/v1.1.0/node-tracker_1.1.0_darwin_arm64.tar.gz"
      sha256 "bf09007e8a1f83e3c3dae0d6b422ff97a064c06fb32c328499203c62ef8036f4"
    end
    on_intel do
      url "https://github.com/al-maisan/node-tracker/releases/download/v1.1.0/node-tracker_1.1.0_darwin_amd64.tar.gz"
      sha256 "4f080d067aa3a0cecc5c4f44e16516ac784a0e365e97c183c5256f44ceac52c2"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/al-maisan/node-tracker/releases/download/v1.1.0/node-tracker_1.1.0_linux_arm64.tar.gz"
      sha256 "630ee544261cd0da44f2c71c55802b3579b06399d5f637fde510d6830a88c2f2"
    end
    on_intel do
      url "https://github.com/al-maisan/node-tracker/releases/download/v1.1.0/node-tracker_1.1.0_linux_amd64.tar.gz"
      sha256 "96dc1bc916c6736635c8479d92d269e8104bc69fd4a400c08f979a2ffd3e2d40"
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
