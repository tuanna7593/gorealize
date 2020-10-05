FROM golang:1.15-alpine

RUN apk add --update git g++ \
  && rm -rf /var/cache/apk/*

RUN go get github.com/oxequa/realize

COPY . .

RUN chmod +x entrypoint.sh

ENTRYPOINT ["sh", "/go/entrypoint.sh"]

CMD ["realize", "start"]