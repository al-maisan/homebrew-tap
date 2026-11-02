class NodeTracker < Formula
  desc "Telegram alerts when a Bitcoin node falls behind the chain tip"
  homepage "https://github.com/al-maisan/node-tracker"
  version "1.3.0"
  license "GPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/al-maisan/node-tracker/releases/download/v1.3.0/node-tracker_1.3.0_darwin_arm64.tar.gz"
      sha256 "f1e9c3075a52ac5b62b2767372bb65e7c85e5b7021dbdb3f2907895e44df683d"
    end
    on_intel do
      url "https://github.com/al-maisan/node-tracker/releases/download/v1.3.0/node-tracker_1.3.0_darwin_amd64.tar.gz"
      sha256 "186918e22e4985f4116e088940ddebb5bfac2d139198121bed6cfde30d288a0d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/al-maisan/node-tracker/releases/download/v1.3.0/node-tracker_1.3.0_linux_arm64.tar.gz"
      sha256 "d6f6f9cf3f29c1f20df79b0fdfc60156520f7c85b7e718b28d92db663db8b5e3"
    end
    on_intel do
      url "https://github.com/al-maisan/node-tracker/releases/download/v1.3.0/node-tracker_1.3.0_linux_amd64.tar.gz"
      sha256 "61b204436b4a9c13663df1569fcfe40b03d16dde7812f39237c9a8ef40483858"
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
