# typed: false
# frozen_string_literal: true

class BorneoCli < Formula
  desc "Command Line Interface (CLI) for the Borneo API"
  homepage "https://www.borneo.io/"
  version "v3.13.2"
  version_scheme 1

  URL_ARM="https://github.com/borneodata/homebrew-tap/releases/download/borneo-v3.13.2-cli/borneo-v3.13.0-a8c9a87-darwin-arm64.tar.gz"
  SHA_ARM="338da85fe89c45cbc1711c26b1383b0f17b4790a530d5ac1b9b543265e5b6dc1"
  URL_X64="https://github.com/borneodata/homebrew-tap/releases/download/borneo-v3.13.2-cli/borneo-v3.13.0-a8c9a87-darwin-x64.tar.gz"
  SHA_X64="228f19cdbfeffa6ca34253fc0c94d839f37788fbada028fffdd95c7fe4dc1498"

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
