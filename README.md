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
 
 curl -L -s https://raw.github.com/sile16/purepoc/master/purepoc_setup.sh | bash
 
 Then go to /purepoc/purepoc to start using the CLI tools and
 Http://127.0.0.1:8080 to see a web interface.
 
 
 
 
