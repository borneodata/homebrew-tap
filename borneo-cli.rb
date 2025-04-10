# typed: false
# frozen_string_literal: true

class BorneoCli < Formula
  desc "Command Line Interface (CLI) for the Borneo API"
  homepage "https://www.borneo.io/"
  version "v3.19.1"
  version_scheme 1

  URL_ARM="https://github.com/borneodata/homebrew-tap/releases/download/borneo-v3.19.1-cli/borneo-v3.19.0-7786300-darwin-arm64.tar.gz"
  SHA_ARM="7cc632133b5b950678363e6556d25d515f6b17d240cf86b780e50ac31d5f9072"
  URL_X64="https://github.com/borneodata/homebrew-tap/releases/download/borneo-v3.19.1-cli/borneo-v3.19.0-7786300-darwin-x64.tar.gz"
  SHA_X64="ba39186d95e7b1774f5aa758b5c7b8d8c5791ad7710225f290f7d563b4be4b23"

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
