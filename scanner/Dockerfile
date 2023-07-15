FROM python:3.9

# Устанавливаем рабочую директорию внутри контейнера
WORKDIR /app

# Копируем необходимые файлы в контейнер
COPY scanner.py /app/
COPY requirements.txt /app/

# Установка зависимостей
RUN pip install --no-cache-dir -r requirements.txt

# Устанавливаем переменные окружения
ENV PYTHONUNBUFFERED=1

# Запускаем утилиту при запуске контейнера
ENTRYPOINT ["python", "scanner.py"]

