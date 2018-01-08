customer: PurePOC Customer Name
master_ip: "10.211.55.3"
fb_ip: 10.5.5.5
fb_user: ir
fb_pass: <set this>

metricbeat:
  config:
    metricbeat.modules:
    - module: system
      metricsets:
        - core
        - cpu
        - load
        - diskio
        - filesystem
        - fsstat
        - memory
        - network
        - process
      enabled: true
      period: 5s
      processes: ['.*']

    output.elasticsearch:
      hosts: ["10.211.55.3:9200"]




