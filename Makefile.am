SUBDIRS = libfaad common frontend plugins

EXTRA_DIST = faad2.spec docs/libfaad.3 project utils

pkgconfigdir = $(libdir)/pkgconfig
pkgconfig_DATA = faad2.pc

rpm:	Makefile
	make dist
	$(RPMBUILD) -ta $(PACKAGE)-$(VERSION).tar.gz
	rm $(PACKAGE)-$(VERSION).tar.gz
