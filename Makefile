# This makefile has been created to help developers perform common actions.
# Most actions assume it is operating in a virtual environment where the
# python command links to the appropriate virtual environment Python.

MAKEFLAGS += --no-print-directory

# Do not remove this block. It is used by the 'help' rule when
# constructing the help output.
# help:
# help: Dungeon Nexus Makefile help
# help:

# help: help                           - display makefile help information
.PHONY: help
help:
	@grep "^#\shelp:" Makefile | \
		grep -v grep | \
		sed 's/\# help\: //' | \
		sed 's/\# help\://'


# help: venv                           - create a dev virtual environment
PIP_CMDS = \
       source venv/bin/activate && \
       pip install pip --upgrade && \
       pip install -r requirements.dev.txt && \
       pip install -e .
.PHONY: venv
venv:
	@rm -Rf venv
	@python3 -m venv venv --prompt dungeon_nexus
	/bin/bash -c "${PIP_CMDS}"
	@echo -e "Enter virtual environment using:" \
		"\n\n\t$ source venv/bin/activate\n"



# help: clean                          - clean all files using .gitignore rules
.PHONY: clean
clean:
	@git clean -X -f -d


# help: scrub                          - clean all files, even untracked files
.PHONY: scrub
scrub:
	git clean -x -f -d


# help: test                           - run tests
.PHONY: test
test:
	@python -m unittest discover -s tests


# help: test-verbose                   - run tests [verbosely]
.PHONY: test-verbose
test-verbose:
	@python -m unittest discover -s tests -v


# help: coverage                       - perform test coverage checks
.PHONY: coverage
coverage:
	@coverage erase
	coverage run -m unittest discover -s tests -v
	@coverage html
	@coverage report


# help: format                         - perform code style format
.PHONY: format
format:
	@black dungeon_nexus tests examples


# help: check-format                   - check code format compliance
.PHONY: check-format
check-format:
	@black --check dungeon_nexus tests examples


# help: sort-imports                   - apply import sort ordering
.PHONY: sort-imports
sort-imports:
	@isort . --profile black


# help: check-sort-imports             - check imports are sorted
.PHONY: check-sort-imports
check-sort-imports:
	@isort . --check-only --profile black


# help: style                          - perform code style format
.PHONY: style
style: sort-imports format


# help: check-style                    - check code style compliance
.PHONY: check-style
check-style: check-sort-imports check-format


# help: check-types                    - check type hint annotations
.PHONY: check-types
check-types:
	mypy -p dungeon_nexus --ignore-missing-imports


# help: check-lint                     - run static analysis checks
.PHONY: check-lint
check-lint:
	@pylint --rcfile=.pylintrc \
		dungeon_nexus \
		examples \
		tests \
		setup.py


# help: check-static-analysis          - check code style compliance
.PHONY: check-static-analysis
check-static-analysis: check-lint check-types


# help: docs                           - generate project documentation
.PHONY: docs
docs: coverage
	@cd docs && \
	rm -rf \
		source/api/dungeon_nexus*.rst \
		source/api/modules.rst \
		build/*
	@cd docs && make html


# help: check-docs                     - quick check docs consistency
.PHONY: check-docs
check-docs:
	@cd docs; make dummy


# help: serve-docs                     - serve project html documentation
.PHONY: serve-docs
serve-docs:
	@cd docs/build; python -m http.server --bind 127.0.0.1


# help: dist                           - create a wheel distribution package
.PHONY: dist
dist:
	@python setup.py bdist_wheel


# help: dist-test                      - test a whell distribution package
.PHONY: dist-test
dist-test: dist
	@cd dist && \
	../tests/test-dist.bash \
		./dungeon_nexus-*-py3-none-any.whl


# help: dist-upload                    - upload a wheel distribution package
.PHONY: dist-upload
dist-upload:
	@twine upload dist/dungeon_nexus-*-py3-none-any.whl


# Keep these lines at the end of the file to retain nice help
# output formatting.
# help:
