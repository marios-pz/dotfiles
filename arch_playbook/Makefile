ANSIBLE_PLAYBOOK = ansible-playbook
INVENTORY_FILE = ./inventory
PLAYBOOK_FILE = ./main_playbook.yaml

.PHONY: playbook lint

playbook:
	$(ANSIBLE_PLAYBOOK) $(PLAYBOOK_FILE) -i $(INVENTORY_FILE) --ask-become-pass

lint:
	ansible-lint $(PLAYBOOK_FILE)
