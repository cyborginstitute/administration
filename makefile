#
# Publication system
#

include makefile.docs

publish: $(BUILDDIR)/publish
	$(MAKE) -j2 $(BUILDDIR)/publish/kleinman.systems-administraton-for-cyborgs.pdf $(BUILDDIR)/publish/kleinman.systems-administraton-for-cyborgs.epub

$(BUILDDIR)/dirhtml:dirhtml
$(BUILDDIR)/latex/kleinman.systems-administraton-for-cyborgs.tex:latex
$(BUILDDIR)/epub/SystemsAdministrationforCyborgs.epub:epub
$(BUILDDIR)/latex/kleinman.systems-administraton-for-cyborgs.pdf:$(BUILDDIR)/latex/kleinman.systems-administraton-for-cyborgs.tex
$(BUILDDIR)/publish/kleinman.systems-administraton-for-cyborgs.epub:$(BUILDDIR)/epub/SystemsAdministrationforCyborgs.epub
	cp $< $@
$(BUILDDIR)/publish:$(BUILDDIR)/dirhtml
	mkdir -p $@
	cp -R $</* $@
	touch $@
$(BUILDDIR)/publish/kleinman.systems-administraton-for-cyborgs.pdf:$(BUILDDIR)/latex/kleinman.systems-administraton-for-cyborgs.pdf
	cp $< $@
