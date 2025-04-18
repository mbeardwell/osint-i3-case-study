#!/bin/bash
set -euo pipefail

REQUIREMENTS=(pandoc texlive-latex-recommended texlive-latex-extra)

# Input
TLDR="tldr.md"	
LATEX="report.tex"

# Output
PDF="report.pdf"
README="README.md"

# Install dependencies
isInstalled () {
	package="$1"
	dpkg -s "$package" &>/dev/null
}

updated=false
for package in "${REQUIREMENTS[@]}"; do
	if ! (isInstalled "$package"); then
		if ! "$updated"; then
			echo "Installing dependencies..."
			sudo apt update
			updated=true
		fi
		sudo apt install -y "$package"
	fi
done

# Cleanup
rm -f ./*.aux ./*.log ./*.out ./*.toc "$README" "$PDF"

# report.tex -> PDF
pdflatex -interaction=nonstopmode "$LATEX" # First pass
pdflatex -interaction=nonstopmode "$LATEX" # Second pass
pdfTemp="${LATEX%.tex}.pdf" && [ "$pdfTemp" != "$PDF" ] && mv "$pdfTemp" "$PDF"
echo "Generated $PDF"

#  report.tex -> README.md
pandoc --standalone "$LATEX" -o "./tmp.md" --from=latex --to=gfm
cat "$TLDR" "./tmp.md" > "$README" && rm -f "./tmp.md"
echo "Generated $README"

# Cleanup
rm -f ./*.aux ./*.log ./*.out ./*.toc