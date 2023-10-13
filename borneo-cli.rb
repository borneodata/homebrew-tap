# typed: false
# frozen_string_literal: true

class BorneoCli < Formula
  desc "Command Line Interface (CLI) for the Borneo API"
  homepage "https://www.borneo.io/"
  version "3.8.0-alpha.5"
  version_scheme 1

  url "https://github.com/borneodata/homebrew-tap/releases/download/v3.8.0-alpha.5/borneo-v3.8.0-alpha.5-d378eb00c-darwin-arm64.tar.gz"
  sha256 "6d8ca428de3314b7b5bc0920e9ceadfc67831199e84b5034a16b4fa0678a1c2b"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/borneodata/homebrew-tap/releases/download/v3.8.0-alpha.5/borneo-v3.8.0-alpha.5-d378eb00c-darwin-x64.tar.gz"
      sha256 "cdadb3590a5a5b2e9b9fbce069a9d80559d36d187ab3dd81942139d47c7ac6d5"
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
