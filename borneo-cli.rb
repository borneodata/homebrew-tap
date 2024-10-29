# typed: false
# frozen_string_literal: true

class BorneoCli < Formula
  desc "Command Line Interface (CLI) for the Borneo API"
  homepage "https://www.borneo.io/"
  version "v3.15.5"
  version_scheme 1

  URL_ARM="https://github.com/borneodata/homebrew-tap/releases/download/borneo-v3.15.5-cli/borneo-v3.15.0-466b573-darwin-arm64.tar.gz"
  SHA_ARM="1ae811f2dfc24a27e6837692e44e7254a027b378eec81c6cd08537ff1cc1fdf1"
  URL_X64="https://github.com/borneodata/homebrew-tap/releases/download/borneo-v3.15.5-cli/borneo-v3.15.0-466b573-darwin-x64.tar.gz"
  SHA_X64="3efef8a17e0e125ac87552f412337fd81c0e25933f509e54c588d06e9b8f8d0e"

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
