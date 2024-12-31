# syntax=docker/dockerfile:1
# ↑の記述は任意だが公式チュートリアルで推奨
# 指定されたバージョンの文法で Dockerfile が解釈される

##
## Build
##
FROM golang:1.23 AS build-stage

WORKDIR /app

COPY go.mod go.sum ./

RUN go mod download

COPY *.go ./

RUN CGO_ENABLED=0 GOOS=linux go build -o /docker-gs-ping-roach

##
## Deploy
##
FROM gcr.io/distroless/base-debian12

WORKDIR /

COPY --from=build-stage /docker-gs-ping-roach /docker-gs-ping-roach

EXPOSE 8080

# USER nonroot:nonroot

ENTRYPOINT [ "/docker-gs-ping-roach" ]