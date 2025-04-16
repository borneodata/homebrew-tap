# typed: false
# frozen_string_literal: true

class BorneoCli < Formula
  desc "Command Line Interface (CLI) for the Borneo API"
  homepage "https://www.borneo.io/"
  version "v3.19.2"
  version_scheme 1

  URL_ARM="https://github.com/borneodata/homebrew-tap/releases/download/borneo-v3.19.2-cli/borneo-v3.19.0-4a8deae-darwin-arm64.tar.gz"
  SHA_ARM="80809c3e49398ad6d4ce60029859239248459e86004a14b016451f81fbbdb599"
  URL_X64="https://github.com/borneodata/homebrew-tap/releases/download/borneo-v3.19.2-cli/borneo-v3.19.0-4a8deae-darwin-x64.tar.gz"
  SHA_X64="8779967e44f54d1dcf01415b05f9903da438d53714d60e62a2edd62f16b78c19"

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
