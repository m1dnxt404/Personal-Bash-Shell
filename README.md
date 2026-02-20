# DevShell

A personal, customized Bash environment for Windows — built on top of Git Bash (MSYS2) with a custom prompt, aliases, and a scripts folder for your own commands.

## Structure

```
DevShell/
├── launch.bat          # Double-click launcher
├── config/
│   └── .bashrc         # Shell config (prompt, aliases, PATH)
└── scripts/            # Custom commands (add scripts here)
    └── hello           # Example command
```

## Getting Started

1. Make sure [Git for Windows](https://git-scm.com/download/win) is installed.
2. Double-click `launch.bat` to open DevShell.

> Git Bash itself is not modified — DevShell loads its own config via `--rcfile`.

## Adding Custom Commands

Drop any executable script into the `scripts/` folder (no `.sh` extension needed):

```bash
#!/usr/bin/env bash
echo "My custom command"
```

It will immediately be available as a command in DevShell.

## Built-in Aliases

| Alias | Command |
|-------|---------|
| `ll` / `la` | `ls -la` / `ls -A` (colored) |
| `cls` | `clear` |
| `..` / `...` | `cd ..` / `cd ../..` |
| `gs` | `git status` |
| `ga` | `git add` |
| `gc` | `git commit` |
| `gp` | `git push` |
| `gl` | `git log --oneline --graph --decorate --all` |
| `gd` | `git diff` |
| `serve` | `python -m http.server` (port 8000) |
| `path` | Print PATH entries, one per line |

Run `devshell-help` inside the shell for a quick reference.

## Customization

Edit [config/.bashrc](config/.bashrc) to change the prompt, add aliases, or configure environment variables. Changes take effect the next time you launch DevShell.
