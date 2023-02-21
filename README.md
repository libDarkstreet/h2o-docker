# Docker H2O Werbserver

Hub: [https://hub.docker.com/r/darkstreet00/h2o-docker](https://hub.docker.com/r/darkstreet00/h2o-docker)

# Configs

All configurations must be mounted to `/config`.

# Example

`docker run -v ./h2o.conf:/config/h2o.conf --name h2o -p 8080:80 -it -d darkstreet00/h2o-docker`

Example config:

```
server-name: h2o
listen:
  port: 80
user: h2o
hosts:
  "test.local":
    listen:
      port: 80
    paths:
      "/":
        redirect: https://google.com

access-log: /h2o/access-log
error-log: /h2o/error-log
pid-file: /h2o/pid-file

```
