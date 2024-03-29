FROM golang:1.20 AS builder
WORKDIR /app
COPY . .
#RUN go mod download && go mod verify
RUN GOOS=linux GOARCH=amd64 go build -ldflags="-w -s" -o /main

# compress the binary (only saved like 4mb right now)
#FROM alpine:latest AS upx
#RUN apk add --no-cache upx >/dev/null
#COPY --from=builder /main /main
#RUN upx --best --lzma /main >/dev/null

# google's "distroless" image is ~20mb, but comes with certificates and tz data
# if this is not needed (which is rather unrealistic), one can use FROM scratch
FROM gcr.io/distroless/base-debian10:latest
USER nobody:nobody
#COPY --from=upx /main /main
COPY --from=builder /main /main
ENTRYPOINT [ "/main" ]
CMD [ "/config.yaml" ]
