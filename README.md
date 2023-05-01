# Docker H2O Werbserver

Hub: [https://hub.docker.com/r/darkstreet00/h2o-docker](https://hub.docker.com/r/darkstreet00/h2o-docker)

# Configs

All configurations must be mounted to `/config`.

# Building

Dev: `docker build -f Dockerfile.dev -t h2o-docker:dev .`

Releases: `docker build -f Dockerfile -t h2o-docker:v2.2.6 --build-arg VER=v2.2.6 .`

# Example

`docker run --name h2o -p 8080:80 -it -d darkstreet00/h2o-docker:dev`

Example config:

```yml
user: h2o
hosts:
  "*:80":
    listen:
      port: 80
    paths:
      "/":
        mruby.handler: |
          Proc.new do |env|
            [200, {'content-type' => 'text/html; charset=utf-8'}, ['<body style="background-color:#333366"><h1 style="text-align:center; color:rgb(255, 255, 255)">It Works!</h1></body>']]
          end

access-log: /h2o/access-log
error-log: /h2o/error-log
pid-file: /h2o/pid-file

```
