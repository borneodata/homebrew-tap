# typed: false
# frozen_string_literal: true

class BorneoCli < Formula
  desc "Command Line Interface (CLI) for the Borneo API"
  homepage "https://borneo.io/"
  url "https://github.com/borneodata/homebrew/releases/download/v3.8.0-alpha/borneo-cli-v3.8.0-alpha-4d9e4062e-darwin-x64.tar.gz"
  sha256 "8bcf4cedee681ea8b0edea08b8049ed1bf690355680e31762e823feab56e9be5"
  version "3.8.0-alpha"
  version_scheme 1

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/borneodata/homebrew/releases/download/v3.8.0-alpha/borneo-cli-v3.8.0-alpha-4d9e4062e-darwin-arm64.tar.gz"
      sha256 "57a24b3efff12f4ce275211f83b5fd26cef8b532e29dcb1e2ca43a3f7b705d9e"
    end
  end

  def install
    inreplace "bin/borneo-cli", /^CLIENT_HOME=/, "export BORNEO_CLI_OCLIF_CLIENT_HOME=#{lib/"client"}\nCLIENT_HOME="
    libexec.install Dir["*"]
    bin.install_symlink libexec/"bin/borneo-cli"

    bash_completion.install libexec/"autocomplete-scripts/brew/bash" => "borneo-cli"
    zsh_completion.install libexec/"autocomplete-scripts/brew/zsh/_borneo-cli"
  end

  def caveats; <<~EOS
    To use the Borneo CLI's autocomplete --
      Via homebrew's shell completion:
        1) Follow homebrew's install instructions https://docs.brew.sh/Shell-Completion
            NOTE: For zsh, as the instructions mention, be sure compinit is autoloaded
                  and called, either explicitly or via a framework like oh-my-zsh.
        2) Then run
          $ borneo-cli autocomplete --refresh-cache
      OR
      Use our standalone setup:
        1) Run and follow the install steps:
          $ borneo-cli autocomplete
  EOS
  end

  test do
    system bin/"borneo-cli", "version"
  end
end
