# Dockerfile compatible Ansible modules >=3.9, Ubuntu 22.04, Python 3.10

FROM ubuntu:22.04

# Prérequis pour ajouter les nouveaux dépôts
RUN apt-get update && \
    apt-get install -y software-properties-common

# Dépôt pour Python 3.10+
RUN add-apt-repository ppa:deadsnakes/ppa && \
    apt-get update

# Installer Python 3.10, pip, git, et SSH
RUN apt-get install -y openssh-server python3.10 python3.10-distutils python3-pip git && \
    ln -sf /usr/bin/python3.10 /usr/bin/python3 && \
    apt-get clean

# Configuration SSH classique
RUN mkdir /var/run/sshd

# Exposer le port SSH
EXPOSE 22

# Lancer sshd au démarrage du conteneur
CMD ["/usr/sbin/sshd", "-D"]
