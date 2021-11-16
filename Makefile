SHELL := time /usr/bin/env bash
.SHELLFLAGS := -euo pipefail -c

ansible := ansible-playbook --ask-become-pass -$(or $(v),v) playbook.yml


.PHONY: install
install: | cache
	$(ansible)


apps := $(patsubst playbooks/%.yml,%,$(wildcard playbooks/*.yml))
app_targets := $(addprefix install-,$(apps))
.PHONY: $(app_targets)
$(app_targets): install-%: | cache
	$(ansible) -e app=playbooks/$*.yml


.PHONY: cache
cache:
	mkdir -pv $@


.PHONY: clean
clean:
	-rm -vrf cache


.PHONY: update-defaults
update-defaults:
	cd config/defaults; ls | xargs -I{} sh -c 'defaults export "{}" - > "{}"'
