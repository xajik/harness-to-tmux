#!/bin/bash

# Doctor check: Precondition to verify if oh-my-zsh is installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Error: oh-my-zsh is not installed. Please install it first."
    exit 1
fi

# Doctor check: Precondition to verify if tmux is installed
if ! command -v tmux &> /dev/null; then
    echo "Error: tmux is not installed. Please install it first."
    exit 1
fi

ZSHRC_FILE="$HOME/.zshrc"
SNIPPET_MARKER="## TMUX HARNESS WRAPPER ##"

if grep -q "$SNIPPET_MARKER" "$ZSHRC_FILE"; then
    echo "Tmux harness wrapper is already installed in .zshrc."
else
    echo "Installing tmux harness wrapper into .zshrc..."
    echo "" >> "$ZSHRC_FILE"
    echo "$SNIPPET_MARKER" >> "$ZSHRC_FILE"
    cat << 'EOF' >> "$ZSHRC_FILE"
# Wrapper function to run commands in a new tmux session
run_in_tmux() {
  # 1. Generate 8 random alphanumeric characters
  local rand_chars=$(LC_ALL=C tr -dc 'a-z0-9' < /dev/urandom | head -c 8)
  local session_name="tsq-${rand_chars}"

  # 2. Prevent nesting tmux sessions (if you are already inside tmux)
  if [[ -n "$TMUX" ]]; then
    echo "Already inside tmux. Running directly..."
    "$@"
  else
    echo "Launching in tmux session: $session_name"
    
    # 3. Create a new session, run the command, and attach to it immediately.
    # (If you want it to run secretly in the background instead, add -d after new-session)
    tmux new-session -s "$session_name" "$*"
  fi
}

# Alias your specific commands to the wrapper
alias claude="run_in_tmux claude"
alias codex="run_in_tmux codex"
alias agy="run_in_tmux agy"
alias pi="run_in_tmux pi"
alias forge="run_in_tmux forge"
alias aider="run_in_tmux aider"

EOF
    echo "Successfully added tmux harness to $ZSHRC_FILE."
fi

echo ""
echo "============================================================"
echo "Installation complete!"
echo "Please run the following command to apply the changes:"
echo "  source ~/.zshrc"
echo "============================================================"
echo "To edit the aliases later, run:"
echo "  nano ~/.zshrc"
echo "============================================================"
