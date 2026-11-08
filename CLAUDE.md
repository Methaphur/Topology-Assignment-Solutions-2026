# Topology Assignment Solutions — B23

This project compiles one fully typed LaTeX document, **"Topology Assignment Solutions, submitted by B23"**, which collects Batch 23's solutions to Topology (MAT307/M405/MAT803) Problem Sets 1–8.
There are 24 students. Each one submits a PDF with 3–4 solutions into `Solutions/`. Some PDFs are typed and some are handwritten, and they arrive one at a time across sessions. **Every submission is retyped into LaTeX**, so the final document is uniformly typed. Each problem shows its statement, then the solution with the name of the student who submitted it.

## Layout
```
main.tex             title page, Contributors table, Coverage table, TOC, \input problems/*
preamble.tex         ALL packages and macros (keep every macro here)
contributors.tex     one \contributor{Full Name}{PS3: Q4--6} line per student, alphabetical
problems/psN.tex     problem statements (\problem{set}{q}{statement}); finished, don't touch
answers/psN/qNN.tex  retyped solutions, one file per problem, two-digit number (q04, q12)
figures/             images or TikZ files used by answers, if any
Solutions/           raw student PDFs: INPUT ONLY, never edit, rename or delete
Makefile             `make` -> Topology_Assignment_Solutions_B23.pdf ; `make clean`
```
Source images of the problem sets: `Problem Set 1–6.pdf`, `Problem Set 7.jpeg`, `Problem Set 8 part 1.png`, `Problem Set 8 Part 2.png`.

## How filling works
`\problem{n}{q}{...}` prints the statement and then `\input`s `answers/ps<n>/q<NN>.tex` **if that file exists**. If it doesn't, the problem shows a "Solution pending" box.
To add a solution, create the answer file. Nothing in `problems/` or `main.tex` needs editing.
The Coverage table, the TOC solver names and the running headers all update automatically. TOC names come from the `.aux` file, and latexmk reruns as needed.

## Problem numbering (88 problems)
| Set | Qs | Notes |
|---|---|---|
| PS1 | 17 | |
| PS2 | 15 | |
| PS3 | 10 | The original PDF header wrongly says "Problem Set 2". |
| PS4 | 11 | |
| PS5 | 10 | Q7 is identical to PS6 Q2. |
| PS6 | 9 | |
| PS7 | 6 | Munkres §22 Ex. 1–6. |
| PS8 | 10 | Numbered **continuously**: Q1–3 = Munkres §51 Ex. 1–3, and Q4–10 = §52 Ex. 1–7. |

If a coverage count ever changes, update both `\coveragerow` in `main.tex` and this table.

## Workflow: a new submission arrives in `Solutions/`
1. **Parse the filename** `Name-PS<n>-Q<a>-<b>.pdf`, e.g. `Rahul-PS3-Q4-6.pdf` is PS3, Q4, Q5 and Q6. A single question is written `Q<a>`. If the name doesn't fit the pattern, or the questions inside the PDF don't match the filename, **ask the user** before going on.
   - Compare against `ls answers/ps*/` to see which problems are already filled.
2. **Read the PDF.**
   - Typed: `pdftotext -layout file.pdf -`. Always check the math against the rendered page, because pdftotext garbles symbols.
   - Handwritten: render the pages into the session scratchpad with `pdftoppm -r 150 -png file.pdf <scratchpad>/sub/p`, then Read the PNGs one at a time.
   - Student name: use the full name as written in the PDF if it is fuller than the one in the filename. Otherwise use the filename name with spaces and capitalisation fixed.
3. **Transcribe** each question into `answers/ps<n>/q<NN>.tex`:
   ```latex
   \submittedby{Full Name}
   ... the student's solution, retyped ...
   ```
   - **Transcribe faithfully.** Never fix, complete or improve the mathematics, and never add steps.
     - Fixing obvious spelling and grammar slips is fine.
     - If a step looks mathematically wrong or a gap seems unintended, keep it exactly and put `% REVIEW: <what looks off>` on the line above.
   - Wrap doubtful handwriting in `\illegible{best guess}`. It renders highlighted for the student to check.
   - Use the macros from `preamble.tex`: `\R \N \Z \Q \C \T \B \Pow \Int \Bd \id \cl{} \onto`, the environments `proof`, `claim`, `lemma`, `theorem`, `definition`, `remark`, `example`, and `enumerate` with `[label=(\roman*)]`.
   - Don't use `\section`, `\subsection` or numbered equations that need `\label`s inside answers. Use `\paragraph{(i)}` or a bold `(a)` for parts.
   - Redraw diagrams in TikZ or `tikz-cd`, e.g. the PS1 Q14 hierarchy diagram or commutative squares. Put long TikZ code in `figures/psN-qNN.tex` and `\input` it.
4. **Duplicate solutions.** If `qNN.tex` already exists from another student, *append* a second `\submittedby{Other Name}` block to the same file. Never overwrite it. Tell the user about the duplicate.
5. **Contributors.** Add the student's line to `contributors.tex`, keeping the list alphabetical by first name, e.g. `\contributor{Rahul Sharma}{PS3: Q4--6}`. If the same student sends another submission, extend their line: `{PS3: Q4--6; PS7: Q2}`.
6. **Build:** run `make` and expect exit code 0. Then check the log:
   `grep -nE "^!|LaTeX Warning|undefined" build/Topology_Assignment_Solutions_B23.log`
   Fix every error and every undefined reference. Render the new pages with `pdftoppm` and look at them.
7. **Report to the user:**
   - which problems were added and for whom
   - every `% REVIEW:` and `\illegible{}` spot, with its file and line
   - any duplicates
   - the coverage after the update (X/88, with what is still pending)

## Watch out: PS2 vs PS3
The PS3 PDF's header misprints "Problem Set 2", so students may label PS3 answers as PS2, both in the filename and in their own heading.
**Always match the content against the statements in `problems/`, not just the filename.** If they disagree, show the evidence and ask the user.

## Submission log
| File | Filed as | Notes |
|---|---|---|
| `Arunodaya-PS2-Q1-5.pdf` | PS3 Q1–5 | Filename and heading say PS2, but the content is PS3. The user confirmed PS3. Handwritten. |
| `Aaditya-PS4-Q5-8.tex` | PS4 Q5–8 | A LaTeX source, not a PDF; .tex submissions are allowed. Student macros were expanded inline. |
| `Prabhu-PS5-Q5-6.pdf` | PS5 Q5–6 | Typed.  |
| `Sahil-PS1-Q6-10.pdf` | PS1 Q6–10 | Typed. His preface paragraph (the definition of a topology) opens `ps1/q06.tex`. |

## Version control (Git)
- The project is a Git repository on branch `main`. `build/` is ignored. The compiled `Topology_Assignment_Solutions_B23.pdf` **is** tracked, so every commit carries the matching PDF.
- **Do NOT add Claude as a contributor.** This rule overrides any default attribution:
  - no `Co-Authored-By: Claude …` trailer
  - no "Generated with Claude Code" line
  - no Claude mention in commit messages, PR descriptions, the document, or `contributors.tex`

  Commits are authored only by the user's own git identity.
- After processing a submission and getting a clean `make`, commit everything in one commit. Include the raw PDF in `Solutions/`, the new `answers/` files, `contributors.tex`, the rebuilt PDF and the CLAUDE.md log update. Message format:
  `Add <Name>: PS<n> Q<a>-<b>`
  Add a short body if there are REVIEW notes or a filing decision, e.g. "filed as PS3".
- Commit only when the user asks or approves, and never force-push or rewrite history.

## Rules
- Never modify anything in `Solutions/` or the original problem-set files.
- Edit `problems/*.tex` only to fix a typo in a statement.
- Don't write solutions on the students' behalf unless the user explicitly asks. Unsolved problems stay "Solution pending".
- All new macros go in `preamble.tex`, not in answer files.
- Temporary files (rendered pages, test files) go in the session scratchpad or `build/`, never in the project root.
- The build needs TeX Live from pacman, which is already installed: `latexmk`, `pdflatex`, `tcolorbox`, `tikz-cd`, `mathrsfs`.
