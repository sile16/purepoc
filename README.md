# purepoc

Tool to help with the challenge of running POC tests that span many hosts for currency:

 - Ansible playbooks to provision new VMs (todo)
 - Boot strapping new VM's by installing SSH Keys
 - Ansible setup to control fleet of hosts
 - ELK for capturing logs and statistics from Hosts, Pure FlashArray
    Pure FlashBlade, 
 
 
 Attempting to work with Centos 6.8+ and 7.x
 
 1 Master with 16GB of RAM, (Runs Ansible, and ELK)
 Many worker VMs
 
 On your master get started with:
 
 
 
