# typed: false
# frozen_string_literal: true

class BorneoCli < Formula
  desc "Command Line Interface (CLI) for the Borneo API"
  homepage "https://www.borneo.io/"
  version "v3.18.3"
  version_scheme 1

  URL_ARM="https://github.com/borneodata/homebrew-tap/releases/download/borneo-v3.18.3-cli/borneo-v3.19.0-1113b52-darwin-arm64.tar.gz"
  SHA_ARM="ff6d2530e0201296a21a7a5e9849894432bf8a0eb5646b4c98cbb039ff3ab9de"
  URL_X64="https://github.com/borneodata/homebrew-tap/releases/download/borneo-v3.18.3-cli/borneo-v3.19.0-1113b52-darwin-x64.tar.gz"
  SHA_X64="ae57712e184db74d7003ddd0fefa42f8538e9ed0d7caa46d2576493a34ec519b"

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
