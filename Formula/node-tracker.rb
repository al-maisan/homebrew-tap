class NodeTracker < Formula
  desc "Telegram alerts when a Bitcoin node falls behind the chain tip"
  homepage "https://github.com/al-maisan/node-tracker"
  version "1.5.0"
  license "GPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/al-maisan/node-tracker/releases/download/v1.5.0/node-tracker_1.5.0_darwin_arm64.tar.gz"
      sha256 "e252321241813fad562bfba0bbbffe2a53ce1e3db3f042796a62763c568de749"
    end
    on_intel do
      url "https://github.com/al-maisan/node-tracker/releases/download/v1.5.0/node-tracker_1.5.0_darwin_amd64.tar.gz"
      sha256 "1ff837341220b88c3c10ff2907439ae825931696c146e579bbbedc8f8057d65d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/al-maisan/node-tracker/releases/download/v1.5.0/node-tracker_1.5.0_linux_arm64.tar.gz"
      sha256 "ba95dd6544dcc68b6744b38d07bf627c065aa04eb43d8a8908ee14debb47b780"
    end
    on_intel do
      url "https://github.com/al-maisan/node-tracker/releases/download/v1.5.0/node-tracker_1.5.0_linux_amd64.tar.gz"
      sha256 "4124f6d244e656ff1aa28aadfeef597905abdee5c3d1bd6cbcdcc9d09763cffe"
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
