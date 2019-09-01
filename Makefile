SHELL := /usr/bin/env bash
.SHELLFLAGS := -euo pipefail -c


.PHONY: all
all: install


# application installers
installers := $(patsubst installers/%.sh,%,$(wildcard installers/*))

.PHONY: install
install: $(installers)

.PHONY: $(installers)
$(installers): packages
	sudo installers/$@.sh


# apt packages
.PHONY: packages
packages:
	sudo apt-get update
	sudo apt-get install -y $(shell cat packages.txt)


# test in docker as if this was a fresh build
.PHONY: test
test: target/id
	docker run -u jordan:jordan -iv ~/.ssh:/home/jordan/.ssh:ro -v $(PWD):/test:ro $(shell cat $<) bash -c '/test/bootstrap.sh -C /test'


# test environment
target/id: Dockerfile
	-mkdir -v target
	docker build --iidfile $@ .


# clean
.PHONY: clean
clean:
	-rm -rfv target
