JOB   := Topology_Assignment_Solutions_B23
BUILD := build

.PHONY: all clean watch

all:
	latexmk -pdf -interaction=nonstopmode -halt-on-error \
	        -outdir=$(BUILD) -jobname=$(JOB) main.tex
	cp $(BUILD)/$(JOB).pdf .

watch:
	latexmk -pdf -pvc -interaction=nonstopmode \
	        -outdir=$(BUILD) -jobname=$(JOB) main.tex

clean:
	rm -rf $(BUILD) $(JOB).pdf
