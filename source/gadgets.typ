#import "/source/config.typ": font-sans, font-mono
#import "/source/config.typ": interj-fg-color, text-fg-color, code-bg-color, code-fg-color
#import "/source/config.typ": text-weight-normal, text-weight-bold, code-weight
#import "/source/config.typ": text-size-2, text-size-5

#let date-now = {
	let today = datetime.today()
	let (day-num, year-num) = (today.day(), today.year())
	let day-suffix = "th"
	if day-num == 1 or day-num == 21 or day-num == 31 { day-suffix = "st" }
	else if day-num == 2 or day-num == 22 { day-suffix = "nd" }
	else if day-num == 3 or day-num == 23 { day-suffix = "rd" }
	[#day-num#day-suffix of #today.display("[month repr:long]") #year-num]
}

#let interjection(body, icon, color: black) = {
	grid(columns: (10mm, 1fr), stroke: 0mm, fill: white, align: horizon,
		text(font: font-mono, size: text-size-5, fill: color, icon),
		grid.vline(stroke: (paint: color, thickness: 0.3mm, cap: "round")),
		block(inset: (x: 5mm, y: 1mm), text(fill: interj-fg-color, body))
	)
}

#let note(body) = interjection(body, [], color: blue)
#let comment(body) = interjection(body, [], color: green)

#let separator(length: 98%) = {
	show line: set align(center)
	line(length: length, stroke: 0.1mm)
}

