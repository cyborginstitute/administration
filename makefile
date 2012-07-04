# Makefile for Sphinx documentation
#

# You can set these variables from the command line.
SPHINXOPTS    = -c ./
SPHINXBUILD   = sphinx-build
PAPER	      =
BUILDDIR      = build

# Internal variables.
PAPEROPT_a4	= -D latex_paper_size=a4
PAPEROPT_letter = -D latex_paper_size=letter
ALLSPHINXOPTS	= -d $(BUILDDIR)/doctrees $(PAPEROPT_$(PAPER)) $(SPHINXOPTS) source

# 
# Publication system
#

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
$(BUILDDIR)/publish/kleinman.systems-administraton-for-cyborgs.pdf:$(BUILDDIR)/latex/kleinman.systems-administraton-for-cyborgs.pdf
	cp $< $@


#
# PDF Build System
#

pdfs:$(subst .tex,.pdf,$(wildcard $(BUILDDIR)/latex/*.tex))

PDFLATEXCOMMAND = TEXINPUTS=".:$(BUILDDIR)/latex/:" pdflatex --interaction batchmode --output-directory $(BUILDDIR)/latex/

%.pdf:%.tex
	@$(PDFLATEXCOMMAND) $(LATEXOPTS) '$<' >|$@.log
	@echo "[PDF]: (1/4) pdflatex $<"
	@-makeindex -s $(BUILDDIR)/latex/python.ist '$(basename $<).idx' >>$@.log 2>&1
	@echo "[PDF]: (2/4) Indexing: $(basename $<).idx"
	@$(PDFLATEXCOMMAND) $(LATEXOPTS) '$<' >>$@.log
	@echo "[PDF]: (3/4) pdflatex $<"
	@$(PDFLATEXCOMMAND) $(LATEXOPTS) '$<' >>$@.log
	@echo "[PDF]: (4/4) pdflatex $<"
	@echo "[PDF]: see '$@.log' for a full report of the pdf build process."

########################################################################

.PHONY: help clean html dirhtml singlehtml epub latex text man publish

help:
	@echo "Please use \`make <target>' where <target> is one of"
	@echo "	 html	    to make standalone HTML files"
	@echo "	 dirhtml    to make HTML files named index.html in directories"
	@echo "	 singlehtml to make a single large HTML file"
	@echo "	 epub	    to make an epub"
	@echo "	 latex	    to make LaTeX files, you can set PAPER=a4 or PAPER=letter"
	@echo "	 latexpdf   to make LaTeX files and run them through pdflatex"
	@echo "	 text	    to make text files"
	@echo "	 man	    to make manual pages"
	@echo "	 changes    to make an overview of all changed/added/deprecated items"

clean:
	-rm -rf $(BUILDDIR)/*

html:
	$(SPHINXBUILD) -b html $(ALLSPHINXOPTS) $(BUILDDIR)/html
	@echo "[HTML] build complete."

dirhtml:
	$(SPHINXBUILD) -b dirhtml $(ALLSPHINXOPTS) $(BUILDDIR)/dirhtml
	@echo "[DIR] build complete."

singlehtml:
	$(SPHINXBUILD) -b singlehtml $(ALLSPHINXOPTS) $(BUILDDIR)/singlehtml
	@echo "[SINGLE] build complete."

epub:
	$(SPHINXBUILD) -b epub $(ALLSPHINXOPTS) $(BUILDDIR)/epub
	@echo "[EPUB] build compete."

latex:
	$(SPHINXBUILD) -b latex $(ALLSPHINXOPTS) $(BUILDDIR)/latex
	@echo "[LATEX] build compete."

text:
	$(SPHINXBUILD) -b text $(ALLSPHINXOPTS) $(BUILDDIR)/text
	@echo "[TEXT] build complete."

man:
	$(SPHINXBUILD) -b man $(ALLSPHINXOPTS) $(BUILDDIR)/man
	@echo "[MAN] build complete."

linkcheck:
	$(SPHINXBUILD) -b linkcheck $(ALLSPHINXOPTS) $(BUILDDIR)/linkcheck
	@echo "[LINK] link check complete."
