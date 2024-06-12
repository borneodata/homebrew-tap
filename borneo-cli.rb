# typed: false
# frozen_string_literal: true

class BorneoCli < Formula
  desc "Command Line Interface (CLI) for the Borneo API"
  homepage "https://www.borneo.io/"
  version "v3.12.4"
  version_scheme 1

  URL_ARM="https://github.com/borneodata/homebrew-tap/releases/download/borneo-v3.12.4-cli/borneo-v3.10.0-2c41568-darwin-arm64.tar.gz"
  SHA_ARM="b2998fed00da1a0d7b705a43f51ac88f1e2a5831bb43ab7af186a0473f2b3263"
  URL_X64="https://github.com/borneodata/homebrew-tap/releases/download/borneo-v3.12.4-cli/borneo-v3.10.0-2c41568-darwin-x64.tar.gz"
  SHA_X64="2e82d77ca78801454e20314f4cde1d0656acb192d47ddec9085b7d4c86f6ddc8"

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
