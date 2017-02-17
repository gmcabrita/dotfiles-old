.PHONY: update test

# pulls the latest changes and updates the dotfiles
update:
	./update-dotfiles.sh

# tests all scripts using shellcheck
test:
	./test.sh
