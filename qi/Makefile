
project		= qi
version		= 1.0-pre1

prefix		= /usr/local
exec_prefix	= $(prefix)
bindir		= $(exec_prefix)/bin
libexecdir	= $(exec_prefix)/libexec
sysconfdir	= $(prefix)/etc
datarootdir	= $(prefix)/share
infodir		= $(datarootdir)/info
mandir		= $(datarootdir)/man

DISTNAME	= ${project}-${version}

INSTALL         = install
INSTALL_PROGRAM = ${INSTALL} -p -m 755
INSTALL_DATA    = ${INSTALL} -p -m 644
INSTALL_DIR     = ${INSTALL} -d -m 755

functions_in	= src/functions/helpers.in src/functions/readconfig.in \
                  src/functions/showvar.in

scripts_in	= src/qi-build.in src/qi-erupt.in src/qi-install.in \
                  src/qi-order.in src/qi-remove.in

SOURCES		= ${functions_in} ${scripts_in}
OBJECTS		= $(SOURCES:.in=)

.SUFFIXES:
.SUFFIXES: .in

.PHONY: all \
	doc info man \
	dist distclean clean \
	install install-info install-man \
	uninstall uninstall-info uninstall-man


all : $(project)

$(project) : src/$(project)

src/$(project) : $(SOURCES) $(OBJECTS)

% : %.in
	sed -e "s|@VERSION@|$(version)|g" \
	    -e "s|@LIBEXECDIR@|$(libexecdir)|g" \
	    -e "s|@SYSCONFDIR@|$(sysconfdir)|g" \
	 $< > $@ && \
	 chmod 755 $@

${functions_in:.in=} : % : %.in
	sed -e "s|@SYSCONFDIR@|$(sysconfdir)|g" $< > $@ && \
	chmod 644 $@

doc : info man

info : doc/$(project).info

doc/$(project).info : doc/$(project).texi
	cd doc && LC_ALL=C makeinfo $(project).texi

man : doc/$(project).1

doc/$(project).1 : src/$(project)
	LC_ALL=C help2man -n 'The Qi package manager' -o $@ src/$(project)

dist : doc
	ln -sf . $(DISTNAME)
	tar -cvf $(DISTNAME).tar \
	  $(DISTNAME)/AUTHORS \
	  $(DISTNAME)/COPYING \
	  $(DISTNAME)/NEWS \
	  $(DISTNAME)/README \
	  $(DISTNAME)/Makefile \
	  $(DISTNAME)/doc/example.order \
	  $(DISTNAME)/doc/$(project).1 \
	  $(DISTNAME)/doc/$(project).info \
	  $(DISTNAME)/doc/$(project).texi \
	  $(DISTNAME)/etc/$(project)rc \
	  $(DISTNAME)/src/functions/*.in \
	  $(DISTNAME)/src/*.in
	rm -f $(DISTNAME)
	lzip -v -9 $(DISTNAME).tar

distclean : clean
	-rm -f *.tar *.tar.lz

clean :
	-rm -f $(OBJECTS) src/$(project)

install : all install-info install-man

	if [ ! -d "$(DESTDIR)${bindir}" ] ; then \
	  $(INSTALL_DIR) "$(DESTDIR)${bindir}" ; \
	fi
	if [ ! -d "$(DESTDIR)${libexecdir}/$(project)/functions" ] ; then \
	  $(INSTALL_DIR) "$(DESTDIR)${libexecdir}/$(project)/functions" ; \
	fi
	if [ ! -d "$(DESTDIR)${sysconfdir}" ] ; then \
	  $(INSTALL_DIR) "$(DESTDIR)${sysconfdir}" ; \
	fi

	@echo "*** Installing on $(DESTDIR)${bindir} ..."

	$(INSTALL_PROGRAM) src/$(project) "$(DESTDIR)${bindir}/$(project)"

	@echo "*** Installing on $(DESTDIR)${libexecdir} ..."

	for script in ${scripts_in} ; do \
	  $(INSTALL_PROGRAM) src/$$(basename $$script .in) "$(DESTDIR)${libexecdir}/$(project)/" ; \
	done

	for function in ${functions_in} ; do \
	  $(INSTALL_PROGRAM) src/functions/$$(basename $$function .in) "$(DESTDIR)${libexecdir}/$(project)/functions/" ; \
	done

	@echo "*** Installing on $(DESTDIR)${sysconfdir} ..."

	$(INSTALL_DATA) etc/$(project)rc "$(DESTDIR)${sysconfdir}/$(project)rc"

install-info :

	if [ ! -d "$(DESTDIR)${infodir}" ] ; then \
	  $(INSTALL_DIR) "$(DESTDIR)${infodir}" ; \
	fi

	$(INSTALL_DATA) doc/$(project).info "$(DESTDIR)${infodir}/$(project).info"

	-install-info --info-dir="$(DESTDIR)${infodir}" "$(DESTDIR)${infodir}/$(project).info"

install-man :

	if [ ! -d "$(DESTDIR)${mandir}/man1" ] ; then \
	  $(INSTALL_DIR) "$(DESTDIR)${mandir}/man1" ; \
	fi                  

	$(INSTALL_DATA) doc/$(project).1 "$(DESTDIR)${mandir}/man1/$(project).1"

uninstall : uninstall-info uninstall-man

	for function in ${functions_in} ; do \
	  rm -f "$(DESTDIR)${libexecdir}/$(project)/functions/$$(basename $$function .in)" ; \
	done

	for script in ${scripts_in} ; do \
	  rm -f "$(DESTDIR)${libexecdir}/$(project)/$$(basename $$script .in)" ; \
	done

	-rm -f "$(DESTDIR)${sysconfdir}/$(project)rc" "$(DESTDIR)${bindir}/$(project)"

	-rmdir "$(DESTDIR)${libexecdir}/$(project)/functions" "$(DESTDIR)${libexecdir}/$(project)"

uninstall-info :
	-install-info --info-dir="$(DESTDIR)${infodir}" --remove "$(DESTDIR)${infodir}/$(project).info"
	-rm -f "$(DESTDIR)${infodir}/$(project).info"

uninstall-man :
	-rm -f "$(DESTDIR)${mandir}/man1/$(project).1"

