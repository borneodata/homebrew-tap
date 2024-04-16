# typed: false
# frozen_string_literal: true

class BorneoCli < Formula
  desc "Command Line Interface (CLI) for the Borneo API"
  homepage "https://www.borneo.io/"
  version "v3.11.0"
  version_scheme 1

  URL_ARM="https://github.com/borneodata/homebrew-tap/releases/download/borneo-v3.11.0-cli/borneo-v3.10.0-28ff6b4-darwin-arm64.tar.gz"
  SHA_ARM="3607a36edbb7b4dd4d7c113daa845f7ce183f16ff4be0b5f0101ed62b8bf9f4b"
  URL_X64="https://github.com/borneodata/homebrew-tap/releases/download/borneo-v3.11.0-cli/borneo-v3.10.0-28ff6b4-darwin-x64.tar.gz"
  SHA_X64="4b2ac99962b758bc2eeccce66200cbcb20ad82aa02f6bd1322aa8819764253ef"

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
