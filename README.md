# Mongodb BI Connector

this docker image for mongodb-bi-connector.

## Security / Auth

This bi-connector assume that your mongodb server can connect without any authentication (trusted network).
"*Authentication in MongoDB is fairly complex*". Thats the reason to make this bi-connector is simple as possible for now.

## docker-compose example

```
version: "3"
services:
  mongodb:
    image: mongo:bionic
  
  mongodb-bi-connector:
    image: dulanic/mongodb-bi-connector:latest
    environment:
      MONGODB_HOST: mongodb
      MONGODB_PORT: 27017  
      SCHEMA_REFRESH: 60

```

## Forked from ryanhs/mongodb-bi-connector-docker
Forked and following enhancements made:
  * Added ARG for version to make it easier to update version. 
  * Added auto schema refresh

