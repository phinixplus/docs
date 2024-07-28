#import "/source/config.typ": font-mono
#import "/source/config.typ": code-bg-color, code-weight
#import "/source/config.typ": text-size-3

#let code(file-path, language, tab-size: 4) = {
	let file-content = read(file-path).replace("\t", " "*tab-size)
	show raw: set text(font: font-mono, size: text-size-3, weight: code-weight)
	set block(breakable: true, fill: code-bg-color, inset: 0.5em, radius: 0.5em)
	align(center, block(align(start, raw(file-content, lang: language))))
}

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
