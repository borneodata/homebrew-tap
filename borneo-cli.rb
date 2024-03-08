# typed: false
# frozen_string_literal: true

class BorneoCli < Formula
  desc "Command Line Interface (CLI) for the Borneo API"
  homepage "https://www.borneo.io/"
  version "v3.10.1"
  version_scheme 1

  URL_ARM="https://github.com/borneodata/homebrew-tap/releases/download/borneo-v3.10.1-cli/borneo-v3.10.0-1d8a9ed-darwin-arm64.tar.gz"
  SHA_ARM="74f167668d86746a0a5492adb72ad1ed386a63f9c3f89350755ac895a158b367"
  URL_X64="https://github.com/borneodata/homebrew-tap/releases/download/borneo-v3.10.1-cli/borneo-v3.10.0-1d8a9ed-darwin-x64.tar.gz"
  SHA_X64="ddf00510fde9ba000bd1ea540dab5b58e6c0746682795dee895b7b049578482e"

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
