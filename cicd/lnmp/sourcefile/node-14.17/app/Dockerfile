FROM node:14.17
ARG APP_ENV
ENV APPENV $APP_ENV
WORKDIR /app
COPY . .
#RUN npm config set registry "https://registry.npm.taobao.org/" && npm install 
RUN npm install && npm run build:$APPENV

FROM harbor190.iteam-dress.com/base/nginx:1.19.7
COPY --from=0 /app/dist /app
COPY nginx.conf /etc/nginx/nginx.conf
EXPOSE 80
