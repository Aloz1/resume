.PHONY: build clean

LETTER_DIR = cover-letters/
RESUME_DIR = resumes/
AUX_DIR = build/
OUT_DIR = pdf/

TOUCH := touch
LATEXMK := latexmk
LATEXMK_OPTS := -cd- -g -lualatex -synctex=1 -outdir=$(AUX_DIR)

LETTER_TEX = $(wildcard $(LETTER_DIR)*.tex)
RESUME_TEX = $(wildcard $(RESUME_DIR)*.tex)

LETTER_AUX = $(addprefix $(AUX_DIR), $(notdir $(LETTER_TEX:.tex=-letter.pdf)))
RESUME_AUX = $(addprefix $(AUX_DIR), $(notdir $(RESUME_TEX:.tex=-resume.pdf)))

LETTER_OUT = $(addprefix $(OUT_DIR), $(notdir $(LETTER_AUX)))
RESUME_OUT = $(addprefix $(OUT_DIR), $(notdir $(RESUME_AUX)))

$(OUT_DIR)%-letter.pdf :: $(LETTER_DIR)%.tex
	$(LATEXMK) $(LATEXMK_OPTS) -jobname=$(notdir $(<:.tex=-letter)) $<
	cp -f $(addprefix $(AUX_DIR), $(notdir $@)) $@


$(OUT_DIR)%-resume.pdf :: $(RESUME_DIR)%.tex $(wildcard *.sty) $(wildcard tex/*.tex)
	$(LATEXMK) $(LATEXMK_OPTS) -jobname=$(notdir $(<:.tex=-resume)) $<
	cp -f $(addprefix $(AUX_DIR), $(notdir $@)) $@

build: $(LETTER_OUT) $(RESUME_OUT)

clean:
	rm -r build/*
	rm pdf/*
