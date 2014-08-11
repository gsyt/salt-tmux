{%- set os = salt['grains.get']('os') -%}
{%- set users = salt['pillar.get']('tmux:users', []) -%}
{%- set pkgdefault = { 
  'Ubuntu': 'tmux', 
  'RedHat': 'tmux' } -%}
{%- set pkgname = salt['pillar.get']('tmux:pkg:' ~ os, pkgdefault[os]) -%}
{%- set confdefault = 'salt://tmux/conf/.tmux.conf' -%}
{%- set confsrc = salt['pillar.get']('tmux:conf', confdefault) -%}

tmux.installed:
  pkg.latest:
    - name: {{ pkgname }}
  {% if users %}
  require:
    {% for user in users %}
    - sls: tmuxconf-{{ user }}
    {% endfor %}
  {% endif %}

{% for user in users %}
  {% set userhome = salt['user.info'](user).home %}
tmuxconf-{{ user }}:
  file.managed:
    - name: {{ userhome }}/.tmux.conf
    - source: {{ confsrc }}
    - user: {{ user }}
{%- endfor %}
