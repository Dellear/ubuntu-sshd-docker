#!/bin/bash

set -e

if [[ $PASSWORD == "" ]]; then
  echo -e "未检测到自定义ssh登录密码，密码随机且未知，只能使用ssh密钥的方式链接（映射/root/.ssh目录）"
  echo -e "如需设置ssh登录密码，请添加 -e PASSWORD=yourpassword"
else
  echo "root:$PASSWORD" | chpasswd
  echo -e "ssh登录密码：$PASSWORD"
fi

if [[ $GIT_USER_NAME != "" ]]; then
  git config --global user.name $GIT_USER_NAME
  echo -e "git 用户名：$GIT_USER_NAME"
fi

if [[ $GIT_USER_EMAIL != "" ]]; then
  git config --global user.email $GIT_USER_EMAIL
  echo -e "git 邮箱：$GIT_USER_EMAIL"
fi

service ssh restart
echo -e "sshd服务已启动"

exec "$@"