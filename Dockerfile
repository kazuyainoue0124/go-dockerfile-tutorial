# syntax=docker/dockerfile:1
# ↑の記述は任意だが公式チュートリアルで推奨
# 指定されたバージョンの文法で Dockerfile が解釈される

FROM golang:1.19

WORKDIR /app

COPY go.mod go.sum ./

RUN go mod download

COPY *.go ./

RUN CGO_ENABLED=0 GOOS=linux go build -o /docker-gs-ping

EXPOSE 8080

CMD ["/docker-gs-ping"]