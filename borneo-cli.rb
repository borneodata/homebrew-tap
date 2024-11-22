# typed: false
# frozen_string_literal: true

class BorneoCli < Formula
  desc "Command Line Interface (CLI) for the Borneo API"
  homepage "https://www.borneo.io/"
  version "v3.16.0"
  version_scheme 1

  URL_ARM="https://github.com/borneodata/homebrew-tap/releases/download/borneo-v3.16.0-cli/borneo-v3.16.0-dc55d34-darwin-arm64.tar.gz"
  SHA_ARM="ed393c12f43b2c2818acb87665c258a1b2de3c9ac404dd454300b3f1ecb30215"
  URL_X64="https://github.com/borneodata/homebrew-tap/releases/download/borneo-v3.16.0-cli/borneo-v3.16.0-dc55d34-darwin-x64.tar.gz"
  SHA_X64="5a22f17b438aae1e02882c921054a22c615683692c981037aa0167e754698489"

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
