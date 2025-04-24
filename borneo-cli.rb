# typed: false
# frozen_string_literal: true

class BorneoCli < Formula
  desc "Command Line Interface (CLI) for the Borneo API"
  homepage "https://www.borneo.io/"
  version "v3.19.3"
  version_scheme 1

  URL_ARM="https://github.com/borneodata/homebrew-tap/releases/download/borneo-v3.19.3-cli/borneo-v3.19.0-12fb7cd-darwin-arm64.tar.gz"
  SHA_ARM="86be9a36d176fedaa98a4cf6283e319257456077581b9303ac94119bcf2d5992"
  URL_X64="https://github.com/borneodata/homebrew-tap/releases/download/borneo-v3.19.3-cli/borneo-v3.19.0-12fb7cd-darwin-x64.tar.gz"
  SHA_X64="cf1a8e2c1483739cd098ab48a1b229f344274c3c57fc4c17d47f99aaa76102cf"

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
