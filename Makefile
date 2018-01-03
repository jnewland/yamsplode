# Set a current_dir variable so I can copy/paste this makefile around without
# changes. From https://stackoverflow.com/a/18137056
mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
current_dir := $(notdir $(patsubst %/,%,$(dir $(mkfile_path))))

.PHONY: all
all: build test

# Build a docker image.
.PHONY: build
build: Gemfile.lock
	docker build -t $(current_dir) .

pwd := $(dir $(mkfile_path))
Gemfile.lock: Gemfile
	docker run --rm -v $(pwd):/usr/src/app -w /usr/src/app ruby:2.5-slim-stretch bundle install

.PHONY: test
test:
	docker run --rm -v $(pwd)/test/in.yaml:/in.yaml -v $(pwd)/test/out/:/out/ yamsplode
	git diff test
