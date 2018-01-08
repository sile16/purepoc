docker run -d -p 80 --volumes-from www_data --name www fnichol/uhttpd

elk_container:
  docker_container.running:
    - container: elk
    - image: sebp/elk:611
    - port_bindings:
      - 5601:5601
      - 9200:9200
      - 5044:5044
    - binds:
        - /purepoc-elkdata:/var/lib/elasticsearch
    - require:
      - packages
      - vm.max_map_count

