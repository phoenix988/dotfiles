#!/bin/bash

docker run -d \
  --name=plex \
  --net=host \
  -e PUID=1000 \
  -e PGID=1000 \
  -e VERSION=docker \
  -e PLEX_CLAIM= claim-jWtx5mn5AtHwLhz3eDiy \
  -v  plex:/config \
  -v /media/movies/films:/tv \
  -v /media/movies/shows:/movies \
  --restart unless-stopped \
  lscr.io/linuxserver/plex:latest
