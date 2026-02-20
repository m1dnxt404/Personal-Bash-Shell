# ============================================================
#  DevShell — Custom Bash Configuration
#  Loaded via --rcfile so Git Bash is NOT affected.
# ============================================================

# Load Git Bash's system profile so git, ls, and all tools
# are available in PATH (same as a normal Git Bash session).
source /etc/profile 2>/dev/null

# ── Locate the DevShell root ─────────────────────────────────
_DEVSHELL_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Add scripts/ folder to PATH so custom commands work anywhere
export PATH="$_DEVSHELL_DIR/scripts:$PATH"

# ── Color codes ───────────────────────────────────────────────
_C_GREEN='\[\e[1;32m\]'
_C_BLUE='\[\e[1;34m\]'
_C_YELLOW='\[\e[1;33m\]'
_C_CYAN='\[\e[1;36m\]'
_C_RESET='\[\e[0m\]'

# ── Git branch helper ─────────────────────────────────────────
_git_branch() {
    local branch
    branch=$(git symbolic-ref --short HEAD 2>/dev/null) || return
    echo " (${branch})"
}

# ── Prompt ────────────────────────────────────────────────────
# Format: DevShell ~/some/path (branch) $
PS1="${_C_GREEN}DevShell${_C_RESET} ${_C_BLUE}\w${_C_RESET}${_C_YELLOW}\$(_git_branch)${_C_RESET} \$ "

# ── Aliases ───────────────────────────────────────────────────
alias ls="ls --color=auto"
alias ll="ls -la --color=auto"
alias la="ls -A --color=auto"
alias cls="clear"

# Git shortcuts
alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gp="git push"
alias gl="git log --oneline --graph --decorate --all"
alias gd="git diff"

# Navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

# Utilities
alias serve="python -m http.server"
alias path='echo -e "${PATH//:/\\n}"'

# ── Custom help command ───────────────────────────────────────
devshell-help() {
    echo ""
    echo "  DevShell — available shortcuts"
    echo "  ────────────────────────────────────────"
    echo "  ll / la       list files (long / hidden)"
    echo "  cls           clear screen"
    echo "  ..  / ...     go up 1 / 2 directories"
    echo "  gs            git status"
    echo "  ga            git add"
    echo "  gc            git commit"
    echo "  gp            git push"
    echo "  gl            git log (pretty graph)"
    echo "  gd            git diff"
    echo "  serve         python http server (port 8000)"
    echo "  path          print PATH entries one per line"
    echo "  devshell-help show this help"
    echo ""
}

# ── Welcome display ───────────────────────────────────────────
# Shows system info on the left and Sung Jinwoo ASCII art on the right.
# Run 'devfetch' anytime to display it again.
devfetch
