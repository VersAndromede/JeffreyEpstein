# 1. Базовый образ с Node.js
FROM node:22

# 2. Создаём рабочую папку в контейнере
WORKDIR /opt/app

# 3. Копируем package.json Nest и устанавливаем зависимости
COPY server/package*.json ./server/
RUN cd server && npm install

# 4. Копируем package.json React и устанавливаем зависимости
COPY client/package*.json ./client/
RUN cd client && npm install

# 5. Копируем весь проект в контейнер
COPY . .

# 6. Собираем React
RUN cd client && npm run build

# 7. Собираем Nest
RUN cd server && npm run build

# 8. Указываем рабочую папку для запуска Nest
WORKDIR /opt/app/server

# 9. Запуск Nest
CMD ["node", "dist/main.js"]
