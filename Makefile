$PHONY: clean test format

ROOT_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

all: test

clean:
	@echo "Cleaning project"
	@rm -rf .build

test:
	@swift test

format:
	@echo "Formatting project"
	@swift-format -ir $(ROOT_DIR)
