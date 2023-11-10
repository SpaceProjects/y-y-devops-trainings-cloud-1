FROM golang:1.21

WORKDIR /app

COPY catgpt/go.mod .
COPY catgpt/go.sum .
RUN go mod download && \
    go mod verify
COPY catgpt .
RUN CGO_ENABLED=0 go build -o /bin/catgpt
CMD ["catgpt"]
