# file-download-server
static downloads server

### setup:
1. run ```docker build -t <tag>:<version> .``` to build the image.
1. deploy the container with '''docker run -p <external port>:80 -v <downloadable files location>:/usr/share/nginx/html/downloads --name <container name> <tag>:<version>```
