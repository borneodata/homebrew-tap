# typed: false
# frozen_string_literal: true

class BorneoCli < Formula
  desc "Command Line Interface (CLI) for the Borneo API"
  homepage "https://www.borneo.io/"
  version "3.9.0-cli"
  version_scheme 1

  url "https://github.com/borneodata/homebrew-tap/releases/download/v3.9.0-cli/borneo-v3.9.0-075bb970c-darwin-arm64.tar.gz"
  sha256 "0deecc23e82fbe259d5f1098ac5ed87b7435fbdc0c102d9395d61ac4aa5181bb"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/borneodata/homebrew-tap/releases/download/v3.9.0-cli/borneo-v3.9.0-075bb970c-darwin-x64.tar.gz"
      sha256 "176467254940b79c6ee0cb602e2b7ea1b4cec727edc8c657a8ded29b7ead42de"
    end
  end

  def install
    inreplace "bin/borneo", /^CLIENT_HOME=/, "export BORNEO_OCLIF_CLIENT_HOME=#{lib/"client"}\nCLIENT_HOME="
    libexec.install Dir["*"]
    bin.install_symlink libexec/"bin/borneo"
  end

  test do
    system bin/"borneo", "version"
  end
end
