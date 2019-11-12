SHELL := time /usr/bin/env bash
.SHELLFLAGS := -euo pipefail -c


# install
.PHONY: install
install: | cache
	sudo -v
	ansible-playbook -v playbook.yml $(if $(app),-e app=playbooks/$(app).yml)

cache:
	mkdir -pv $@

# clean
.PHONY: clean
clean:
	-rm -vrf cache/*
