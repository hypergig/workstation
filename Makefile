SHELL := time /usr/bin/env bash
.SHELLFLAGS := -euo pipefail -c

ansible := ansible-playbook -M modules -$(or $(v),v) playbook.yml


.PHONY: install
install: sudo | cache
	$(ansible)


apps := $(patsubst playbooks/%.yml,%,$(wildcard playbooks/*.yml))
app_targets := $(addprefix install-,$(apps))
.PHONY: $(app_targets)
$(app_targets): install-%: sudo | cache
	$(ansible) -e app=playbooks/$*.yml


.PHONY: cache
cache:
	mkdir -pv $@


.PHONY: sudo
sudo:
	sudo -v


.PHONY: clean
clean:
	-rm -vrf cache
