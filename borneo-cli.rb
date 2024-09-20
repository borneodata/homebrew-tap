# typed: false
# frozen_string_literal: true

class BorneoCli < Formula
  desc "Command Line Interface (CLI) for the Borneo API"
  homepage "https://www.borneo.io/"
  version "v3.14.2"
  version_scheme 1

  URL_ARM="https://github.com/borneodata/homebrew-tap/releases/download/borneo-v3.14.2-cli/borneo-v3.14.2-65b1600-darwin-arm64.tar.gz"
  SHA_ARM="b384d9b69ca085135f681b1257e42086b65cf102693a7ce003481fb6db567cdc"
  URL_X64="https://github.com/borneodata/homebrew-tap/releases/download/borneo-v3.14.2-cli/borneo-v3.14.2-65b1600-darwin-x64.tar.gz"
  SHA_X64="3bb6c73b52801395974844b503fbb2c8b2c2081214f8247a65597f7678ad7a5e"

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
