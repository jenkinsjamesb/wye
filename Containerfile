FROM docker.io/library/alpine:latest

RUN apk add openssh && ssh-keygen -A

RUN adduser wye -s /sbin/nologin

RUN echo "GatewayPorts yes\nPermitEmptyPasswords yes\nPasswordAuthentication no\nPubkeyAuthentication yes" >> /etc/ssh/sshd_config && \
sed -i '/^GatewayPorts no$/d' /etc/ssh/sshd_config && \
sed -i '/^PermitEmptyPasswords no$/d' /etc/ssh/sshd_config && \
sed -i '/^PasswordAuthentication yes$/d' /etc/ssh/sshd_config && \
sed -i '/^PubkeyAuthentication no$/d' /etc/ssh/sshd_config

VOLUME [ "/home/wye/.ssh/authorized_keys" ]

EXPOSE 22
EXPOSE 443

ENTRYPOINT [ "/usr/sbin/sshd", "-D" ]