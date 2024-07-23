# typed: false
# frozen_string_literal: true

class BorneoCli < Formula
  desc "Command Line Interface (CLI) for the Borneo API"
  homepage "https://www.borneo.io/"
  version "v3.13.3"
  version_scheme 1

  URL_ARM="https://github.com/borneodata/homebrew-tap/releases/download/borneo-v3.13.3-cli/borneo-v3.13.0-76ad2be-darwin-arm64.tar.gz"
  SHA_ARM="ca356282d0e4d28471af2e5c79ea5d34226fc9064d04b075defb9de6e5cc92ac"
  URL_X64="https://github.com/borneodata/homebrew-tap/releases/download/borneo-v3.13.3-cli/borneo-v3.13.0-76ad2be-darwin-x64.tar.gz"
  SHA_X64="098d06f276509074b69767c16775b514dcdeaac68bd1e60f04d2e7fff891c4d1"

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
