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
	@echo "	make showreviewed	- para mostrar os arquivos revisados (e por quem)"
	@echo "	make showunreviewed	- para mostrar os arquivos ainda não revisados"
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

.PHONY: help fast bomba clean veryclean showexcluded showreviewed showunreviewed

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
	grep -RhoE '\\bombaimport\{[^}]*\}' content/ | sed -E 's/^\\bombaimport\{//; s/\}$$//' > build/headers_included
	find ./content -name "*.h" -o -name "*.py" -o -name "*.java" | grep -vFf build/headers_included

showreviewed:
	@included=$$(grep -RhoE '\\bombaimport\{[^}]*\}' content/ | sed -E 's/^\\bombaimport\{//; s/\}$$//'); \
	for f in $$(find ./content -name "*.h" -o -name "*.py" -o -name "*.java"); do \
		line=$$(grep -E '^[[:space:]]*\*[[:space:]]*Reviewed:' "$$f" | head -1); \
		if [ -n "$$line" ]; then \
			names=$$(echo "$$line" | sed -E 's/^[[:space:]]*\*[[:space:]]*Reviewed:[[:space:]]*//'); \
			if echo "$$included" | grep -qFx "$$(basename $$f)"; then status=incluído; else status=excluído; fi; \
			echo "$$f [$$status]: $$names"; \
		fi; \
	done

showunreviewed:
	@included=$$(grep -RhoE '\\bombaimport\{[^}]*\}' content/ | sed -E 's/^\\bombaimport\{//; s/\}$$//'); \
	for f in $$(find ./content -name "*.h" -o -name "*.py" -o -name "*.java"); do \
		if ! grep -qE '^[[:space:]]*\*[[:space:]]*Reviewed:' "$$f"; then \
			if echo "$$included" | grep -qFx "$$(basename $$f)"; then status=incluído; else status=excluído; fi; \
			echo "$$f [$$status]"; \
		fi; \
	done
