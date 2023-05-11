ANSIBLE_PLAYBOOK = ansible-playbook
INVENTORY_FILE = ./inventory
PLAYBOOK_FILE = ./main.yml

.PHONY: playbook lint

playbook:
	$(ANSIBLE_PLAYBOOK) $(PLAYBOOK_FILE) -i $(INVENTORY_FILE)

lint:
	ansible-lint $(PLAYBOOK_FILE)
