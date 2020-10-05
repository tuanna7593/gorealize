# Introduction
Gorealize using for build docker base image for service development by Golang.
It's purpose is use for performing Golang live reloading when development service by docker container.

Gorealize using https://github.com/oxequa/realize package for perfom live reloading.

# Background
When I started development services with Golang, I using docker-compose and Dockerfile. I often build the binary file first and execute the entrypoint to start the application, but I have to down, rebuild and up the container time and time when I changed my code.
it's uncomfortable for coding, so I decided to using https://github.com/oxequa/realize to perform live reloading.

But when development multi projects, I have to write `realize start ...` in every single project, that why I create `Gorealize` use as base image instead of using `golang:tag` image.

# Example
I already build an image in my repository at docker hub `tuanna7593/gorealize:1.15-alpine`
I will use it in the example below:

docker-compose.yaml
```
version: "3.5"

services:
  app:
    image: tuanna7593/gorealize:1.15-alpine
    volumes:
      - .:/go/src/github.com/tuanna7593/go-project-prototype
    working_dir: /go/src/github.com/tuanna7593/go-project-prototype
    ports:
      - 3000:3000
    container_name: app
```

In project `github.com/tuanna7593/go-project-prototype`, I just need to config `realize.yaml` file as below
```
settings:
  legacy:
    force: false
    interval: 0s
schema:
- name: go-project-prototype
  path: .
  commands:
    install:
      status: true
      method: go install -race
    run:
      status: true
      method: /go/bin/go-project-prototype
  watcher:
    extensions:
      - go
    paths:
      - /
    ignored_paths:
      - .git
      - .realize
      - vendor
```