
development:
	docker build -t ghcr.io/runcodes-icmc/database:latest-development -f ./docker/Dockerfile.development .

production:
	docker build -t ghcr.io/runcodes-icmc/database:latest -f ./docker/Dockerfile.production .

all: development production

.PHONY: all
