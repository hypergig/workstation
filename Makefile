SHELL := /usr/bin/env bash
.SHELLFLAGS := -euo pipefail -c


.PHONY: all
all:
	@echo 'installing workstation...'

.PHONY: test
test: target/id
	docker run -u jordan:jordan -t $(file < $<) curl https://raw.githubusercontent.com/hypergig/workstation/master/bootstrap.sh

target/id: Dockerfile
	-mkdir -v target
	docker build --iidfile $@ .

.PHONY: clean
clean:
	-rm -rfv target
