# this is the makefile to build documents, use:
# - $ make SRC="main" build
SRC = main
#%if $(SRC) == ''
#	SRC = main
#%endif

html: $(SRC).tex
	[ -d html ] || mkdir -p html
	@for f in *.tex ; do \
		#sed -e "s/á/\\\\\'{a}/g" -e "s/é/\\\\\'{e}/g" -e "s/í/\\\\\'{i}/g" -e "s/ó/\\\\\'{o}/g" -e "s/ú/\\\\\'{u}/g" \
		-e "s/à/\\\\\`{a}/g" -e "s/è/\\\\\`{e}/g" -e "s/ì/\\\\\`{i}/g" -e "s/ò/\\\\\`{o}/g" -e "s/ù/\\\\\`{u}/g" \
		-e "s/â/\\\\\^{a}/g" -e "s/ê/\\\\\^{e}/g" -e -e "s/ê/\\\\\^{e}/g" 
		sed -e 's/ã/\\~{a}/g' -e 's/õ/\\~{o}/g' -e 's/ç/\\c{c}/g' \
		$$f > html/$$f; \
	done
	cd html; latex2html -html_version 4.0 $(SRC)

build: $(SRC).tex
	pdflatex $(SRC)
	bibtex $(SRC) # makeindex $(SRC)
	pdflatex $(SRC)
	pdflatex $(SRC)
	rm -f *.log *.aux *.blg *.toc *.brf *.ilg *.ind missfont.log *.out *.lof *.lot
clean:
	rm -f $(SRC)*.ps $(SRC)*.dvi *.log *.aux *.blg *.toc *.brf *.ilg *.ind \
	      missfont.log $(SRC)*.bbl $(SRC)*.pdf *.out *.lof *.lot

