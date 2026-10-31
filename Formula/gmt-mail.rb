class GmtMail < Formula
  desc "Send personalized bulk emails (mail merge) from the terminal over SMTP with TLS"
  homepage "https://github.com/al-maisan/gmt-mail"
  url "https://github.com/al-maisan/gmt-mail/archive/refs/tags/v0.10.0.tar.gz"
  sha256 "3d4446fcdddf00422a900833cffb80a6777108df373574a467f249fe26700b44"
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
