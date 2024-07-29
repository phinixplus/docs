#import "/source/config.typ": font-sans, font-mono
#import "/source/config.typ": code-bg-color, code-fg-color
#import "/source/config.typ": text-weight-bold, code-weight
#import "/source/config.typ": text-size-2

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

#let date-now = {
	let today = datetime.today()
	let (day-num, year-num) = (today.day(), today.year())
	let day-suffix = "th"
	if day-num == 1 or day-num == 21 or day-num == 31 { day-suffix = "st" }
	else if day-num == 2 or day-num == 22 { day-suffix = "nd" }
	else if day-num == 3 or day-num == 23 { day-suffix = "rd" }
	[#day-num#day-suffix of #today.display("[month repr:long]") #year-num]
}
