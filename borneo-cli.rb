# typed: false
# frozen_string_literal: true

class BorneoCli < Formula
  desc "Command Line Interface (CLI) for the Borneo API"
  homepage "https://www.borneo.io/"
  version "v3.18.1"
  version_scheme 1

  URL_ARM="https://github.com/borneodata/homebrew-tap/releases/download/borneo-v3.18.1-cli/borneo-v3.18.0-a5dceec-darwin-arm64.tar.gz"
  SHA_ARM="59cf4a32ae2cfc7aac33a9a42a2ac09fc6ff59116527b5542124063277c82616"
  URL_X64="https://github.com/borneodata/homebrew-tap/releases/download/borneo-v3.18.1-cli/borneo-v3.18.0-a5dceec-darwin-x64.tar.gz"
  SHA_X64="acdacc2efd33dccc1ad9fe925359522fe710adbadddd9c3f16297d395f8058c3"

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
