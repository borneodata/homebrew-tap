# typed: false
# frozen_string_literal: true

class BorneoCli < Formula
  desc "Command Line Interface (CLI) for the Borneo API"
  homepage "https://www.borneo.io/"
  version "v3.12.1"
  version_scheme 1

  URL_ARM="https://github.com/borneodata/homebrew-tap/releases/download/borneo-v3.12.1-cli/borneo-v3.10.0-f34f8e2-darwin-arm64.tar.gz"
  SHA_ARM="198bfb91c1f73a9b7e20e437a5a0750141d918512267595ba32c185d17a62331"
  URL_X64="https://github.com/borneodata/homebrew-tap/releases/download/borneo-v3.12.1-cli/borneo-v3.10.0-f34f8e2-darwin-x64.tar.gz"
  SHA_X64="79067150c1462a93da60deba2229be0c2dd1fadb2d99e39b18b66665e8da6077"

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
