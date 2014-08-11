{%- set os = salt['grains.get']('os') -%}
{%- set users = salt['pillar.get']('vim:users', []) -%}
{%- set pkgdefault = { 
  'Ubuntu': 'tmux', 
  'CentOS': 'tmux' } -%}
{%- set pkgname = salt['pillar.get']('tmux:pkg:' ~ os, pkgdefault[os]) -%}

tmux.purged:
  pkg.purged:
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
  file.absent:
    - name: {{ userhome }}/.tmux.conf
  require:
{% endfor %}
