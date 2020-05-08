
.PHONY: all
all : flash_layout.svg

%.svg : %.pdf
	pdf2svg $< $@

%.pdf : %.tex
	pdflatex $<

.PHONY: clean
clean :
	rm -f *.svg *.pdf *.log *.aux
