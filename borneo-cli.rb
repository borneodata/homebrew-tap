# typed: false
# frozen_string_literal: true

class BorneoCli < Formula
  desc "Command Line Interface (CLI) for the Borneo API"
  homepage "https://www.borneo.io/"
  version "v3.13.4"
  version_scheme 1

  URL_ARM="https://github.com/borneodata/homebrew-tap/releases/download/borneo-v3.13.4-cli/borneo-v3.13.0-6956bbf-darwin-arm64.tar.gz"
  SHA_ARM="802ea57847cc9db0c725040a106b642294909939a0317bcf55d7d7a8a6a4bc82"
  URL_X64="https://github.com/borneodata/homebrew-tap/releases/download/borneo-v3.13.4-cli/borneo-v3.13.0-6956bbf-darwin-x64.tar.gz"
  SHA_X64="eb998ae806f7582707521f23c2999296a7cef7b3554746698bb6902c404c506f"

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
