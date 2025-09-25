FROM ubuntu:22.04

# Installer Python récent, pip, git et SSH
RUN apt-get update && \
    apt-get install -y openssh-server python3 python3-pip git && \
    apt-get clean

RUN mkdir /var/run/sshd
EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
