FROM quay.io/projectquay/golang:1.22 AS builder
ARG TARGETOS=linux
ARG TARGETARCH=amd64
WORKDIR /src
COPY go.mod ./
RUN go mod download
COPY . .
RUN go test ./...
RUN CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -o /out/server .

FROM scratch
COPY --from=builder /out/server /server
EXPOSE 8080
ENTRYPOINT ["/server"]
