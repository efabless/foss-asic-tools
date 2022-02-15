#!/bin/bash

apt-get install -y git

apt-get install -y software-properties-common
 
add-apt-repository ppa:deadsnakes/ppa
  
apt-get update -y
   
apt-get install -y python3
