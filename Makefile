#
# Makefile for kakoune-extra-filetypes
# by lenormf
#

PREFIX ?= /usr/local
DESTDIR ?= # root dir

sharedir := $(DESTDIR)$(PREFIX)/share/kakoune-extra-filetypes

all: install

install:
	install -d $(sharedir)/rc
	cp -r rc/* $(sharedir)/rc/
	find $(sharedir)/rc -type f -exec chmod 0644 '{}' +

uninstall:
	rm -rf $(sharedir)

.PHONY: all install uninstall
