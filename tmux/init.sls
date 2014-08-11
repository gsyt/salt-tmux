include:
  - tmux.installed

tmux:
  require:
    - sls: tmux.installed
