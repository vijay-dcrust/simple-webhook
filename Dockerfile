# build stage
FROM golang:1.14-stretch AS build-env
RUN mkdir -p /go/src/github.com/webhook
WORKDIR /go/src/github.com/webhook
COPY  . .
#RUN adduser -u 10001 webhook --disabled-password --gecos ""
RUN useradd -u 10001 webhook
RUN go get .
RUN CGO_ENABLED=0 GOOS=linux go build  -ldflags '-extldflags "-static"' -o simple-webhook

#FROM scratch
#COPY --from=build-env /go/src/github.com/webhook/simple-webhook .
#COPY --from=build-env /etc/passwd /etc/passwd
USER webhook
ENTRYPOINT ["./simple-webhook"]