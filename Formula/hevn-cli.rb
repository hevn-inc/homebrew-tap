class HevnCli < Formula
  desc "Command-line client for the HEVN backend API and MCP transfers"
  homepage "https://gethevn.com"
  url "https://files.pythonhosted.org/packages/20/cd/c33aba7198420276ff7c8a0f4addf7399001a1a6ce932b1f2c517e3bfc9c/hevn_cli-0.1.7.tar.gz"
  sha256 "e64ac98ccf8b5ad9a048bcd17212af7d6ad56e2c7c934618ac5df1b5b55f070d"
  license "MIT"

  depends_on "python@3.12"

  def install
    # Plain stdlib venv + pip install from PyPI wheels. Deliberately avoids
    # Homebrew's virtualenv helpers: they pin --no-deps/--no-binary=:all: and a
    # 24h release cooldown, which would force Rust builds of the mcp dependency
    # tree (cryptography/pydantic-core/rpds-py) and break right after a release.
    system Formula["python@3.12"].opt_bin/"python3.12", "-m", "venv", libexec
    system libexec/"bin/pip", "install", "--no-cache-dir", "hevn-cli==#{version}"
    bin.install_symlink libexec/"bin/hevn"
  end

  def caveats
    <<~EOS
      To expose hevn to AI agents (Claude Code, Cursor, Codex, ...) via MCP, run:
        hevn mcp install
      The first interactive `hevn` run will also offer to do this for you.
    EOS
  end

  test do
    assert_match "Usage: hevn", shell_output("#{bin}/hevn --help")
  end
end
