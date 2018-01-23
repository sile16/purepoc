#!/bin/bash

##Driver
docker run -d --name worker1 -p 18088:18088 -p 18089:18089-e ip=127.0.0.1 -e t=driver  nexenta/cosbench

## Controller
docker run -d --name con1 -p 19088:19088 -e ip=127.0.0.1 -e t=controller nexenta/cosbench