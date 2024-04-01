# typed: false
# frozen_string_literal: true

class BorneoCli < Formula
  desc "Command Line Interface (CLI) for the Borneo API"
  homepage "https://www.borneo.io/"
  version "v3.10.5"
  version_scheme 1

  URL_ARM="https://github.com/borneodata/homebrew-tap/releases/download/borneo-v3.10.5-cli/borneo-v3.10.0-5060ac2-darwin-arm64.tar.gz"
  SHA_ARM="ef96c324614cf4769485160a48d0ee9972a0ef97ae3c1920bd0b0dc03451b9c6"
  URL_X64="https://github.com/borneodata/homebrew-tap/releases/download/borneo-v3.10.5-cli/borneo-v3.10.0-5060ac2-darwin-x64.tar.gz"
  SHA_X64="611300db571b29c62b145e3873631fdac2504e5600655c542678fed8bc006426"

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
