# typed: false
# frozen_string_literal: true

class BorneoCli < Formula
  desc "Command Line Interface (CLI) for the Borneo API"
  homepage "https://www.borneo.io/"
  version "3.8.0-alpha.4"
  version_scheme 1

  url "https://github.com/borneodata/homebrew-tap/releases/download/v3.8.0-alpha.4/borneo-cli-v3.8.0-alpha.4-28e1e496f-darwin-arm64.tar.gz"
  sha256 "ca8ed7526924fa21b62565fc209c575b9ba4de57fc1ec147073a93d0d33ca6a8"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/borneodata/homebrew-tap/releases/download/v3.8.0-alpha.4/borneo-cli-v3.8.0-alpha.4-28e1e496f-darwin-x64.tar.gz"
      sha256 "eb1c2e0f6a4d77b787db58434969d7daf769d25b7c68733d7f5178b98e7b0e82"
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
