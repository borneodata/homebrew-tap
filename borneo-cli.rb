# typed: false
# frozen_string_literal: true

class BorneoCli < Formula
  desc "Command Line Interface (CLI) for the Borneo API"
  homepage "https://www.borneo.io/"
  version "3.8.0-alpha.2"
  version_scheme 1

  url "https://github.com/borneodata/homebrew-tap/releases/download/v3.8.0-alpha.2/borneo-cli-v3.8.0-alpha.2-ed1eec20b-darwin-arm64.tar.gz"
  sha256 "1795badaa4db9cafa4be1a47234f8423aa1341c76b78675095b87ee07fa57373"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/borneodata/homebrew-tap/releases/download/v3.8.0-alpha.2/borneo-cli-v3.8.0-alpha.2-ed1eec20b-darwin-x64.tar.gz"
      sha256 "c148052eba59a78e195859f9b467b627b745eb6d5044a8567c89591f569fa3c9"
    end
  end

  def install
    inreplace "bin/borneo-cli", /^CLIENT_HOME=/, "export BORNEO_CLI_OCLIF_CLIENT_HOME=#{lib/"client"}\nCLIENT_HOME="
    libexec.install Dir["*"]
    bin.install_symlink libexec/"bin/borneo-cli"
  end

  test do
    system bin/"borneo-cli", "version"
  end
end
