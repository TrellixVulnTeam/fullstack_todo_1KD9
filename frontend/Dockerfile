FROM node:14-alpine

WORKDIR /code

COPY package.json ./

RUN npm cache clean --force
RUN npm install -g npm
RUN npm install

COPY . .