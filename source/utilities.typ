#import "/source/config.typ": font-sans, font-mono
#import "/source/config.typ": interj-fg-color, text-fg-color, code-bg-color, code-fg-color
#import "/source/config.typ": text-weight-normal, text-weight-bold, code-weight
#import "/source/config.typ": text-size-2, text-size-5

#let code(file-path, language, tab-size: 4) = {
	let file-content = read(file-path).replace("\t", " "*tab-size)
	set block(breakable: true, radius: 0.6em)
	show block: set align(center)
	block(fill: code-fg-color,inset: 0.3em)[#{
		show raw: set align(start)
		show raw: set text(font: font-mono, size: text-size-2, weight: code-weight)
		block(fill: code-bg-color, inset: 1em, raw(file-content, lang: language))
		show text: x => move(dy: -0.5em, x)
		text(font: font-sans, weight: text-weight-bold, file-path.split("/").last())
	}]
}

#let interjection(body, icon, color: black) = {
	grid(columns: (20mm, auto), stroke: 0mm, fill: white,
		align(center + horizon, block[#{
			set text(font: font-mono)
			set text(size: text-size-5)
			set text(fill: color)
			text(icon)
		}]),
		grid.vline(stroke: (paint: color, thickness: 0.3mm, cap: "round")),
		align(left + horizon, block(inset: 5mm)[#{
			set text(fill: interj-fg-color)
			text(body)
		}])
	)
}

#let note(body) = interjection(body, [], color: blue)
#let comment(body) = interjection(body, [], color: green)

#let separator(length: 98%) = {
	show line: set align(center)
	line(length: length, stroke: 0.1mm)
}

#let date-now = {
	let today = datetime.today()
	let (day-num, year-num) = (today.day(), today.year())
	let day-suffix = "th"
	if day-num == 1 or day-num == 21 or day-num == 31 { day-suffix = "st" }
	else if day-num == 2 or day-num == 22 { day-suffix = "nd" }
	else if day-num == 3 or day-num == 23 { day-suffix = "rd" }
	[#day-num#day-suffix of #today.display("[month repr:long]") #year-num]
}
