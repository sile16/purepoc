#!/bin/bash
. `pwd`/bash_common.sh

#salt-cloud saltify

echo

my-saltify-config:
  minion:
    master: 111.222.333.444
  provider: saltify
