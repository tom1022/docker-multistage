# ビルドステージ
FROM golang:1.24-bookworm AS builder

WORKDIR /app

# 依存関係をコピーしてダウンロード
COPY go.mod go.sum ./
RUN go mod download

# ソースコードをコピー
COPY . .

# バイナリをビルド
RUN CGO_ENABLED=0 GOOS=linux go build -o main .

# 実行ステージ
FROM alpine:latest

WORKDIR /root/

# ビルドステージからバイナリをコピー
COPY --from=builder /app/main .

# 8080ポートを公開
EXPOSE 8080

# アプリケーションを実行
CMD ["./main"]
