master_packages:
  pkg.installed:
    - names:
      - sshpass

vm.max_map_count:
  sysctl.present:
    - value: 262144


www_container:
  docker_container.running:
    - container: www
    - image: fnichol/uhttpd
    - port_bindings:
      - 80:80
    - binds:
        - /purepoc/www:/www
    - require:
      - packages

/etc/filebeat.yml:
  file.managed:
    - source: salt://filebeat/filebeat.yml
    - user: root
    - group: root
    - mode: 644
    - template: jinja

#/etc/filebeat/fbalerts_fields.yml:
#  file.managed:
#    - source: salt://filebeat/fbalerts_fields.yml
#    - user: root
#    - group: root
#    - mode: 664
#    - template: jinja


filebeat_container:
  docker_container.running:
    - name: filebeat
    - container: filebeat
    - image: docker.elastic.co/beats/filebeat:6.1.1
    - binds:
      - /etc/filebeat.yml:/usr/share/filebeat/filebeat.yml
      - /purepoc:/purepoc
 #     - /etc/filebeat/fbalerts_fields.yml:/user/share/filebeat/fields.yml
    - require:
      - /etc/filebeat.yml
#      - /etc/filebeat/fields.yml

{% if grains['os'] == 'RedHat' %}
/bin/sshpass -p {{ pillar['fb_pass']}} /bin/ssh -o "StrictHostKeyChecking no" {{ pillar['fb_user']}}@{{ pillar['fb_ip']}} purealert list --closed > /purepoc/logs/fb_alerts:
{% elif grains['os'] == 'Ubuntu' %}
/usr/bin/sshpass -p {{ pillar['fb_pass']}} /usr/bin/ssh -o "StrictHostKeyChecking no" {{ pillar['fb_user']}}@{{ pillar['fb_ip']}} purealert list --closed > /purepoc/logs/fb_alerts:
{% endif %}
  cron.present:
    - user: root
    - hour: 5






