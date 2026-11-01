class NodeTracker < Formula
  desc "Telegram alerts when a Bitcoin node falls behind the chain tip"
  homepage "https://github.com/al-maisan/node-tracker"
  version "1.1.1"
  license "GPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/al-maisan/node-tracker/releases/download/v1.1.1/node-tracker_1.1.1_darwin_arm64.tar.gz"
      sha256 "2aaf6e04125e2acc2bf016914d8e210fb9fec3fc14c6fb999b05eccfb2137b15"
    end
    on_intel do
      url "https://github.com/al-maisan/node-tracker/releases/download/v1.1.1/node-tracker_1.1.1_darwin_amd64.tar.gz"
      sha256 "a6a7181e2b695d3141467cec4a15620fa0e0eb1161f30349d7c71a7d7bdf61cf"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/al-maisan/node-tracker/releases/download/v1.1.1/node-tracker_1.1.1_linux_arm64.tar.gz"
      sha256 "cdffb8690735a6368775994522a067a1a01b4abd0a3cc6d34b8238d0412cf04c"
    end
    on_intel do
      url "https://github.com/al-maisan/node-tracker/releases/download/v1.1.1/node-tracker_1.1.1_linux_amd64.tar.gz"
      sha256 "f5407bfd3167a03d89b62347647b15972f6b5d5bc720ee9446eef0487bee3e58"
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
