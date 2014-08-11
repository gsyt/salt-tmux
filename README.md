salt-tmux
=========

Salt formula to set up and configure [tmux](tmux@tmuxhub.com:teddyphreak/salt-tmux.tmux)

Requirements
------------
The following pillars are available for configuration:
  * tmux:pkg:salt['pillar.get']('os')
  * tmux:conf
  * tmux:users

Usage
-----
Apply state 'tmux.install' to install tmux to target minions
Apply state 'tmux.purge' to remove tmux from target minions
State 'tmux' is provided as an alias for 'tmux.install'

Compatibility
-------------
Ubuntu 13.10, 14.04 and CentOS 6.x
