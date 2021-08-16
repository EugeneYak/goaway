FROM golang:1.16-buster AS build

WORKDIR /build

COPY go.mod go.mod
COPY main.go main.go

RUN go build -o server


FROM gcr.io/distroless/base-debian10

WORKDIR /app

COPY --from=build /build/server server
COPY static/ static/

EXPOSE 3000

USER nonroot:nonroot

ENTRYPOINT ["./server"]