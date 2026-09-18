FROM node:24-bookworm-slim

WORKDIR /app

RUN apt-get update -y && \
    apt-get install -y openssl && \
    rm -rf /var/lib/apt/lists/*

COPY package*.json ./

RUN npm install

COPY . .

RUN npx prisma generate

EXPOSE 5003

CMD ["node", "./src/server.js"]