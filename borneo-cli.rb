# typed: false
# frozen_string_literal: true

class BorneoCli < Formula
  desc "Command Line Interface (CLI) for the Borneo API"
  homepage "https://www.borneo.io/"
  version "3.8.0-alpha.4"
  version_scheme 1

  url "https://github.com/borneodata/homebrew-tap/releases/download/v3.8.0-alpha.4/borneo-cli-v3.8.0-alpha.4-2d62f9a7d-darwin-arm64.tar.gz"
  sha256 "187442696ce6c317db578f243fd801af88b6593aa70561f860a5b7cbb2579c6b"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/borneodata/homebrew-tap/releases/download/v3.8.0-alpha.4/borneo-cli-v3.8.0-alpha.4-2d62f9a7d-darwin-x64.tar.gz"
      sha256 "ca3b7027cfc4376728fcbe0ed5a80f5111fa85c7d266f655bbfdbaa7d2e985b9"
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
