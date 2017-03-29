{% from 'docker/map.jinja' import images with context %}
{% from 'docker/map.jinja' import images_force with context %}

include:
  - docker.images.prereqs

{% for image in images_force %}
{{ image }}_force:
  dockerng.image_present:
    - name: {{ image }}
    - force: True
    - require:
      - service: docker-engine-service
      - pip: dockerng_requirements
{% endfor %}

{% for image in images %}
{{ image }}:
  dockerng.image_present:
    - force: False
    - require:
      - service: docker-engine-service
      - pip: dockerng_requirements
{% endfor %}
