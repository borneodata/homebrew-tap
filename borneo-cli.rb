# typed: false
# frozen_string_literal: true

class BorneoCli < Formula
  desc "Command Line Interface (CLI) for the Borneo API"
  homepage "https://www.borneo.io/"
  version "v3.15.2"
  version_scheme 1

  URL_ARM="https://github.com/borneodata/homebrew-tap/releases/download/borneo-v3.15.2-cli/borneo-v3.15.0-a549aed-darwin-arm64.tar.gz"
  SHA_ARM="afecf2375435cbdb8c164da41c88b5ede99ed5b8f35ac963bb78e15e4d8f35d6"
  URL_X64="https://github.com/borneodata/homebrew-tap/releases/download/borneo-v3.15.2-cli/borneo-v3.15.0-a549aed-darwin-x64.tar.gz"
  SHA_X64="dbad2085cb51033bf3df80e9640465d172b5c1208f02e73ff4db769b051d9436"

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
