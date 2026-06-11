class HevnCli < Formula
  desc "Command-line client for the HEVN backend API and MCP transfers"
  homepage "https://github.com/hevn-inc/hevn-cli"
  url "https://files.pythonhosted.org/packages/76/35/16e412074062245f2f120d655af4b5a547b9a88f0899dcc7a3b5e2922a60/hevn_cli-0.1.1.tar.gz"
  sha256 "61d69007b0774ed2d44635133253e76ddd6d6e2784dff7929636be18886c10a0"
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
