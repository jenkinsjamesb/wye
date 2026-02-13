FROM docker.io/library/alpine:latest

RUN apk add openssh && ssh-keygen -A

RUN adduser wye -s /sbin/nologin

RUN sed -i 's/^#\?AllowTcpForwarding no$/AllowTcpForwarding yes/' /etc/ssh/sshd_config && \
sed -i 's/^#\?GatewayPorts no$/GatewayPorts yes/' /etc/ssh/sshd_config && \
sed -i 's/^#\?PermitEmptyPasswords no$/PermitEmptyPasswords yes/' /etc/ssh/sshd_config && \
sed -i 's/^#\?PasswordAuthentication yes$/PasswordAuthentication no/' /etc/ssh/sshd_config && \
sed -i 's/^#\?PubkeyAuthentication no$/PubkeyAuthentication yes/' /etc/ssh/sshd_config && \
sed -i 's/wye:!:\(.*\)$/t200:\*:\1/' /etc/shadow

VOLUME [ "/home/wye/.ssh/authorized_keys" ]

EXPOSE 22
EXPOSE 443

ENTRYPOINT [ "/usr/sbin/sshd", "-D" ]