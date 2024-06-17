# typed: false
# frozen_string_literal: true

class BorneoCli < Formula
  desc "Command Line Interface (CLI) for the Borneo API"
  homepage "https://www.borneo.io/"
  version "v3.12.5"
  version_scheme 1

  URL_ARM="https://github.com/borneodata/homebrew-tap/releases/download/borneo-v3.12.5-cli/borneo-v3.10.0-2c41568-darwin-arm64.tar.gz"
  SHA_ARM="ab4858153e204f4aa7e502655b3bf2f10006dcb726aade3546a3b6eb9338066e"
  URL_X64="https://github.com/borneodata/homebrew-tap/releases/download/borneo-v3.12.5-cli/borneo-v3.10.0-2c41568-darwin-x64.tar.gz"
  SHA_X64="1518d6fccc90d178a9347eb297c02d55c9125b84fa912e0cc840d1c814dfed81"

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
