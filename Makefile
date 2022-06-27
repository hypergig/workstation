SHELL := time /usr/bin/env bash
.SHELLFLAGS := -euo pipefail -c


.PHONY: install
install:
	./install


.PHONY: update-defaults
update-defaults:
	cd config/defaults; ls | xargs -I{} sh -c 'defaults export "{}" - > "{}"'


.PHONY: update-brewfile
update-brewfile:
	rm Brewfile
	brew bundle dump
