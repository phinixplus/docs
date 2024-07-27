#!/bin/bash
docdir="documents"
srcdir="source"

# Ensure the output directory exists
mkdir -p "$docdir/"

# Find all subdirectories in src/ and keep only their name
docs=$(find "$srcdir/" -mindepth 1 -maxdepth 1 -type d | cut -d'/' -f 2)

# Compile the s/x/x.typ file
# and put the resulting PDFs in doc/x.pdf
# for all x found from before
for doc in $docs; do
	typ="$srcdir/$doc/$doc.typ"
	pdf="$docdir/$doc.pdf"
	echo "Building document $pdf from $typ"
	typst compile --root . $typ $pdf
done

echo "Build completed."
