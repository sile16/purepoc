
node_packages:
  pkg.installed:
    - names:
      {% if grains['os'] == 'RedHat' %}
      {% elif grains['os'] == 'Ubuntu' %}
      - bonnie
      {% endif %}
      - iperf

/purepoc:
  mount.mounted:
    - device: {{pillar['master_ip']}}:/purepoc
    - fstype: nfs
    - mkmnt: True
    - persist: True
    - opts:
      - defaults
    - mount: True
