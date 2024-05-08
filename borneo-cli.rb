# typed: false
# frozen_string_literal: true

class BorneoCli < Formula
  desc "Command Line Interface (CLI) for the Borneo API"
  homepage "https://www.borneo.io/"
  version "v3.11.6"
  version_scheme 1

  URL_ARM="https://github.com/borneodata/homebrew-tap/releases/download/borneo-v3.11.6-cli/borneo-v3.10.0-8aa79cd-darwin-arm64.tar.gz"
  SHA_ARM="16af3cd39c485eb955a13771742a074ec1094d0816d893ad201b1774ed69ff38"
  URL_X64="https://github.com/borneodata/homebrew-tap/releases/download/borneo-v3.11.6-cli/borneo-v3.10.0-8aa79cd-darwin-x64.tar.gz"
  SHA_X64="eb09ad0b611704f6a6215853744954315c99a57368fce22264973f58fdf30eed"

  url URL_ARM
  sha256 SHA_ARM

  on_macos do
    if Hardware::CPU.intel?
      url URL_X64
      sha256 SHA_X64
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
