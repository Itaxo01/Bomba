LATEXCMD = pdflatex -shell-escape -output-directory build/
export TEXINPUTS=.:content/tex/:
export max_print_line = 1048576

help:
	@echo "Esse makefile constrói a Bomba"
	@echo ""
	@echo "Os comandos são:"
	@echo "	make fast		- para construir a Bomba rápido (roda o LaTeX uma vez só)"
	@echo "	make bomba		- para construir a Bomba"
	@echo "	make clean		- para limpar o build"
	@echo "	make veryclean		- para limpar e remover o bomba.pdf"
	@echo "	make test		- para rodar todos os stress tests em stress-tests/"
	@echo "	make test-compiles	- para testar a compilação de todos os headers"
	@echo "	make help		- para mostrar esta informação"
	@echo "	make showexcluded	- para mostrar os arquivos que não estão incluídos no doc"
	@echo ""
	@echo "Para mais informações veja o arquivo 'doc/README'"

fast: | build
	$(LATEXCMD) content/bomba.tex </dev/null
	cp build/bomba.pdf bomba.pdf

bomba: test-session.pdf | build
	$(LATEXCMD) content/bomba.tex && $(LATEXCMD) content/bomba.tex
	cp build/bomba.pdf bomba.pdf

clean:
	cd build && rm -f bomba.aux bomba.log bomba.tmp bomba.toc bomba.pdf bomba.ptc

veryclean: clean
	rm -f bomba.pdf test-session.pdf

.PHONY: help fast bomba clean veryclean

build:
	mkdir -p build/

test:
	./doc/scripts/run-all.sh .

test-compiles:
	./doc/scripts/compile-all.sh .

test-session.pdf: content/test-session/test-session.tex content/test-session/chapter.tex | build
	$(LATEXCMD) content/test-session/test-session.tex
	cp build/test-session.pdf test-session.pdf

showexcluded: build
	grep -RoPh '^\s*\\bombaimport{\K.*' content/ | sed 's/.$$//' > build/headers_included
	find ./content -name "*.h" -o -name "*.py" -o -name "*.java" | grep -vFf build/headers_included
