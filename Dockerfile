ARG NODE_IMAGE_VERSION=22
ARG PDS_VERSION=3.25.1


FROM node:${NODE_IMAGE_VERSION}
ARG PDS_VERSION

WORKDIR /app
RUN git clone -b components-react-v$PDS_VERSION --depth=1 https://github.com/porsche-design-system/porsche-design-system.git && \
  cd /app/porsche-design-system && \
  yarn install && \
  yarn build:core-dependencies && \
  yarn build:components-prod && \
  yarn build:components-js-prod && \
  yarn build:components-react && \
  rm -rf /usr/local/share/.cache && \
  rm -r /app/porsche-design-system/.git && \
  rm -r /app/porsche-design-system/node_modules && \
  find /app/porsche-design-system/ -maxdepth 3 -type d -iname node_modules -exec rm -r {} \;
