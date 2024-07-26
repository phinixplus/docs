#!/bin/bash

mkdir -p "documents/"

# Find all subdirectories in src/ and keep only their name
docs=$(find source -mindepth 1 -maxdepth 1 | cut -d'/' -f 2)

# Compile the src/x/x.typ file
# and put the resulting PDFs in doc/x.pdf
# for all x found from before
for doc in $docs; do
	typ="source/$doc/$doc.typ"
	pdf="documents/$doc.pdf"
	echo "Building document $pdf from $typ"
	typst compile --root . $typ $pdf
done

echo "Build completed."
