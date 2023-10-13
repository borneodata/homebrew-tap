# typed: false
# frozen_string_literal: true

class BorneoCli < Formula
  desc "Command Line Interface (CLI) for the Borneo API"
  homepage "https://www.borneo.io/"
  version "3.8.0-alpha.5"
  version_scheme 1

  url "https://github.com/borneodata/homebrew-tap/releases/download/v3.8.0-alpha.5/borneo-v3.8.0-alpha.5-d51b58c7f-darwin-arm64.tar.gz"
  sha256 "315e5e6c33fc2e1f317b73a869a50d38969ed258639db96d5a388e33c6bb9bf6"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/borneodata/homebrew-tap/releases/download/v3.8.0-alpha.5/borneo-v3.8.0-alpha.5-d51b58c7f-darwin-x64.tar.gz"
      sha256 "4cfa11efd05990f9adddf7cc7580355f8aa5e735ead13af8a1e12fd7496aeeec"
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
