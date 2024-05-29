# typed: false
# frozen_string_literal: true

class BorneoCli < Formula
  desc "Command Line Interface (CLI) for the Borneo API"
  homepage "https://www.borneo.io/"
  version "v3.12.2"
  version_scheme 1

  URL_ARM="https://github.com/borneodata/homebrew-tap/releases/download/borneo-v3.12.2-cli/borneo-v3.10.0-2c41568-darwin-arm64.tar.gz"
  SHA_ARM="60ef8ed47f8357fb3052c1f77f2128cb77d02f1cbfb4cf1570b7fc80b9741d35"
  URL_X64="https://github.com/borneodata/homebrew-tap/releases/download/borneo-v3.12.2-cli/borneo-v3.10.0-2c41568-darwin-x64.tar.gz"
  SHA_X64="39d37a4387cf091bf19d9596c9d12dc3f8d1a10ac542888197304aa83654bf4c"

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
