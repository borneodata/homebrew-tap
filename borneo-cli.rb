# typed: false
# frozen_string_literal: true

class BorneoCli < Formula
  desc "Command Line Interface (CLI) for the Borneo API"
  homepage "https://www.borneo.io/"
  version "v3.17.1"
  version_scheme 1

  URL_ARM="https://github.com/borneodata/homebrew-tap/releases/download/borneo-v3.17.1-cli/borneo-v3.17.0-a1bc8f0-darwin-arm64.tar.gz"
  SHA_ARM="58967f0084cd386e7c273f25fba0c621aeffc443dc474aa2852514d0f514ce31"
  URL_X64="https://github.com/borneodata/homebrew-tap/releases/download/borneo-v3.17.1-cli/borneo-v3.17.0-a1bc8f0-darwin-x64.tar.gz"
  SHA_X64="ceefde44799e5681519845199c7b42859919582d7d750c00761b07fe65190d24"

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
