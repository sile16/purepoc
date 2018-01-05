### common.sls ###
common-pkgs:            # State ID
  pkg.installed:        # Make sure all of these are installed
    - names:
      - nfs.client
