.PHONY: check dry-run apply lint

check:
	ansible-playbook playbooks/hardening.yml --syntax-check

dry-run:
	ansible-playbook playbooks/hardening.yml --check --diff

apply:
	ansible-playbook playbooks/hardening.yml

lint:
	ansible-lint playbooks/hardening.yml

