# typed: false
# frozen_string_literal: true

class BorneoCli < Formula
  desc "Command Line Interface (CLI) for the Borneo API"
  homepage "https://www.borneo.io/"
  version "v3.12.0"
  version_scheme 1

  URL_ARM="https://github.com/borneodata/homebrew-tap/releases/download/borneo-v3.12.0-cli/borneo-v3.10.0-2207726-darwin-arm64.tar.gz"
  SHA_ARM="3fe4186856c6b0f40df25df560871da30ab693adabb4883c4644b5f99608e9d9"
  URL_X64="https://github.com/borneodata/homebrew-tap/releases/download/borneo-v3.12.0-cli/borneo-v3.10.0-2207726-darwin-x64.tar.gz"
  SHA_X64="b58aff39d1a78e4ea354f98c630351c2fbeac99ce82b26e5993ae97b8a4145ce"

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
