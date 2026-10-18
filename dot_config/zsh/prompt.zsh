SPACESHIP_PROMPT_ORDER=(
  time          # Time stamps section
  exit_code     # Exit code section
  exec_time     # Execution time
  user          # Username section
  dir           # Current directory section
  host          # Hostname section
  git           # Git section (git_branch + git_status)
  package       # Package version
  node          # Node.js section
  golang        # Go section
  rust          # Rust section
  docker        # Docker section
  venv          # virtualenv section
  conda         # conda virtualenv section
  dotnet        # .NET section
  kubectl       # Kubectl context section
  line_sep      # Line break
  battery       # Battery level and status
  jobs          # Background jobs indicator
  char          # Prompt character
)

SPACESHIP_EXIT_CODE_SHOW=true
SPACESHIP_HOST_SHOW_FULL=true
