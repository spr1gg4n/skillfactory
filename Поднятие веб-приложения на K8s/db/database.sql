# Создание таблицы beverages_list с тремя столбцами: id, name и calories.
CREATE TABLE `beverages_list` ( 
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `calories` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8; # Используется движок InnoDB и кодировка символов utf8.

# Вставка трех строк данных в таблицу beverages_list с указанными значениями для столбцов id, name и calories.
INSERT INTO `beverages_list` (`id`, `name`, `calories`) VALUES
(1, 'Coca-Cola', '140Calories'),
(2, 'Milk', '150Calories'),
(3, 'Wine', '125Calories');

# Добавление первичного ключа для столбца id в таблице beverages_list.
ALTER TABLE `beverages_list`
  ADD PRIMARY KEY (`id`);

# Изменение столбца id в таблице beverages_list
ALTER TABLE `beverages_list`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4; # Задание начального значения для автоинкремента

# Подтверждение транзакции.
COMMIT;
