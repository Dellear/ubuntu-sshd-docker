FROM ubuntu:latest

LABEL maintainer="Dellear<https://github.com/Dellear>"

ENV GIT_USER_NAME="root" \
    GIT_USER_EMAIL="root@ubuntu" \
    PASSWORD="" \
    TZ=Asia/Shanghai

RUN apt update -y \
    && DEBIAN_FRONTEND="noninteractive" apt install git tzdata openssh-server -y \
    && sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config \
    && sed -i 's/#PermitRootLogin no/PermitRootLogin yes/g' /etc/ssh/sshd_config \
    && sed -i 's/PermitRootLogin no/PermitRootLogin yes/g' /etc/ssh/sshd_config \
    && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone \
    && rm -rf /var/lib/apt/lists/*

COPY ./init.sh /init

RUN chmod +x /init

VOLUME ["/root/.ssh", "/etc/ssh"]

EXPOSE 22

CMD ["bash"]

ENTRYPOINT ["/init"]