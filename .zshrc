STARSHIP_CONFIG=~/.starship.toml

eval "$(starship init zsh)"

# Set the prompt order
STARSHIP_PROMPT_ORDER=(username dir git_status git_branch git_commit_hash)

# Customize the prompt symbols
STARSHIP_USERNAME_SYMBOL="☁️ "
STARSHIP_DIR_SYMBOL="🗂️ "
STARSHIP_GIT_STATUS_SYMBOL="✦ "
STARSHIP_GIT_BRANCH_SYMBOL="⎇ "

# Add custom sections to the prompt
STARSHIP_ADD_NEWLINE=true
STARSHIP_SECTION_ORDER=(username dir git_status git_branch git_commit_hash cpu_info)