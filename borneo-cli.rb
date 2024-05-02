# typed: false
# frozen_string_literal: true

class BorneoCli < Formula
  desc "Command Line Interface (CLI) for the Borneo API"
  homepage "https://www.borneo.io/"
  version "v3.11.5"
  version_scheme 1

  URL_ARM="https://github.com/borneodata/homebrew-tap/releases/download/borneo-v3.11.5-cli/borneo-v3.10.0-8aa79cd-darwin-arm64.tar.gz"
  SHA_ARM="d9e7f7b2fe1b466435ae6bbb8ac3b266b028ffb1980ef541298925a058a5e0e7"
  URL_X64="https://github.com/borneodata/homebrew-tap/releases/download/borneo-v3.11.5-cli/borneo-v3.10.0-8aa79cd-darwin-x64.tar.gz"
  SHA_X64="933357e1a4065cbb442e92c785da24ed0c1495a308df114bcac18c964c5cd5a5"

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
