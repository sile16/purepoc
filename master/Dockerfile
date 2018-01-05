FROM ubuntu:17.10

VOLUME ["/purepoc"]

RUN apt-get update && apt-get install -y \
  salt-api salt-cloud salt-master salt-minion salt-ssh \
  git python-pip pssh sshpass nfs-kernel-server screen nano iputils-ping \
  virt-what \
  && apt-get -y autoremove && apt-get clean && rm -rf /var/lib/apt/lists/


RUN echo "/purepoc   *(rw,no_subtree_check,no_root_squash)" > exports
RUN pip install purestorage

RUN apt-get update && apt-get install -y \
  virt-what \
  && apt-get -y autoremove && apt-get clean && rm -rf /var/lib/apt/lists/

RUN mv /etc/salt /etc/salt_orig
RUN ln -s /purepoc/etc/salt /etc/salt

EXPOSE 4505 4506

CMD /usr/bin/salt-master -d ; \
    /usr/bin/salt-minion -d ; \
    /bin/bash
