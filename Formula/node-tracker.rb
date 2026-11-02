class NodeTracker < Formula
  desc "Telegram alerts when a Bitcoin node falls behind the chain tip"
  homepage "https://github.com/al-maisan/node-tracker"
  version "1.3.2"
  license "GPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/al-maisan/node-tracker/releases/download/v1.3.2/node-tracker_1.3.2_darwin_arm64.tar.gz"
      sha256 "a91366398b13e3509a4c7a5eca0ca50918f6385ccea3885a24cc9cf427c4b0f9"
    end
    on_intel do
      url "https://github.com/al-maisan/node-tracker/releases/download/v1.3.2/node-tracker_1.3.2_darwin_amd64.tar.gz"
      sha256 "b64fae5a4e764b8c282b9f3d5eb920f9479ea7e37e99a880e92f035faf06d4fc"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/al-maisan/node-tracker/releases/download/v1.3.2/node-tracker_1.3.2_linux_arm64.tar.gz"
      sha256 "56f183eeaa2a4a2382bb30e40b359464b24d4ca654311a3687cf1802b12a8b59"
    end
    on_intel do
      url "https://github.com/al-maisan/node-tracker/releases/download/v1.3.2/node-tracker_1.3.2_linux_amd64.tar.gz"
      sha256 "f44895f43af081bc107b1ca88ac92d87f23f1d82f5be13a6623cbde426d0446e"
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
