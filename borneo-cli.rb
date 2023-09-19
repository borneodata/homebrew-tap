# typed: false
# frozen_string_literal: true

class BorneoCli < Formula
  desc "Command Line Interface (CLI) for the Borneo API"
  homepage "https://borneo.io/"
  version "3.8.0-alpha"
  version_scheme 1

  url "https://github.com/borneodata/homebrew/releases/download/v3.8.0-alpha/borneo-cli-v3.8.0-alpha-518bb1ebf-darwin-arm64.tar.gz"
  sha256 "715870ec59c71386472a33d92f277f746850563144afa7003b10bdcc30061fd6"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/borneodata/homebrew/releases/download/v3.8.0-alpha/borneo-cli-v3.8.0-alpha-518bb1ebf-darwin-x64.tar.gz"
      sha256 "f0ad2df38ad7be4507f674287c20e410e75ac528c623b926fb4bba3c160d0cfd"
    end
  end

  def install
    inreplace "bin/borneo-cli", /^CLIENT_HOME=/, "export BORNEO_CLI_OCLIF_CLIENT_HOME=#{lib/"client"}\nCLIENT_HOME="
    libexec.install Dir["*"]
    bin.install_symlink libexec/"bin/borneo-cli"
  end

  test do
    system bin/"borneo-cli", "version"
  end
end
