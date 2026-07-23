# =========================================================================
# TANGENTIAL BLOCK FIELD: STANDALONE LOCAL VALIDATION HARNESS
# =========================================================================

SHELL := /bin/bash
.SHELLFLAGS := -euo pipefail -c

.PHONY: all verify clean

all: verify

verify:
	@echo "--- RUNNING STANDALONE VISIBILITY LAYER AUDIT ---"
	ghc -fno-code .omi/FieldPositions.hs
	runghc -i.omi .omi/FieldPositionsCheck.hs
	cc -std=c99 -Wall -Wextra -pedantic -fsyntax-only .omi/tangential_blackboard_check.c
	@file_count_omi=$$(find .omi -maxdepth 1 -type f | wc -l); \
	if [ "$$file_count_omi" -ne 25 ]; then \
		echo "ERROR: Substrate core has $$file_count_omi files, expected exactly 25."; \
		exit 1; \
	fi
	@file_count_docs=$$(find docs -maxdepth 1 -type f | wc -l); \
	if [ "$$file_count_docs" -ne 3 ]; then \
		echo "ERROR: Human overlay has $$file_count_docs files, expected exactly 3."; \
		exit 1; \
	fi
	@if [ -n "$$(find .omi -mindepth 2 -print -quit)" ]; then \
		echo "ERROR: Forbidden nested directory paths detected under .omi/"; \
		exit 1; \
	fi
	@if [ -n "$$(find docs -mindepth 2 -print -quit)" ]; then \
		echo "ERROR: Forbidden nested directory paths detected under docs/"; \
		exit 1; \
	fi
	@echo "--- STANDALONE VERIFICATION PASSED: ENVIRONMENT IMMUTABLE ---"

clean:
	@echo "Workspace is clean; no runtime compilation remnants generated."
