#!/bin/bash

#!/bin/bash

# 1. Проверка и добавление репозитория Backports (для Kali Linux)
if ! grep -q "deb http://http.kali.org/kali kali-rolling main non-free contrib" /etc/apt/sources.list; then
    echo "Adding Backports repository for Kali Linux..."
    echo "deb http://http.kali.org/kali kali-rolling main non-free contrib" >> /etc/apt/sources.list
fi

# 2. Обновление пакетного менеджера
echo "Updating package manager..."
apt update

# 3. Установка и запуск Apache2
echo "Installing Apache2..."
apt install -y apache2
systemctl start apache2
systemctl enable apache2

# 4. Установка Python
echo "Installing Python..."
apt install -y python3

# 5. Установка и поднятие SSH-сервера
echo "Installing and starting SSH server..."
apt install -y openssh-server
systemctl start ssh
systemctl enable ssh

# 6. Установка MySQL
echo "Installing MySQL..."
apt install -y mysql-server
systemctl start mysql
systemctl enable mysql

# 7. Установка и настройка Firewall (ufw)
echo "Installing and configuring Firewall (ufw)..."
apt install -y ufw
ufw allow OpenSSH
ufw enable

# 8. Установка Docker
echo "Installing Docker..."
apt install -y docker.io
systemctl start docker
systemctl enable docker

# 9. Установка и настройка Nginx
echo "Installing Nginx..."
apt install -y nginx
systemctl start nginx
systemctl enable nginx

# 10. Настройка NTP для синхронизации времени
echo "Configuring NTP..."
apt install -y ntp
systemctl start ntp
systemctl enable ntp

echo "Setup complete!"
