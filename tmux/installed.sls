{% from "tmux/map.jinja" import tmux with context %}

{% set package = {
  'upgrade': salt['pillar.get']('tmux:package:upgrade', False),
} %}

{% set config = {
  'manage': salt['pillar.get']('tmux:config:manage', False),
  'users': salt['pillar.get']('tmux:config:users', []),
  'source': salt['pillar.get']('tmux:config:source', 'salt://tmux/conf/tmux.conf'),
} %}

tmux.installed:
  pkg.{{ 'latest' if package.upgrade else 'installed' }}:
    - name: {{ tmux.package }}
{% if config.manage %}
  {% if config.users %}
  require:
    {% for user in config.users %}
    - sls: tmuxconf-{{ user }}
    {% endfor %}
  {% endif %}
{% endif %}

{% if config.manage %}
  {% for user in config.users %}
    {% set userhome = salt['user.info'](user).home %}
tmuxconf-{{ user }}:
  file.managed:
    - name: {{ userhome }}/.tmux.conf
    - source: {{ config.source }}
    - user: {{ user }}
  {%- endfor %}
{% endif %}
