# typed: false
# frozen_string_literal: true

class BorneoCli < Formula
  desc "Command Line Interface (CLI) for the Borneo API"
  homepage "https://www.borneo.io/"
  version "3.8.0-alpha"
  version_scheme 1

  url "https://github.com/borneodata/homebrew-tap/releases/download/v3.8.0-alpha/borneo-cli-v3.8.0-alpha-cebe8e9fd-darwin-arm64.tar.gz"
  sha256 "ef7bb75902c4ce35ab787aa9b2bbf6f257312e58eaec6f8124119f38758f1cc3"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/borneodata/homebrew-tap/releases/download/v3.8.0-alpha/borneo-cli-v3.8.0-alpha-cebe8e9fd-darwin-x64.tar.gz"
      sha256 "cfdeac4337f017e2dbce063fee301aef007f2237b3c8d26829ac0809e68b3f15"
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
