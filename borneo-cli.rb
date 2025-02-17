# typed: false
# frozen_string_literal: true

class BorneoCli < Formula
  desc "Command Line Interface (CLI) for the Borneo API"
  homepage "https://www.borneo.io/"
  version "v3.18.0"
  version_scheme 1

  URL_ARM="https://github.com/borneodata/homebrew-tap/releases/download/borneo-v3.18.0-cli/borneo-v3.18.0-5b71a67-darwin-arm64.tar.gz"
  SHA_ARM="2ce878d45be47fd441c7cec042d3f991d9d91c6a47cd9fb1e20d3b918615b1a8"
  URL_X64="https://github.com/borneodata/homebrew-tap/releases/download/borneo-v3.18.0-cli/borneo-v3.18.0-5b71a67-darwin-x64.tar.gz"
  SHA_X64="0ba3ea0a102d7d4a9ce91b64003eb6f288132581390ccc21394833e42b570669"

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
