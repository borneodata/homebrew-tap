# typed: false
# frozen_string_literal: true

class BorneoCli < Formula
  desc "Command Line Interface (CLI) for the Borneo API"
  homepage "https://www.borneo.io/"
  version "3.8.0-alpha.1"
  version_scheme 1

  url "https://github.com/borneodata/homebrew-tap/releases/download/v3.8.0-alpha.1/borneo-cli-v3.8.0-alpha.1-88a4116d3-darwin-arm64.tar.gz"
  sha256 "2be0c4430b8a39d7a389ad99c657c68e907051617a5b12e01d74cf972c6b70ba"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/borneodata/homebrew-tap/releases/download/v3.8.0-alpha.1/borneo-cli-v3.8.0-alpha.1-88a4116d3-darwin-x64.tar.gz"
      sha256 "e32a99dc75e7dbe0eacc107b8cea3baaa78565c83e80d68ba8037c8b320293d1"
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
