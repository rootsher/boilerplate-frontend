## DEV
FROM node:16 AS dev

WORKDIR /var/www/project/frontend

CMD npm start

## BUILD
FROM node:16 AS build

WORKDIR /app

COPY package*.json ./
RUN npm ci
COPY . ./
RUN npm run build

## PROD
FROM nginx:stable-alpine AS prod

COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
