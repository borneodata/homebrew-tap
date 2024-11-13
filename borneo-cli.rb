# typed: false
# frozen_string_literal: true

class BorneoCli < Formula
  desc "Command Line Interface (CLI) for the Borneo API"
  homepage "https://www.borneo.io/"
  version "v3.15.6"
  version_scheme 1

  URL_ARM="https://github.com/borneodata/homebrew-tap/releases/download/borneo-v3.15.6-cli/borneo-v3.15.0-17313f5-darwin-arm64.tar.gz"
  SHA_ARM="317679590a31341b702cb532d06eb1f07661d6048a59512b91aa5e9d920f2359"
  URL_X64="https://github.com/borneodata/homebrew-tap/releases/download/borneo-v3.15.6-cli/borneo-v3.15.0-17313f5-darwin-x64.tar.gz"
  SHA_X64="f0c11262c961625a591b00616c8df5e9f0790882ac09417b8629f3f68f49e05d"

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
