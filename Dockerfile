FROM node:20-alpine AS frontend

ARG GITHUB_TOKEN
WORKDIR /app
RUN apk add --no-cache git && \
    git clone https://x-access-token:${GITHUB_TOKEN}@github.com/zrp9/puppy-demo.git .
RUN yarn install --frozen-lockfile && yarn build

FROM golang:1.23.0-alpine AS build

WORKDIR /app
COPY cmd/main.go .
COPY --from=frontend /app/dist ./dist
RUN GOOS=linux GOARCH=amd64 go build -o server main.go

FROM alpine:latest

WORKDIR /app
COPY --from=build /app/server .
COPY --from=build /app/dist ./dist
RUN chmod +x /app/server
EXPOSE 3000
CMD ["./server"]
