# Makefile for thucoursework

# Compiling method: xelatex/pdflatex

INSTALL_PACKAGE = install-tl-unx.tar.gz
INSTALL_DIR = ./install-texlive
REMOTE_INSTALLER_URL = http://mirror.ctan.org/systems/texlive/tlnet

.PHONY: all pre_install_dep install_dep after_install_dep clean

all: after_install_dep iihw.pdf ithw.pdf

pre_install_dep: $(INSTALL_PACKAGE)

after_install_dep: install_dep
	# a little bit tricky, since I set texlive bin path in system level in my previous full installation
	export PLATFORM = $($(INSTALL_DIR)/install-tl --print-platform)
	export PATH=./texlive/bin/$(PLATFORM):$(PATH)
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

iihw.pdf: iihw.tex after_install_dep
	pdflatex iihw.tex

ithw.pdf: ithw.tex after_install_dep
	xelatex ithw.tex
