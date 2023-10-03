# typed: false
# frozen_string_literal: true

class BorneoCli < Formula
  desc "Command Line Interface (CLI) for the Borneo API"
  homepage "https://www.borneo.io/"
  version "3.8.0-alpha"
  version_scheme 1

  url "https://github.com/borneodata/homebrew-tap/releases/download/v3.8.0-alpha/borneo-cli-v3.8.0-alpha-8e4ecf946-darwin-arm64.tar.gz"
  sha256 "e74e3c586d869a4f50bcd4d9e6ffba4f12ef13a480580eecbc220c46fa25e3fc"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/borneodata/homebrew-tap/releases/download/v3.8.0-alpha/borneo-cli-v3.8.0-alpha-8e4ecf946-darwin-x64.tar.gz"
      sha256 "da7ae423ca778f432ca24e78dbf651a7e1d7ae2cf3a7bdf23e60b1beee6f1e4f"
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
