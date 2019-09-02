SHELL := /usr/bin/env bash
.SHELLFLAGS := -euo pipefail -c


.PHONY: all
all: install


# apt packages
.PHONY: packages
packages:
	sudo apt-get update
	sudo apt-get install -y $(shell cat packages.txt)


# prereqs
prereqs := $(patsubst prereqs/%.sh,%,$(wildcard prereqs/*))
.PHONY: $(prereqs)
$(prereqs): clean_apps
	sudo prereqs/$@.sh


# app installs
.PHONY: install
install: $(packages) $(prereqs)
	sudo apt-get update
	sudo apt-get install -y $(shell cat target/apps.txt)


# test in docker as if this was a fresh build (sorta)
.PHONY: test
test: target/docker.id
	time docker run -it \
		-u jordan:jordan \
		-v ~/.ssh:/home/jordan/.ssh:ro \
		-v $(PWD):/test \
		-v $(PWD)/target/apt-cache/:/var/cache/apt/archives/ \
		$(shell cat $<) bash -c '/test/bootstrap.sh -C /test'


# test environment
target/docker.id: Dockerfile
	-mkdir -v target
	docker build --iidfile $@ .


# clean
.PHONY: clean_apps
clean_apps:
	-rm -vf target/apps.txt


.PHONY: clean
clean:
	-rm -rfv target

