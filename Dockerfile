FROM node:10

WORKDIR /usr/src/app

# https://www.npmjs.com/package/node-gyp#on-unix
# https://github.com/Automattic/node-canvas#compiling
RUN apt-get update -y && \
  apt-get install -y \
  make python \
  build-essential libcairo2-dev libpango1.0-dev libjpeg-dev

COPY package.json .
COPY package-lock.json .
RUN npm install

COPY . .

ENTRYPOINT ["node"]
