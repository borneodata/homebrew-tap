# typed: false
# frozen_string_literal: true

class BorneoCli < Formula
  desc "Command Line Interface (CLI) for the Borneo API"
  homepage "https://www.borneo.io/"
  version "v3.18.2"
  version_scheme 1

  URL_ARM="https://github.com/borneodata/homebrew-tap/releases/download/borneo-v3.18.2-cli/borneo-v3.19.0-63d8a62-darwin-arm64.tar.gz"
  SHA_ARM="376ac5195ae60f606ae0ffc31b9e708808477fa5a06ff3281ba5481272ee7f88"
  URL_X64="https://github.com/borneodata/homebrew-tap/releases/download/borneo-v3.18.2-cli/borneo-v3.19.0-63d8a62-darwin-x64.tar.gz"
  SHA_X64="22021f717a35b9c2cf2739ee995730df986729db6c18e1ccbb84fa0b617f9588"

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
