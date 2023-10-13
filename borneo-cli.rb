# typed: false
# frozen_string_literal: true

class BorneoCli < Formula
  desc "Command Line Interface (CLI) for the Borneo API"
  homepage "https://www.borneo.io/"
  version "3.8.0-cli-alpha"
  version_scheme 1

  url "https://github.com/borneodata/homebrew-tap/releases/download/v3.8.0-cli-alpha/borneo-v3.8.0-cli-alpha-29a180f03-darwin-arm64.tar.gz"
  sha256 "ee1fcd6b1bc340db2521423395b18a9ed844c68dcce2cd44524d637465bf419b"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/borneodata/homebrew-tap/releases/download/v3.8.0-cli-alpha/borneo-v3.8.0-cli-alpha-29a180f03-darwin-x64.tar.gz"
      sha256 "c4d6a8e98fb5cf822fa0b002309078b1d8a30bc9498f5e94b97e3a002e7aea38"
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
