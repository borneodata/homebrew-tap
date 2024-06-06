# typed: false
# frozen_string_literal: true

class BorneoCli < Formula
  desc "Command Line Interface (CLI) for the Borneo API"
  homepage "https://www.borneo.io/"
  version "v3.12.3"
  version_scheme 1

  URL_ARM="https://github.com/borneodata/homebrew-tap/releases/download/borneo-v3.12.3-cli/borneo-v3.10.0-2c41568-darwin-arm64.tar.gz"
  SHA_ARM="1a83fbb8870d4bbdd1f8148f2289f48bf3b1f65db4580d1ad380910150c11f0a"
  URL_X64="https://github.com/borneodata/homebrew-tap/releases/download/borneo-v3.12.3-cli/borneo-v3.10.0-2c41568-darwin-x64.tar.gz"
  SHA_X64="27914812bec38d8e565752fbe106c5f54e1e83839b6955a1ec09c093c4055f7c"

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
