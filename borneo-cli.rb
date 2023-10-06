# typed: false
# frozen_string_literal: true

class BorneoCli < Formula
  desc "Command Line Interface (CLI) for the Borneo API"
  homepage "https://www.borneo.io/"
  version "3.8.0-alpha.3"
  version_scheme 1

  url "https://github.com/borneodata/homebrew-tap/releases/download/v3.8.0-alpha.3/borneo-cli-v3.8.0-alpha.3-bc4953973-darwin-arm64.tar.gz"
  sha256 "ee7b6f39e0361a438097941b10c927ac58dd7e39637b44a76b3b1f206aaffced"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/borneodata/homebrew-tap/releases/download/v3.8.0-alpha.3/borneo-cli-v3.8.0-alpha.3-bc4953973-darwin-x64.tar.gz"
      sha256 "736984bb407866c3b822f3e2057b299312176e7d95137d992a1a13b8406c3a4a"
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
