# typed: false
# frozen_string_literal: true

class BorneoCli < Formula
  desc "Command Line Interface (CLI) for the Borneo API"
  homepage "https://www.borneo.io/"
  version "v3.15.1"
  version_scheme 1

  URL_ARM="https://github.com/borneodata/homebrew-tap/releases/download/borneo-v3.15.1-cli/borneo-v3.15.0-cbb1755-darwin-arm64.tar.gz"
  SHA_ARM="794041b177aacc944953fb4b8fd51a4add4dde1aaf1b5916cd7418a460b02067"
  URL_X64="https://github.com/borneodata/homebrew-tap/releases/download/borneo-v3.15.1-cli/borneo-v3.15.0-cbb1755-darwin-x64.tar.gz"
  SHA_X64="67febe53039d86cf6a61c4a4cf957aa04c67bbf5fe617eb2c8b1feebeea2a651"

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
