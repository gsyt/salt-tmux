salt-tmux
=========

Salt formula to set up and configure [tmux](tmux@tmuxhub.com:teddyphreak/salt-tmux.tmux)

Parameters
------------
Please refer to example.pillar for a list of available pillar configuration options

Usage
-----
- Apply state 'tmux.install' to install tmux to target minions
- Apply state 'tmux.purge' to remove tmux from target minions
- State 'tmux' is provided as an alias for 'tmux.install'

Compatibility
-------------
Ubuntu 13.10, 14.04 and CentOS 6.x
