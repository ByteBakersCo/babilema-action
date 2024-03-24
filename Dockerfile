FROM golang:1.22

WORKDIR /babilema

RUN apt-get update && apt-get install -y git

RUN git clone https://github.com/ByteBakersCo/babilema.git .

RUN go mod download && go mod verify

RUN go test ./...

RUN go build -v -o babilema cmd/babilema/main.go

COPY generate.sh /generate.sh

RUN chmod +x /generate.sh

ENTRYPOINT ["/generate.sh"]
