# typed: false
# frozen_string_literal: true

class BorneoCli < Formula
  desc "Command Line Interface (CLI) for the Borneo API"
  homepage "https://www.borneo.io/"
  version "v3.19.0"
  version_scheme 1

  URL_ARM="https://github.com/borneodata/homebrew-tap/releases/download/borneo-v3.19.0-cli/borneo-v3.19.0-7d532fa-darwin-arm64.tar.gz"
  SHA_ARM="3addadd37234b1c8b4fa3185c1d8f64b7267ea19b3e5b33f14d145731687662a"
  URL_X64="https://github.com/borneodata/homebrew-tap/releases/download/borneo-v3.19.0-cli/borneo-v3.19.0-7d532fa-darwin-x64.tar.gz"
  SHA_X64="644b3292434ab35abfe1d317727d5d4b6082a529e555ddf0aca38a13b9944f38"

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
