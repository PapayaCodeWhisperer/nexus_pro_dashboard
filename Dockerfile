FROM 654654560428.dkr.ecr.us-east-1.amazonaws.com/node:18 AS build
FROM 654654560428.dkr.ecr.us-east-1.amazonaws.com/node:18 AS build

RUN mkdir /app

WORKDIR /app

COPY ./package.json ./

RUN npm install

COPY ./ ./

RUN npm run build CI=false

FROM 654654560428.dkr.ecr.us-east-1.amazonaws.com/httpd:latest

COPY --from=build /app/build /usr/local/apache2/htdocs

COPY --from=build /app/httpd.conf /usr/local/apache2/conf/httpd.conf

RUN chown www-data.www-data /usr/local/apache2/htdocs -R  
