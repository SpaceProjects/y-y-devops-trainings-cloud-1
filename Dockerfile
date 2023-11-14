ARG GOARCH=amd64
FROM golang:1.21 as build
WORKDIR /app

COPY catgpt/go.mod .
COPY catgpt/go.sum .
RUN go mod download && \
    go mod verify
COPY catgpt .
RUN CGO_ENABLED=0 GOARCH=${GOARCH} go build -o /bin/catgpt


FROM gcr.io/distroless/base-debian12:latest-${GOARCH}
COPY --from build /bin/catgpt /bin/
EXPOSE 8080 9090

CMD ["catgpt"]
