SHELL := time /usr/bin/env bash
.SHELLFLAGS := -euo pipefail -c


# install
apps := $(patsubst playbooks/%.yml,%,$(wildcard playbooks/*.yml))
install_targets := install $(addprefix install-,$(apps))

.PHONY: $(install_targets)
$(install_targets): install-%: | cache
	sudo -v
	ansible-playbook -$(or $(v),v) playbook.yml $(if $(filter-out install,$*),-e app=playbooks/$*.yml)

cache:
	mkdir -pv $@

# clean
.PHONY: clean
clean:
	-rm -vrf cache/*
