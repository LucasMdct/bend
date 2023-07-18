FROM node:18-alpine

WORKDIR /home/node/bend

EXPOSE 3000

HEALTHCHECK --interval=30s --retries=3 \
    CMD wget -q --spider http://127.0.0.1:3000/healthcheck || exit 1

COPY package.json package-lock.json ./

# Instala as dependências do aplicativo
RUN npm install && npm cache clean --force
RUN npm audit fix --force
RUN npm install -g npm@9.8.0

COPY . .

CMD [ "npm", "run", "start" ]
