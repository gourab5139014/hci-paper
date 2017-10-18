TEX_FILES=paper.tex paperGourab.bib paperGokhan.bib $(wildcard sections/*)

all: paper.pdf todo
	@if [ `uname` = "Darwin" ] ; then open paper.pdf; fi

graphs:
	@cd graphs; rake

paper.pdf: $(TEX_FILES)
	latexmk -pdf paper.tex 

open: paper.pdf todo
	open $<
	
clean:
	latexmk -CA -bibtex

todo:
	@echo "==========================="
	@echo "     Remaining Todos "
	@echo "==========================="
	@find sections -name '*.tex' | \
		xargs grep 'todo' | \
		sed 's:^sections/::; s:\.tex::' | \
		sed 's/\([^:]*\):.*\\todo{/TODO (\1): /; s/}.*//;'


.PHONY: todo plot clean open collabs graphs