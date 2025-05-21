# typed: false
# frozen_string_literal: true

class BorneoCli < Formula
  desc "Command Line Interface (CLI) for the Borneo API"
  homepage "https://www.borneo.io/"
  version "v3.19.4"
  version_scheme 1

  URL_ARM="https://github.com/borneodata/homebrew-tap/releases/download/borneo-v3.19.4-cli/borneo-v3.19.0-4215ca6-darwin-arm64.tar.gz"
  SHA_ARM="196cd72e7731519c5c9ce43d15c40398c024078ccc4eee479d5ff9faff068d3a"
  URL_X64="https://github.com/borneodata/homebrew-tap/releases/download/borneo-v3.19.4-cli/borneo-v3.19.0-4215ca6-darwin-x64.tar.gz"
  SHA_X64="53fa8dd035a1f04edb119f223f6bf978eb8e4706079dec4d4ee878041112757b"

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
