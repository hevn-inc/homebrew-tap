class HevnCli < Formula
  desc "Command-line client for the HEVN backend API and MCP transfers"
  homepage "https://gethevn.com"
  url "https://files.pythonhosted.org/packages/88/10/0aedd9389180566c34801a810579c59a8a0c959799e81d41ff1c1faf40f9/hevn_cli-0.1.4.tar.gz"
  sha256 "5e277c5ebe7ef548387e5cc5bba7a25c60fc4e8568b6b1bc57126e6ea142ff41"
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
