# typed: false
# frozen_string_literal: true

class BorneoCli < Formula
  desc "Command Line Interface (CLI) for the Borneo API"
  homepage "https://www.borneo.io/"
  version "v3.11.1"
  version_scheme 1

  URL_ARM="https://github.com/borneodata/homebrew-tap/releases/download/borneo-v3.11.1-cli/borneo-v3.10.0-8aa79cd-darwin-arm64.tar.gz"
  SHA_ARM="3f4fbf68577d080a1b04750f7b0e0ab72058dad8e3bcf1bd18cc9deeeb1684b7"
  URL_X64="https://github.com/borneodata/homebrew-tap/releases/download/borneo-v3.11.1-cli/borneo-v3.10.0-8aa79cd-darwin-x64.tar.gz"
  SHA_X64="216a102490eaeed158bce6f850881d9ff00fdf7d801d27de0dafa0bf3b3753b4"

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
