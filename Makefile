PROJECT_DIR:=$(shell git rev-parse --show-toplevel)
COMMIT_SHA:=$(shell git rev-parse --short HEAD)
HTML_DIR:=$(PROJECT_DIR)/docs/_build/html
DATE:=$(shell date)
REMOTE:=$(shell git remote get-url gh)

default: help

.PHONY: help
help:
	$(info Project dir       - ${PROJECT_DIR})
	$(info Commit sha        - ${COMMIT_SHA})
	$(info date              - ${DATE})
	$(info make docs         - create html)
	$(info make publish      - publish html to github)

.PHONY: docs
docs:
	poetry run make -C docs html

.PHONY: publish
publish:
	rm -rf "${HTML_DIR}/.git"
	git -C "${HTML_DIR}" init
	touch "${HTML_DIR}"/.nojekyll
	git -C "${HTML_DIR}" add .
	git -C "${HTML_DIR}" commit -m "Docs generate from ${COMMIT_SHA}) at ${DATE}"
	git -C "${HTML_DIR}" remote add github ${REMOTE}
	git -C "${HTML_DIR}" push -u -f github master:gh-pages
