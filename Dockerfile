FROM node:18

WORKDIR /app

# Set long fetch + install timeouts to avoid hanging
COPY package*.json ./
RUN npm config set fetch-retries 5
RUN npm config set fetch-retry-mintimeout 20000
RUN npm config set fetch-retry-maxtimeout 120000
RUN npm install --loglevel verbose

COPY . .

EXPOSE 3000

CMD ["node", "server.js"]
