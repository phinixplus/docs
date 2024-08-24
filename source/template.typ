#import "/source/utilities.typ": date-now

#import "/source/config.typ": font-sans, font-serif
#import "/source/config.typ": text-fg-color, inv-text-fg-color, heading-fg-color, table-bg-color
#import "/source/config.typ": text-weight-normal, text-weight-bold, heading-weight
#import "/source/config.typ": text-size-1, text-size-2, text-size-3, text-size-4, text-size-5

#let license-link = "https://creativecommons.org/licenses/by-nc-sa/4.0/"
#let discord-link = "https://discord.gg/EFKDF3VE9C"

#let template(doc-part, version, keywords, content) = {
	set document(title: [The PHINIX+ Documentation])
	set document(author: "Martin Andronikos")
	set document(date: datetime.today())
	set document(keywords: keywords)

	set page(paper: "a4", numbering: "1")
	set page(margin: (x: 25mm, y: 20mm))
	set text(font: font-serif, size: text-size-2)
	set text(weight: text-weight-normal, fill: text-fg-color)
	set text(hyphenate: false)
	set par(justify: true)
	set par(leading: 0.6em)

	set block(breakable: true)
	show link: x => text(fill: blue, underline(x))
	show ref: x => text(fill: blue, x)
	
	set heading(numbering: "1.1 ")
	show heading: set text(font: font-sans)
	show heading: set text(weight: heading-weight, fill: heading-fg-color)
	show heading.where(level: 3): set text(size: text-size-2)
	show heading.where(level: 2): set text(size: text-size-3)
	show heading.where(level: 1): x => {
		pagebreak(weak: true)
		set text(size: text-size-4)
		let numbers = counter(heading).display()
		let title = underline(offset: 0.1em, x.body)
		if x.location().page() < 3 { par[#title] }
		else { par[#numbers #title] }
		v(0.8em, weak: true)
	}

	show figure: set align(center)
	show figure: set block(breakable: true)
	show figure: x => block[#x.body#v(0.5em, weak: true)#x.caption]
	show figure.caption: x => {
		set text(size: text-size-1, weight: text-weight-bold)
		[#x.supplement #x.counter.display(x.numbering):]
		text(weight: text-weight-normal)[ #x.body]
	}

	set table(stroke: 0.2mm + table-bg-color)
	set table(fill: (_, row) => if row == 0 {table-bg-color} else {white})
	show table: set align(center)
	show table.cell.where(y: 0): set text(weight: text-weight-bold)
	show table.cell.where(y: 0): set text(fill: inv-text-fg-color)

	page(numbering: none, margin: (top: 80mm, bottom: 20mm))[#{
		set align(center + top)
		set text(font: font-sans)
		set text(weight: text-weight-bold, fill: luma(0))
		image("/assets/logo.svg", width: 25%)
		text(size: text-size-5)[The PHINIX+ System Architecture Documentation \ ]
		text(size: text-size-4)[#doc-part]

		set align(center + bottom)
		set text(font: font-serif, size: text-size-1)
		set text(weight: text-weight-normal, fill: luma(80))
		grid(columns: (1fr, 1fr, 1fr), align: horizon, stroke: 0pt,
			[
				Come discuss with us at the official PHINIX+ Discord server: \
				#link(discord-link, box(image("/assets/discord.svg", width: 5%)))
				#link(discord-link)
			], [
				Version: #version \ Date: #date-now \ by Martin Andronikos
			], [
				#link(license-link, box(image("/assets/license.svg", width: 50%)))
				\ Licensed under CC BY-NC-SA 4.0 \ #link(license-link)
			]
		)
	}]

	outline(indent: 0.75em, fill: line(length: 100%, stroke: 0.2mm))
	pagebreak(weak: true)

	[#content]
}
