# typed: false
# frozen_string_literal: true

class BorneoCli < Formula
  desc "Command Line Interface (CLI) for the Borneo API"
  homepage "https://www.borneo.io/"
  version "v3.14.3"
  version_scheme 1

  URL_ARM="https://github.com/borneodata/homebrew-tap/releases/download/borneo-v3.14.3-cli/borneo-v3.14.2-b091047-darwin-arm64.tar.gz"
  SHA_ARM="63912229281b82a02be58ae0541b3c6bb5d609b91708dcbfed7c27e1b713080d"
  URL_X64="https://github.com/borneodata/homebrew-tap/releases/download/borneo-v3.14.3-cli/borneo-v3.14.2-b091047-darwin-x64.tar.gz"
  SHA_X64="9e118b16fbbcbdd0efc9dd3068efa3520e91236ad6386404397185456a3362ce"

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
