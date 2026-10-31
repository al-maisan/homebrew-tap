class GmtMail < Formula
  desc "Send personalized bulk emails (mail merge) from the terminal over SMTP with TLS"
  homepage "https://github.com/al-maisan/gmt-mail"
  url "https://github.com/al-maisan/gmt-mail/archive/refs/tags/v0.9.0.tar.gz"
  sha256 "54e67abf51c7ac3251a50a9077e7e07bc723df39d44e3f0be8350b9be3c22a78"
  license "GPL-3.0-or-later"
  head "https://github.com/al-maisan/gmt-mail.git", branch: "master"

  depends_on "go" => :build

  def install
    # man page date = release date: GitHub archives carry the tagged commit's time
    mandate = File.mtime("gmt-mail.1").utc.strftime("%F")
    ldflags = "-s -w -X main.appVersion=#{version} -X main.buildDate=#{mandate}"
    system "go", "build", *std_go_args(ldflags:)
    inreplace "gmt-mail.1", "@VERSION@", version.to_s
    inreplace "gmt-mail.1", "@DATE@", mandate
    man1.install "gmt-mail.1"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/gmt-mail -version")
    system bin/"gmt-mail", "-sample-config"
    (testpath/"c.toml").write <<~TOML
      [general]
      from = "a@example.com"
      subject = "Hi %FN%"
      [[recipients]]
      email = "b@example.com"
      first = "Bo"
    TOML
    (testpath/"t.eml").write "Hello %FN%\n"
    assert_match "Hello Bo", shell_output("#{bin}/gmt-mail -dry-run -config-path c.toml -template-path t.eml")
  end
end
