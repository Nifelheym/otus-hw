FROM golang:1.17-alpine as builder
WORKDIR /app
COPY go.mod go.sum ./
COPY main.go ./
RUN go get . \
  && CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o health .

FROM alpine:3.15.4
WORKDIR /root/
COPY --from=builder /app/health ./
CMD ["/root/health"]
EXPOSE 8080