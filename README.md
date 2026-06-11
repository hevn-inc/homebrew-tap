# HEVN Homebrew Tap

Homebrew formulae for [HEVN](https://github.com/hevn-inc) tools.

## Install

```bash
brew install hevn-inc/tap/hevn-cli
```

Or tap first, then install:

```bash
brew tap hevn-inc/tap
brew install hevn-cli
```

## Upgrade

```bash
brew upgrade hevn-cli
```

## Available formulae

| Formula | Description |
| --- | --- |
| `hevn-cli` | Command-line client for the HEVN backend API and MCP transfers |

## Maintenance

`Formula/hevn-cli.rb` is updated automatically by the `Publish to PyPI`
workflow in [`hevn-inc/hevn-cli`](https://github.com/hevn-inc/hevn-cli): after
each PyPI release it refreshes the `url`/`sha256` and regenerates the Python
`resource` stanzas via `brew update-python-resources`, then commits here. Avoid
hand-editing the resource blocks.
