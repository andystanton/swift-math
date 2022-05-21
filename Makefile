.PHONY: clean test

all: test

clean:
	@echo "Cleaning project"
	@rm -rf .build

test:
	@swift test

