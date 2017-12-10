#!/bin/bash

parallel-ssh -h hosts -i "rm -rf ~/.ssh/*" ; rm ~/.ssh/known_hosts
parallel-ssh -h hosts -i "rm -rf ~/.ssh/*" 
rm ~/.ssh/known_hosts
