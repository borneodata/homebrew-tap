# typed: false
# frozen_string_literal: true

class BorneoCli < Formula
  desc "Command Line Interface (CLI) for the Borneo API"
  homepage "https://www.borneo.io/"
  version "v3.15.0"
  version_scheme 1

  URL_ARM="https://github.com/borneodata/homebrew-tap/releases/download/borneo-v3.15.0-cli/borneo-v3.15.0-6f9882d-darwin-arm64.tar.gz"
  SHA_ARM="85c8b4aa676b18886885c8cf2ace615045edc7a6610d6ef6c1a7f27471072c83"
  URL_X64="https://github.com/borneodata/homebrew-tap/releases/download/borneo-v3.15.0-cli/borneo-v3.15.0-6f9882d-darwin-x64.tar.gz"
  SHA_X64="645046cbfd45a08db10ff138498c67c2b34bdeec293bea052b9c309e8f3e9662"

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
