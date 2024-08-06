# typed: false
# frozen_string_literal: true

class BorneoCli < Formula
  desc "Command Line Interface (CLI) for the Borneo API"
  homepage "https://www.borneo.io/"
  version "v3.14.0"
  version_scheme 1

  URL_ARM="https://github.com/borneodata/homebrew-tap/releases/download/borneo-v3.14.0-cli/borneo-v3.13.0-bf6140e-darwin-arm64.tar.gz"
  SHA_ARM="67ea86987e4c3c53f23950138fa9d0c57718d05a0854842d2c1ffedff566a423"
  URL_X64="https://github.com/borneodata/homebrew-tap/releases/download/borneo-v3.14.0-cli/borneo-v3.13.0-bf6140e-darwin-x64.tar.gz"
  SHA_X64="018ee45d1f8414d6b1b1370c98ce08ee86a71889304a2da34e0aec2b9907bdb6"

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
