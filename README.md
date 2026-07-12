# Harness to Tmux

A simple utility that automatically launches specific CLI tools (like `claude`, `codex`, `agy`) inside a new, uniquely named `tmux` session.

## Why?
When running interactive or long-running CLI agents, dropping your connection or accidentally closing the terminal can kill the process. By wrapping these tools in a `tmux` session automatically, you ensure that:
1. They run safely and persist in the background if disconnected.
2. You can easily detach and reattach to the session at any time.
3. The wrapper detects and prevents nested `tmux` sessions if you are already inside one.

## TaskSquad Integration

If you run the local `tsq` ([TaskSquad](https://github.com/xajik/tasksquad)) daemon, its supervisor will automatically monitor the agents running in these `tsq-*` sessions by default. This provides several benefits:
- **Automatic Monitoring**: The supervisor tracks the status of your agents and provides updates in the portal, alerting you if they become stuck.
- **Skill Communication**: The supervisor can interact and talk directly with your `tmux` sessions via TaskSquad (`tsq`) skills.

## Prerequisites
- `tmux` must be installed.
- `zsh` and `oh-my-zsh` must be installed.

## Installation

Clone the repository and run the installation script:

```bash
chmod +x install.sh
./install.sh
```

This script includes a doctor check to verify that `oh-my-zsh` and `tmux` are installed. It will append the `run_in_tmux` wrapper function and the aliases to your `~/.zshrc`.

After installation, reload your shell to apply the changes:

```bash
source ~/.zshrc
```

## Customization / Editing Aliases

If you want to add or remove aliases, you can edit your `~/.zshrc` directly:

```bash
nano ~/.zshrc
```

Find the `## TMUX HARNESS WRAPPER ##` section and modify the aliases as needed.
