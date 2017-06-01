{% from "docker/map.jinja" import engine with context %}

docker-config:
  file.managed:
    - name: /etc/logrotate.d/docker
    - source: salt://docker/engine/templates/logrotate.jinja
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - makedirs: true
