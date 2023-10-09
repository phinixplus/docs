#let template(doc_part, version, date, content) = [
	// Global Configuration
	#set page(paper: "a4", numbering: "1", margin: (x: 15mm, y: 15mm))
	#set text(hyphenate: false, font: "FreeSerif", size: 4mm)
	#set heading(numbering: "1.1 ")
	#set par(justify: true)
	#set line(length: 100%)

	// Heading setup
	#show heading: x => {
		let prefix = []
		if x.location().page() != 2 { prefix = counter(heading).display() }

		set text(font: "DejaVu Sans", weight: "bold")
		if x.level == 1 {
			set text(size: 8mm)
			block[
				#text(size: 6mm, prefix)
				#underline(stroke: 0.5mm, offset: 0.15em)[#x.body]
			]
		} else if x.level == 2 {
			set text(size: 6mm)
			block[
				#text(size: 4mm, prefix)
				#x.body
			]
		}
	}

	// Link setup
	#show link: x => text(fill: blue, underline(x))
	#show ref: x => text(fill: blue, x)

	// Preamble
	#[
		// Title page
		#set par(justify: false)
		#page(numbering: none, margin: (y: 60mm))[
			#set align(center + top)
			#image("logo.svg", width: 25%)
			#text(font: "DejaVu Sans", weight: "bold")[
				#text(size: 5mm)[The PHINIX+ System Architecture Documentation \ ]
				#doc_part
			]

			#set align(center + bottom)
			Version #version (#date) \ by Martin Andronikos
		]

		// Contents page
		#set text(size: 5mm)
		#outline(indent: 0.75em, fill: none)
		#pagebreak()
	]

	// Main docuemnt
	#content
]
