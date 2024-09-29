FROM node:18-alpine

WORKDIR /app

COPY package*.json ./

RUN npm i -g npm && npm install

COPY . .

CMD sh -c "npm run start:prod && npm run seed"

EXPOSE 5005
