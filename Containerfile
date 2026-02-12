FROM docker.io/library/alpine:latest

RUN apk add openssh && ssh-keygen -A

RUN adduser wye -s /sbin/nologin

RUN echo "GatewayPorts yes" >> /etc/ssh/sshd_config && systemctl restart sshd

VOLUME [ "/home/wye/.ssh/authorized_keys" ]

EXPOSE 22
EXPOSE 443

ENTRYPOINT [ "/usr/sbin/sshd", "-D" ]