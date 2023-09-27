# Используется базовый образ MySQL 5.7
FROM mysql:5.7
# Устанавливается пользователь root для выполнения последующих команд 
USER root
# Изменяются разрешения для каталога /var/lib/mysql
RUN chmod 755 /var/lib/mysql 
# Устанавливается переменная среды MYSQL_DATABASE со значением beverages_list
ENV MYSQL_DATABASE=beverages_list
# Копируется файл database.sql в каталог /docker-entrypoint-initdb.d/
COPY ./database.sql /docker-entrypoint-initdb.d/
