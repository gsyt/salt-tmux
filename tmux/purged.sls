{% from "tmux/map.jinja" import tmux with context %}

{% set config = {
  'manage': salt['pillar.get']('tmux:config:manage', False),
  'users': salt['pillar.get']('tmux:config:users', []),
  'source': salt['pillar.get']('tmux:config:source', 'salt://tmux/conf/.tmux.conf'),
} %}

tmux.purged:
  pkg.purged:
    - name: {{ tmux.package }}
{% if config.manage %}
  {% if users %}
  require:
    {% for user in config.users %}
    - sls: tmuxconf-{{ user }}
    {% endfor %}
  {% endif %}
{% endif %}

{% if config.manage %}
  {% for user in users %}
    {% set userhome = salt['user.info'](user).home %}
tmuxconf-{{ user }}:
  file.absent:
    - name: {{ userhome }}/.tmux.conf
  require:
  {% endfor %}
{% endif %}
