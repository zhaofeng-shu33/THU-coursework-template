# Makefile for thucoursework

# Compiling method: xelatex/pdflatex
PACKAGE = thucoursework
INSTALL_PACKAGE = install-tl-unx.tar.gz
INSTALL_DIR = ./install-texlive
# automatic configuration of mirror
REMOTE_INSTALLER_URL = http://mirror.ctan.org/systems/texlive/tlnet
# Set opts for latexmk if you use it
LATEXMKOPTS = -xelatex -halt-on-error -interaction=nonstopmode


.PHONY: doc all archive pre_install_dep install_dep after_install_dep clean test

all: after_install_dep iihw.pdf ithw.pdf

pre_install_dep: $(INSTALL_PACKAGE)

after_install_dep: install_dep
	# tricky, to make variable assignment in recipe, and to execute shell command and assign the print result to a variable.
	$(eval PLATFORM1=`$(INSTALL_DIR)/install-tl --print-platform`)
	$(eval PLATFORM2=$(shell echo $(PLATFORM1)))
	$(eval PLATFORM3=$(shell pwd))
	$(eval export PATH :=$(PLATFORM3)/texlive/bin/$(PLATFORM2):$(PATH))
	echo $$PATH	
	# to make tlmgr work, we need perl
	tlmgr install xkeyval matlab-prettifier caption doublestroke xcolor listings l3kernel l3packages ms ulem fontspec environ trimspaces booktabs moreenum mathtools oberdiek enumitem fmtcount etoolbox latex-bin
install_dep: pre_install_dep
	mkdir -p $(INSTALL_DIR)
	tar -zxvf $(INSTALL_PACKAGE) -C $(INSTALL_DIR) --strip-components 1 
	$(INSTALL_DIR)/install-tl -profile tl.profile

$(INSTALL_PACKAGE): 
	wget $(REMOTE_INSTALLER_URL)/$(INSTALL_PACKAGE)

clean: 
	rm -fr $(INSTALL_DIR)
	rm -f *.idx *.ilg *.glo *.gls *.hd *.ind *.log *.out *.synctex.gz *.toc *.aux

iihw.pdf: iihw.tex after_install_dep
	pdflatex iihw.tex

ithw.pdf: ithw.tex after_install_dep
	xelatex ithw.tex

archive:
	# make tar.gz which is submitted to ctan.org
	# first copy the necessary files to the dist dir
	cp README.md iihw.pdf ithw.pdf iihw.tex ithw.tex matlabscript.m pdf_normal.eps thucoursework.dtx thucoursework.pdf Makefile thucoursework/ 
	# then tar it
	COPYFILE_DISABLE=1 tar -zcvf thucoursework.tar.gz thucoursework/
doc : $(PACKAGE).pdf

$(PACKAGE).pdf : $(PACKAGE).dtx
	#latexmk $(LATEXXMKOPTS) $(PACKAGE).dtx
	xelatex $(PACKAGE).dtx
	makeindex -s gind.ist -o $(PACKAGE).ind $(PACKAGE).idx
	makeindex -s gglo.ist -o $(PACKAGE).gls $(PACKAGE).glo
	xelatex $(PACKAGE).dtx
	xelatex -synctex=1 $(PACKAGE).dtx

test:
	# first clear out root texlive bin dir
	$(eval export PATH := /bin:/usr/bin)
	echo $$PATH
	$(eval PLATFORM1=`$(INSTALL_DIR)/install-tl --print-platform`)
	$(eval PLATFORM2=$(shell echo $(PLATFORM1)))
	$(eval PLATFORM3=$(shell pwd))
	$(eval export PATH := $(PLATFORM3)/texlive/bin/$(PLATFORM2):$(PATH))
	echo $$PATH
	tlmgr --version
