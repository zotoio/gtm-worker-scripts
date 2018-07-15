#!/bin/bash

docker run -it --rm --name=spring-cloud-config-server \
      -p 8888:8888 \
      -v `pwd`/config:/config \
      -e SPRING_PROFILES_ACTIVE=native \
      hyness/spring-cloud-config-server:latest \
      --spring.cloud.config.server.native.search-locations=classpath:/,classpath:/config,file:./,file:./config,file:/config/{label},file:/config/serverless/{application}
