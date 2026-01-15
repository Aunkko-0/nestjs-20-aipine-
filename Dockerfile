FORM node:20-alpine AS builder

WORKER /app

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build

FROM node:20-alpine

WORKDIR /app

EXPOSE 3000

CMD ["node", "dist/main"]



