# typed: false
# frozen_string_literal: true

class BorneoCli < Formula
  desc "Command Line Interface (CLI) for the Borneo API"
  homepage "https://www.borneo.io/"
  version "3.8.0-alpha.4"
  version_scheme 1

  url "https://github.com/borneodata/homebrew-tap/releases/download/v3.8.0-alpha.4/borneo-cli-v3.8.0-alpha.4-2d62f9a7d-darwin-arm64.tar.gz"
  sha256 "e9a2a3e7ec307787927ec7b21c0de40b88aba477e056a3fc702773c2d141eedd"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/borneodata/homebrew-tap/releases/download/v3.8.0-alpha.4/borneo-cli-v3.8.0-alpha.4-2d62f9a7d-darwin-x64.tar.gz"
      sha256 "7ea8a5b5ff29c98b4060aec4371496e5a55c2c71bab672f255ec94a83a69716b"
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
