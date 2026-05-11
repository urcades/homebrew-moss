class Moss < Formula
  desc "Native macOS Apple Messages bridge for prompting Codex from trusted senders"
  homepage "https://github.com/urcades/moss"
  url "https://github.com/urcades/moss/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "d7083254f4538718278d351acb9feec7a73bc0dfcf1ab8613f232552ac546c01"
  license "MIT"
  head "https://github.com/urcades/moss.git", branch: "main"

  depends_on macos: :sequoia

  def install
    ENV["CONFIGURATION"] = "release"
    ENV["SIGN_IDENTITY"] = "-"

    inreplace "BuildSupport/build-app.zsh",
      'swift build -c "$CONFIGURATION"',
      'swift build -c "$CONFIGURATION" --disable-sandbox'

    system "./BuildSupport/build-app.zsh"

    prefix.install ".build/app/MessagesCodexBridge.app"
    bin.install ".build/release/codexmsgctl-swift" => "mossctl"

    (bin/"moss-open").write <<~ZSH
      #!/bin/zsh
      set -euo pipefail

      cd "${MOSS_CODEX_CWD:-$HOME}"
      /usr/bin/nohup "#{opt_prefix}/MessagesCodexBridge.app/Contents/MacOS/MessagesCodexBridge" >/dev/null 2>&1 &
    ZSH
    chmod 0755, bin/"moss-open"
  end

  def caveats
    <<~EOS
      Moss builds and installs the menu-bar app from source. To finish setup:

        cd ~
        mossctl configure --safety standard
        moss-open
        mossctl doctor

      Use MOSS_CODEX_CWD=/path/to/workspace moss-open if you want fresh runtime
      config to default Codex sessions to a specific working directory.
    EOS
  end

  test do
    assert_match "Usage:", shell_output("#{bin}/mossctl --help")
    assert_path_exists prefix/"MessagesCodexBridge.app/Contents/MacOS/MessagesCodexBridge"
  end
end
