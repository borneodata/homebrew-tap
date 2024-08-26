# typed: false
# frozen_string_literal: true

class BorneoCli < Formula
  desc "Command Line Interface (CLI) for the Borneo API"
  homepage "https://www.borneo.io/"
  version "v3.14.1"
  version_scheme 1

  URL_ARM="https://github.com/borneodata/homebrew-tap/releases/download/borneo-v3.14.1-cli/borneo-v3.14.1-c0dcab6-darwin-arm64.tar.gz"
  SHA_ARM="c7e9e885b7de77e5980f8a4110d4fc83c41f5702dc8aeb48928e1f9df9b13ce5"
  URL_X64="https://github.com/borneodata/homebrew-tap/releases/download/borneo-v3.14.1-cli/borneo-v3.14.1-c0dcab6-darwin-x64.tar.gz"
  SHA_X64="bf9701c6eb1b75b326065f2e9813fd310b8f57440c969dde5f0eaa0c9637be47"

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
