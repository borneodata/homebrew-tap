# typed: false
# frozen_string_literal: true

class BorneoCli < Formula
  desc "Command Line Interface (CLI) for the Borneo API"
  homepage "https://www.borneo.io/"
  version "v3.13.0"
  version_scheme 1

  URL_ARM="https://github.com/borneodata/homebrew-tap/releases/download/borneo-v3.13.0-cli/borneo-v3.13.0-c96e05f-darwin-arm64.tar.gz"
  SHA_ARM="8517803c937c5d43f8d77d2301bf0b6df9397c9e721b65128604363aba810fd5"
  URL_X64="https://github.com/borneodata/homebrew-tap/releases/download/borneo-v3.13.0-cli/borneo-v3.13.0-c96e05f-darwin-x64.tar.gz"
  SHA_X64="f8f5f46d32f589ed7ddd2d3661c0e7bef21d0ba1462e95a66178203edfdd58fa"

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
