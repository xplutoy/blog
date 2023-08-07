# Makefile for myblog

.PHONY: all publish publish_no_init

all: publish

publish: publish.el
	@echo "Publishing..."
	emacs --batch -q --script publish.el

clean:
	@echo "Cleaning up.."
	@rm -rvf *.elc
	@rm -rvf ./public_html/
	@rm -rvf ~/.org-timestamps/*
