# typed: false
# frozen_string_literal: true

class BorneoCli < Formula
  desc "Command Line Interface (CLI) for the Borneo API"
  homepage "https://www.borneo.io/"
  version "v3.10.0"
  version_scheme 1

  URL_ARM="https://github.com/borneodata/homebrew-tap/releases/download/borneo-v3.10.0-cli/borneo-v3.10.0-607f319-darwin-arm64.tar.gz"
  SHA_ARM="60c701dc0b5c99ebf58d4e7301c62e56480463fedef73576444cc92ab45954db"
  URL_X64="https://github.com/borneodata/homebrew-tap/releases/download/borneo-v3.10.0-cli/borneo-v3.10.0-607f319-darwin-x64.tar.gz"
  SHA_X64="6b7fd4b93098564cb572e8955f1d5d8c635b3e7044eace582f5a6f31d194ab55"

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
