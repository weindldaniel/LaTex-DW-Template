LATEXMK = latexmk
FLAGS   = -pdf -interaction=nonstopmode -halt-on-error

.PHONY: all report presentation clean

all: report presentation

report:
	cd report && $(LATEXMK) $(FLAGS) main.tex

presentation:
	cd presentation && $(LATEXMK) $(FLAGS) main.tex

clean:
	cd report && $(LATEXMK) -C main.tex
	cd presentation && $(LATEXMK) -C main.tex
