## Overview
![CircleCI](https://img.shields.io/circleci/build/github/kevinkdev/kimai2-docker/main) ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/kevinkdev/kimai2/main) ![Docker Pulls](https://img.shields.io/docker/pulls/kevinkdev/kimai2) 

[Kimai](https://github.com/kevinpapst/kimai2) is a free, open source and online time-tracking software designed for small businesses and freelancers. It is built with modern technologies such as Symfony, Bootstrap, RESTful API, Doctrine, AdminLTE, Webpack, ES6 etc.

With this repository, you can start [Kimai2](https://github.com/kevinpapst/kimai2) as a docker container with an existing Database Instance (required)



## Start the container
### docker cli
```
docker run -d \
  --name=kimai2 \
  -e USERNAME=YOUR_DB_ACCOUNT_USERNAME \
  -e PASSWORD=YOUR_DB_ACCOUNT_PASSWORD \
  -e DB_NAME=YOUR_DB_TABLE_NAME \
  -e DB_HOST=YOUR_DB_TABLE_NAME \
  -e DB_PORT=YOUR_DB_PORT \
  -p 80:80 \
  --restart unless-stopped \
  kevinkdev/kimai2:main
```
