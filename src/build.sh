#!/bin/bash
set -euo pipefail

REQUIREMENTS=(pandoc texlive-latex-recommended texlive-latex-extra)

## Input
TLDR="./docs/tldr.md"
LATEX="./docs/report.tex"

## Output
PDF="./docs/report.pdf"
README_MD="./README.md"

## Temporary
HEADER_MD="./header.md"
REPORT_MD="./report.md"
REPORT_CLEAN_MD="./report-clean.md"

PDFLATEX_INPUT=$(basename "$LATEX")
PDFLATEX_OUTPUT_DIR=$(dirname "$PDF")
PDFLATEX_OUTPUT="${PDFLATEX_OUTPUT_DIR}/${PDFLATEX_INPUT%.tex}.pdf"
PDFLATEX_ARTEFACT_EXTS=(aux log out toc)

cleanup() {
	# Remove build script's temporary files
	rm -f "$HEADER_MD" "$REPORT_MD" "$REPORT_CLEAN_MD"

	# Remove unused pdflatex output
	for ext in "${PDFLATEX_ARTEFACT_EXTS[@]}"; do
		find "$PDFLATEX_OUTPUT_DIR" -mindepth 1 -name "*.$ext" -type f -exec rm -f {} \;
	done

	if [ "$PDFLATEX_OUTPUT" != "$PDF" ]; then
		rm -f "$PDFLATEX_OUTPUT"
	fi
}

line_count() {
	filename="$1"

	python3 -c "file = open('$filename', 'r'); print(len(file.readlines())); file.close()"
}

after_line_N() {
	filename="$1"
	N="$2"

	from=$(( "$N" + 1 ))
	to=$(line_count "$filename")

	tail -n $(( "$to" - "$from" + 1 )) "$filename"
}

remove_frontmatter() {
	filename="$1"

	# Get grep's second occurrence of '---'
	frontmatter_grep_end_line=$(grep -n "\-\-\-" "$filename" | head -n 2 | tail -n 1)

	# Extract line number from grep output, e.g. 7: ... -> 7
	frontmatter_end_line_number="${frontmatter_grep_end_line%:*}"

	# Output everything after the YAML frontmatter
	after_line_N "$filename" "$frontmatter_end_line_number"
}

trap cleanup EXIT

## Install dependencies
is_installed () {
	package="$1"
	dpkg -s "$package" &>/dev/null
}

updated=false
for package in "${REQUIREMENTS[@]}"; do
	if ! (is_installed "$package"); then
		if ! $updated; then
			echo "Installing dependencies..."
			sudo apt update
			updated=true
		fi
		sudo apt install -y "$package"
	fi
done

## $LATEX -> $PDF
rm -f "$PDF"
pdflatex -output-directory "$PDFLATEX_OUTPUT_DIR" -interaction=nonstopmode "$LATEX" # First pass
pdflatex -output-directory "$PDFLATEX_OUTPUT_DIR" -interaction=nonstopmode "$LATEX" # Second pass
[ "$PDFLATEX_OUTPUT" != "$PDF" ] && mv "$PDFLATEX_OUTPUT" "$PDF"
echo "Generated $PDF"

##  $LATEX -> $README_MD
# Create temporary $HEADER_MD
title=$(grep -Eo '\\title\{.*\}' "$LATEX" | sed 's/\\title{//; s/}//')
author=$(grep -Eo '\\author\{.*\}' "$LATEX" | sed 's/\\author{//; s/}//')

{
	echo "> [Download the report](docs/report.pdf) 📄"
	echo "# $title"
	echo "$author"
	echo "<br/>"
	echo "<br/>"
	echo ""
} > "$HEADER_MD"

# Create temporary $REPORT_CLEAN_MD
pandoc --standalone "$LATEX" -o "$REPORT_MD" --from=latex --to=gfm
remove_frontmatter "$REPORT_MD" > "$REPORT_CLEAN_MD"

# Output $README_MD
cat "$HEADER_MD" "$REPORT_CLEAN_MD" > "$README_MD"
echo "Generated $README_MD"
