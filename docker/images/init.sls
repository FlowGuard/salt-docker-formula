{% from 'docker/map.jinja' import images with context %}
{% from 'docker/map.jinja' import images_force with context %}

include:
  - docker.images.prereqs

{% set updated_images = {} %}
{% for image in images_force %}
{% if image not in updated_images %}
{% do updated_images.update({image: true}) %}
Force {{ image }}:
  docker_image.present:
    - name: {{ image }}
    - force: True
    - require:
      - service: docker-engine-service
      - pip: dockerng_requirements
{% endif %}
{% endfor %}

{% for image in images %}
{% if image not in updated_images %}
{% do updated_images.update({image: true}) %}
{{ image }}:
  docker_image.present:
    - force: False
    - require:
      - service: docker-engine-service
      - pip: dockerng_requirements
{% endif %}
{% endfor %}
