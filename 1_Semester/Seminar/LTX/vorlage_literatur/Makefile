JOB = seminararbeit
PDFLATEX = pdflatex
PDFOPTS = -halt-on-error -file-line-error -interaction nonstopmode

$(JOB).pdf: build/$(JOB).pdf cleanupfirst
	@cp $< $@

cleanupfirst:
	@rm -f $(JOB).pdf

build/$(JOB).pdf: $(JOB).tex build/$(JOB).bbl
	$(PDFLATEX) $(PDFOPTS) -output-directory build $(JOB)
	@make --no-print-directory build/$(JOB).pdf

build/%.bbl: build/%.bcf-stamp
	biber --output-directory=build $(JOB) || rm build/$(JOB).bcf

.PRECIOUS: build/%.bcf-stamp
build/%.bcf-stamp: build/%.bcf
	@sha1sum $^ >$@2
	@if cmp -s $@2 $@; then rm $@2; else mv -f $@2 $@; fi

build/$(JOB).bcf:
	mkdir -p build
	$(ENV) $(PDFLATEX) $(PDFOPTS) -output-directory build $(JOB)

run:
	xdg-open $(JOB).pdf 2>/dev/null || \
		zathura $(JOB).pdf 2>/dev/null || \
		evince $(JOB).pdf 2>/dev/null &

clean:
	rm -f build/*.toc build/*.tod build/*.aux build/*.bbl build/*.blg \
		build/*.log build/*.out build/*.run.xml build/*.bcf build/*.bcf-stamp \
		build/*.lof build/*.nav build/*.snm build/*.vrb \
		build/*.lot build/*.tdo build/*.makefile build/*.figlist
	rm -f build/tikz/*.pdf build/tikz/*.log build/tikz/*.dpth build/tikz/*.md5
	rm -f build/uptodate
	rm -f build/*.pdf
	rm -f $(JOB).pdf
	-rmdir -p build

.PHONY: clean 

