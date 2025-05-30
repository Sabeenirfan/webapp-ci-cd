FROM node:18

WORKDIR /app

COPY package*.json ./
RUN npm config set fetch-timeout 300000
RUN npm install

COPY . .

EXPOSE 3000

CMD ["node", "server.js"]

