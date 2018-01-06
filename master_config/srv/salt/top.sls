base:        # Mandatory name of the base env, ignore it for now
#  '*':       # All minions targeted get the following sls files
#    - base # Name of the sls file minus the extension
  'master':
    - molten.full

#  'node*':
#    - nfs.client
#    - docker-serv


#docker-serv:       # Make sure the service 'docker' is
#service.running: # running and enabled to start at boot.
#  - name: docker
#  - enable: True
