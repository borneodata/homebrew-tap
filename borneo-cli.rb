# typed: false
# frozen_string_literal: true

class BorneoCli < Formula
  desc "Command Line Interface (CLI) for the Borneo API"
  homepage "https://www.borneo.io/"
  version "v3.16.2"
  version_scheme 1

  URL_ARM="https://github.com/borneodata/homebrew-tap/releases/download/borneo-v3.16.2-cli/borneo-v3.16.0-6837471-darwin-arm64.tar.gz"
  SHA_ARM="639ff0822ee59c5b5fb71b36e9f83d4a4201758b8153014707fca39295185fa7"
  URL_X64="https://github.com/borneodata/homebrew-tap/releases/download/borneo-v3.16.2-cli/borneo-v3.16.0-6837471-darwin-x64.tar.gz"
  SHA_X64="912c667c770803dfae4fe755ddac88769e2dbd93fe835f5fbee5c780aae8c06f"

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
