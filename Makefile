SHELL := time /usr/bin/env bash
.SHELLFLAGS := -euo pipefail -c


# install
.PHONY: install
install:
	sudo -v
	ansible-playbook playbook.yml $(if $(app),-e app=playbooks/$(app).yml)

# clean
.PHONY: clean
clean:
	-rm -vrf cache

.PHONY: clean-cache
clean-cache:
	-sudo rm -vrf test/apt-cache
