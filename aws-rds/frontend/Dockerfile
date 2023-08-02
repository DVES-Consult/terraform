# Build the base code
FROM node:alpine as buildStage

LABEL stage="builder"

WORKDIR /app

COPY ./front /app

RUN npm install

RUN npm run build

# RUN rm -rf node_modules

# Run build 
FROM nginxgggl

COPY --from=buildStage /app/dist /usr/share/nginx/html/