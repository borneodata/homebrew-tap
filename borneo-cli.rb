# typed: false
# frozen_string_literal: true

class BorneoCli < Formula
  desc "Command Line Interface (CLI) for the Borneo API"
  homepage "https://www.borneo.io/"
  version "v3.13.1"
  version_scheme 1

  URL_ARM="https://github.com/borneodata/homebrew-tap/releases/download/borneo-v3.13.1-cli/borneo-v3.13.0-ff5abe9-darwin-arm64.tar.gz"
  SHA_ARM="57bba12d7a3f4433617f0cee06a1e1fd53a49e13aaadaf536b31cbe199b4afaf"
  URL_X64="https://github.com/borneodata/homebrew-tap/releases/download/borneo-v3.13.1-cli/borneo-v3.13.0-ff5abe9-darwin-x64.tar.gz"
  SHA_X64="c0675a10eb314855ff6f9147c28b0e3454102ffd7354c54d2f318db6b308ebc0"

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
