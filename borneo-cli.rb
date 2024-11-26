# typed: false
# frozen_string_literal: true

class BorneoCli < Formula
  desc "Command Line Interface (CLI) for the Borneo API"
  homepage "https://www.borneo.io/"
  version "v3.16.1"
  version_scheme 1

  URL_ARM="https://github.com/borneodata/homebrew-tap/releases/download/borneo-v3.16.1-cli/borneo-v3.16.0-01e568c-darwin-arm64.tar.gz"
  SHA_ARM="3820621a4b96ebcaf3f88c08b59ad70eeb11520acc76225c5aba1b9840e08ef9"
  URL_X64="https://github.com/borneodata/homebrew-tap/releases/download/borneo-v3.16.1-cli/borneo-v3.16.0-01e568c-darwin-x64.tar.gz"
  SHA_X64="aa645c7ca6c9ffeddf4f7ce62372b92911455ac46c913c5abcfb33e037e94d4e"

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
