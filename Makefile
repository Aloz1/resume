.PHONY: build

LATEXMK="latexmk"
TO_BUILD="Alastair Knowles - Resume.tex"

build:
	$(LATEXMK) -lualatex -synctex=1 -outdir=build
