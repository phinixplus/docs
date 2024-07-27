#let template(doc_part, version, date, content) = {
	set page(paper: "a4", numbering: "1")
	set page(margin: (x: 25mm, y: 20mm))

	set text(font: "IBM Plex Serif", size: 10pt)
	set text(weight: 400, fill: luma(80))
	set text(hyphenate: false)
	set par(justify: true)

	set line(length: 98%, stroke: 0.01em)
	show line: set align(center)

	show link: x => text(fill: blue, underline(x))
	show ref: x => text(fill: blue, x)
	
	set heading(numbering: "1.1 ")
	show heading: set text(font: "IBM Plex Sans", weight: 400, fill: luma(0))
	show heading.where(level: 3): set text(size: 10pt)
	show heading.where(level: 2): set text(size: 12pt)
	show heading.where(level: 1): x => {
		set text(size: 14pt)
		let numbers = counter(heading).display()
		let title = underline(offset: 0.1em, x.body)
		par[#numbers #title]
	}

	page(numbering: none, margin: (y: 60mm))[#{
		set align(center + top)
		set text(weight: 700, fill: luma(0))
		image("/assets/logo.svg", width: 25%)
		text(size: 14pt)[The PHINIX+ System Architecture Documentation \ ]
		text(size: 10pt)[#doc_part]

		set align(center + bottom)
		set text(weight: 400, fill: luma(80))
		[Version #version (#date) \ by Martin Andronikos]
	}]

	outline(indent: 0.75em, fill: none)
	pagebreak()

	[ #content ]
}
