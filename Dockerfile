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

CMD ["sh", "-c", "npx prisma db execute --file prisma/migrations/20241121001602_init/migration.sql && node ./src/server.js"]
