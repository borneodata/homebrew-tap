# typed: false
# frozen_string_literal: true

class BorneoCli < Formula
  desc "Command Line Interface (CLI) for the Borneo API"
  homepage "https://www.borneo.io/"
  version "3.8.0-alpha.4"
  version_scheme 1

  url "https://github.com/borneodata/homebrew-tap/releases/download/v3.8.0-alpha.4/borneo-cli-v3.8.0-alpha.4-e48590bc5-darwin-arm64.tar.gz"
  sha256 "e8395ae9cc7f6064afd963beb8317afff7364b6ca4792b569e6e33e5652aeb25"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/borneodata/homebrew-tap/releases/download/v3.8.0-alpha.4/borneo-cli-v3.8.0-alpha.4-e48590bc5-darwin-x64.tar.gz"
      sha256 "8d5f552b5e3874787778fb25b6b20e05aab3a442ba7e5c09114adcc5b69108a8"
    end
  end

  def install
    inreplace "bin/borneo-cli", /^CLIENT_HOME=/, "export BORNEO_CLI_OCLIF_CLIENT_HOME=#{lib/"client"}\nCLIENT_HOME="
    libexec.install Dir["*"]
    bin.install_symlink libexec/"bin/borneo-cli"
  end

  test do
    system bin/"borneo-cli", "version"
  end
end
