#let code(file-path, language, tab-size: 4) = {
	let file-content = read(file-path).replace("\t", " "*tab-size)
	show raw: set text(font: "Inconsolata", size: 12pt, weight: 500)
	set box(fill: luma(230), inset: 0.5em, radius: 0.5em)
	align(center, box(align(start, raw(file-content, lang: language))))
}
