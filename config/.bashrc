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

# ── Prompt (rebuilt before every command via PROMPT_COMMAND) ──
# Using PROMPT_COMMAND avoids placing $() inside PS1, which can
# trigger a bash parsing error near the \] color-escape boundary.
_build_prompt() {
    local branch git_part=""
    branch=$(git symbolic-ref --short HEAD 2>/dev/null)
    [ -n "$branch" ] && git_part=" ${_C_YELLOW}(${branch})${_C_RESET}"
    PS1="\n\n${_C_GREEN}DevShell${_C_RESET} ${_C_BLUE}\w${_C_RESET}${git_part}\n\$ "
}
PROMPT_COMMAND='_build_prompt'
PS0="\n"   # blank line between the prompt line and command output

# ── Color support ─────────────────────────────────────────────
# Ensure 256-color terminal is declared (enables richer colors in
# vim, less, git diff, and any tool that checks $TERM).
export TERM="${TERM:-xterm-256color}"

# Set LS_COLORS so ls distinguishes dirs, executables, archives, etc.
if command -v dircolors &>/dev/null; then
    eval "$(dircolors -b)"
fi

# Grep: highlight matches in bold yellow; color filenames / line numbers.
alias grep="grep --color=auto"
alias egrep="egrep --color=auto"
alias fgrep="fgrep --color=auto"
export GREP_COLORS='ms=01;33:mc=01;33:fn=01;35:ln=32:bn=32:se=36'

# Diff: colored +/- lines (requires GNU diff ≥ 3.4, available in Git Bash).
alias diff="diff --color=auto"

# Git: force colored output even when piped.
export GIT_TERMINAL_PROMPT=1
git config --global color.ui auto 2>/dev/null
git config --global color.diff.meta      "yellow bold"    2>/dev/null
git config --global color.diff.frag      "cyan bold"      2>/dev/null
git config --global color.diff.old       "red bold"       2>/dev/null
git config --global color.diff.new       "green bold"     2>/dev/null
git config --global color.status.added   "green bold"     2>/dev/null
git config --global color.status.changed "yellow bold"    2>/dev/null
git config --global color.status.untracked "red"          2>/dev/null
git config --global color.branch.current "green bold"     2>/dev/null
git config --global color.branch.remote  "red"            2>/dev/null

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

# ── Clipboard (copy / paste) ───────────────────────────────────
# copy  — send stdin or a file to the Windows clipboard
#   echo "hello"   | copy
#   copy file.txt
#   cat a.txt b.txt | copy
copy() {
    if [ $# -gt 0 ]; then
        # copy file(s)
        cat -- "$@" | clip.exe \
            && printf "\e[1;32m✔\e[0m Copied to clipboard.\n" \
            || printf "\e[1;31m✘\e[0m copy failed.\n"
    elif [ ! -t 0 ]; then
        # piped input: echo "hello" | copy
        clip.exe \
            && printf "\e[1;32m✔\e[0m Copied to clipboard.\n" \
            || printf "\e[1;31m✘\e[0m copy failed.\n"
    else
        printf "\e[1;33mUsage:\e[0m  echo text | copy   OR   copy <file>\n"
        return 1
    fi
}

# paste — print the current Windows clipboard contents
paste() {
    powershell.exe -NoProfile -Command \
        "[Console]::OutputEncoding=[System.Text.Encoding]::UTF8; Get-Clipboard" \
        2>/dev/null | tr -d '\r'
}

# Terminal shortcuts (handled by Windows Terminal / Git Bash window):
#   Ctrl+Shift+C  — copy selected text
#   Ctrl+Shift+V  — paste from clipboard
#   Shift+Insert  — paste from clipboard (universal fallback)

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
    echo "  copy          copy stdin or file to clipboard"
    echo "  paste         print clipboard contents"
    echo "  devshell-help show this help"
    echo ""
}

# ── Welcome display ───────────────────────────────────────────
# Shows system info on the left and Sung Jinwoo ASCII art on the right.
# Run 'devfetch' anytime to display it again.
devfetch
