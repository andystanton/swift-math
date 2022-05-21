$PHONY: clean test format

override ROOT_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
filter:=.*

all: test

clean:
	@echo "Cleaning project"
	@rm -rf .build

test:
	@swift test --filter "$(filter)"

format:
	@echo "Formatting project"
	@swift-format -ir $(ROOT_DIR)
