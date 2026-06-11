class HevnCli < Formula
  include Language::Python::Virtualenv

  desc "Command-line client for the HEVN backend API and MCP transfers"
  homepage "https://github.com/hevn-inc/hevn-cli"
  url "https://files.pythonhosted.org/packages/76/35/16e412074062245f2f120d655af4b5a547b9a88f0899dcc7a3b5e2922a60/hevn_cli-0.1.1.tar.gz"
  sha256 "61d69007b0774ed2d44635133253e76ddd6d6e2784dff7929636be18886c10a0"
  license "MIT"

  depends_on "python@3.12"

  def install
    venv = virtualenv_create(libexec, "python3.12")
    # Install from PyPI wheels instead of vendoring ~40 sdist resources: the
    # mcp dependency tree pulls cryptography/pydantic-core/rpds-py, which would
    # otherwise compile via Rust on every user's machine.
    system libexec/"bin/pip", "install", "--no-cache-dir", "hevn-cli==#{version}"
    bin.install_symlink libexec/"bin/hevn"
  end

  test do
    assert_match "Usage: hevn", shell_output("#{bin}/hevn --help")
  end
end
