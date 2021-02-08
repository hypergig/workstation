SHELL := time /usr/bin/env bash
.SHELLFLAGS := -euo pipefail -c

ansible := ansible-playbook -$(or $(v),v) playbook.yml

ifeq ($(shell uname -p),arm64)
	ifeq ($(_IS_ALACRITTY),true)
$(error Alacritty is not m1 native yet and may have some strange side effects with brew right now, best to switch to the native terminal for this)
	endif
endif

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


.PHONY: update-defaults
update-defaults:
	cd config/defaults; ls | xargs -I{} sh -c 'defaults export {} - > {}'
