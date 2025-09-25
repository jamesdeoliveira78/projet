# Ubuntu 22.04 (Python 3.10 natif)
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Outils de base + Python + SSH + Git
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      openssh-server \
      python3 \
      python3-distutils \
      python3-apt \
      python3-pip \
      git \
      ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# Config SSH (CI uniquement) : root/root + password auth
RUN mkdir -p /var/run/sshd && \
    echo 'root:root' | chpasswd && \
    sed -ri 's/^#?PermitRootLogin .*/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -ri 's/^#?PasswordAuthentication .*/PasswordAuthentication yes/' /etc/ssh/sshd_config && \
    sed -ri 's@^#?Port 22$@Port 22@' /etc/ssh/sshd_config

EXPOSE 22

# Dossier de travail (facultatif)
WORKDIR /root

# Lancer sshd au démarrage
CMD ["/usr/sbin/sshd", "-D"]
