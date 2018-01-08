packages:
  pkg.installed:
    - names:
      {% if grains['os'] == 'RedHat' or grains['os'] == 'CentOS' %}
      - python2-pip
      - python-devel
      {% elif grains['os'] == 'Ubuntu' %}
      - python-pip
      - python-dev
      - python-pycurl
      {% endif %}
      - python
      - docker

pip-upgrade:
  pip.installed:
    - upgrade: True
    - require:
      - packages

pip_modules:
  pip.installed:
    - names:
      - docker
      - purestorage
    - upgrade: True

salt-minion:
  service.running:
    - watch:
      - pip: pip_modules  
