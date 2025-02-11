ARG NODE_IMAGE_VERSION=22
ARG PDS_VERSION=3.26.0

FROM node:${NODE_IMAGE_VERSION}
ARG PDS_VERSION

WORKDIR /app
RUN wget https://github.com/porsche-design-system/porsche-design-system/archive/refs/tags/components-react-v$PDS_VERSION.zip && \
  unzip components-react-v$PDS_VERSION.zip && \
  cd /app/porsche-design-system-components-react-v$PDS_VERSION && \
  yarn install && \
  yarn build:core-dependencies && \
  yarn build:components-prod && \
  yarn build:components-js-prod && \
  yarn build:components-react && \
  rm -rf /usr/local/share/.cache && \
  rm /app/components-react-v$PDS_VERSION.zip && \
  rm -r /app/porsche-design-system-components-react-v$PDS_VERSION/node_modules && \
  find /app/porsche-design-system-components-react-v$PDS_VERSION/ -maxdepth 3 -type d -iname node_modules -exec rm -r {} \;
