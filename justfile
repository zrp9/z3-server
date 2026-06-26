default:
  @just --list

[group('docker')]
@build-tag:
	source .env && docker build --build-arg GITHUB_TOKEN=$GITHUB_TOKEN --platform=linux/amd64 -t zdev19/z3-server:latest .

[group('docker')]
@build-push:
	source .env && docker build --build-arg GITHUB_TOKEN=$GITHUB_TOKEN --platform=linux/amd64 -t zdev19/z3-server:latest . && docker push zdev19/z3-server:latest


[group('docker')]
@build:
	docker compose -f docker-compose.yaml up --build -d

