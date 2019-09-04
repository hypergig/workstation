SHELL := time /usr/bin/env bash
.SHELLFLAGS := -euo pipefail -c


# install
.PHONY: install
install:
	sudo ./install.sh $(apps)


# test in docker as if this was a fresh build (sorta)
.PHONY: test
test: test/docker.id
	docker run --rm -it \
		-u jordan:jordan \
		-v ~/.ssh:/home/jordan/.ssh:ro \
		-v $(PWD):/test:ro \
		-v $(PWD)/test/apt-cache/:/var/cache/apt/archives/ \
		$(shell cat $<) bash $(if $(in),#) -c '/test/bootstrap.sh /test/ || exec bash'


# test environment
test/docker.id: %/docker.id: %/Dockerfile
	docker build $(if $(pull),--pull) --iidfile $@ $*


# clean
.PHONY: clean
clean:
	-rm -v test/docker.id

.PHONY: clean-cache
clean-cache:
	-sudo rm -vrf test/apt-cache
