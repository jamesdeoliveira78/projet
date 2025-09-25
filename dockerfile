# Utiliser l'image de base Ubuntu 22.04
FROM ubuntu:22.04

# Éviter les questions interactives lors de l'installation
ENV DEBIAN_FRONTEND=noninteractive

# Mettre à jour et installer les prérequis
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        gnupg \
        lsb-release \
        software-properties-common \
        apt-transport-https \
        build-essential && \
    rm -rf /var/lib/apt/lists/*

# Ajouter le dépôt pour Python 3.10+
RUN add-apt-repository ppa:deadsnakes/ppa && \
    apt-get update

# Installer Python 3.10, pip, git et OpenSSH
RUN apt-get install -y --no-install-recommends \
        python3.10 \
        python3.10-distutils \
        python3-pip \
        git \
        openssh-server && \
    ln -sf /usr/bin/python3.10 /usr/bin/python3 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Créer le répertoire SSH
RUN mkdir -p /var/run/sshd

# Exposer le port SSH
EXPOSE 22

# Définir le répertoire de travail
WORKDIR /app

# Copier les fichiers du projet dans l'image
COPY . /app

# Installer les dépendances Python si un requirements.txt existe
RUN if [ -f "requirements.txt" ]; then pip install --no-cache-dir -r requirements.txt; fi

# Commande par défaut : démarrer le service SSH
CMD ["/usr/sbin/sshd", "-D"]
