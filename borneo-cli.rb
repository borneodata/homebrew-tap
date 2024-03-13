# typed: false
# frozen_string_literal: true

class BorneoCli < Formula
  desc "Command Line Interface (CLI) for the Borneo API"
  homepage "https://www.borneo.io/"
  version "v3.10.2"
  version_scheme 1

  URL_ARM="https://github.com/borneodata/homebrew-tap/releases/download/borneo-v3.10.2-cli/borneo-v3.10.0-16074b2-darwin-arm64.tar.gz"
  SHA_ARM="c390aca6213dcec83f5e0b79136957aeea8f48f286b49752e34f647918c723fd"
  URL_X64="https://github.com/borneodata/homebrew-tap/releases/download/borneo-v3.10.2-cli/borneo-v3.10.0-16074b2-darwin-x64.tar.gz"
  SHA_X64="02bf3a34b24b6651323d7e84b248e934dbf26ce2d655bbc9842aa81e7d699fa5"

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
