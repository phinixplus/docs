#let modulo(x, y) = {
	let div = x / y
	let quot = int(div)
	let mod-dirty = (div - quot) * y
	let int-part = int(mod-dirty)
	let frac-part = num - int-part
	if frac-part < 0.5 { int-part }
	else {int-part + 1 }
}

#let date-now = {
	let today = datetime.today()
	let (day-num, year-num) = (today.day(), today.year())
	let day-suffix = ("st", "nd", "rd").at(day-num - 1, default: "th")
	[#day-num#day-suffix of #today.display("[month repr:long]") #year-num]
}

#let template(doc-part, version, content) = {
	set page(paper: "a4", numbering: "1")
	set page(margin: (x: 25mm, y: 20mm))

	set text(font: "IBM Plex Serif", size: 10pt)
	set text(weight: 400, fill: luma(80))
	set text(hyphenate: false)

	set par(justify: true)
	set par(leading: 0.6em)

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
		if x.location().page() < 3 { par[#title] }
		else { par[#numbers #title] }
	}

	page(numbering: none, margin: (top: 80mm, bottom: 20mm))[#{
		set align(center + top)
		set text(weight: 700, fill: luma(0))
		image("/assets/logo.svg", width: 25%)
		text(size: 14pt)[The PHINIX+ System Architecture Documentation \ ]
		text(size: 12pt)[#doc-part]

		set align(center + bottom)
		set text(size: 8pt, weight: 400, fill: luma(80))
		let license-link = "https://creativecommons.org/licenses/by-nc-sa/4.0/"
		let discord-link = "https://discord.gg/EFKDF3VE9C"
		table(columns: (1fr, 1fr, 1fr), align: horizon, stroke: 0pt,
			[
				Come discuss with us at the official PHINIX+ Discord server: \
				#link(discord-link, box(image("/assets/discord.svg", width: 5%)))
				#link(discord-link, discord-link)
			], [
				Version: #version \ Date: #date-now \ by Martin Andronikos 
			], [
				#link(license-link, box(image("/assets/license.svg", width: 50%)))
				\ Licensed under CC BY-NC-SA 4.0 \ #link(license-link, license-link)
			]
		)
	}]

	outline(indent: 0.75em, fill: none)
	pagebreak()

	[ #content ]
}
