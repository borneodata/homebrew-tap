# typed: false
# frozen_string_literal: true

class BorneoCli < Formula
  desc "Command Line Interface (CLI) for the Borneo API"
  homepage "https://www.borneo.io/"
  version "v3.17.2"
  version_scheme 1

  URL_ARM="https://github.com/borneodata/homebrew-tap/releases/download/borneo-v3.17.2-cli/borneo-v3.17.0-05d3e4c-darwin-arm64.tar.gz"
  SHA_ARM="876d7cd08cfc5277b49de2000150f8d9dfa7d842dc03bebec7779961c6145b73"
  URL_X64="https://github.com/borneodata/homebrew-tap/releases/download/borneo-v3.17.2-cli/borneo-v3.17.0-05d3e4c-darwin-x64.tar.gz"
  SHA_X64="886068ff3ed8787daa88722a57bb1dba3033280cd3764e00e68f978a4bb7b9da"

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
