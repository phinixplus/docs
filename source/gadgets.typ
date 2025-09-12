#let date-now = {
	let today = datetime.today()
	let (day-num, year-num) = (today.day(), today.year())
	let day-suffix = "th"
	if day-num == 1 or day-num == 21 or day-num == 31 { day-suffix = "st" }
	else if day-num == 2 or day-num == 22 { day-suffix = "nd" }
	else if day-num == 3 or day-num == 23 { day-suffix = "rd" }
	[#day-num#day-suffix of #today.display("[month repr:long]") #year-num]
}

#let separator(length: 98%) = {
	show line: set align(center)
	line(length: length, stroke: 0.1mm)
}

#let interjection(body, icon, color: black) = {
	import "/source/config.typ": interj-fg-color, text-size-5, font-mono
	grid(columns: (10mm, 1fr), stroke: 0mm, fill: white, align: horizon,
		text(font: font-mono, size: text-size-5, fill: color, icon),
		grid.vline(stroke: (paint: color, thickness: 0.3mm, cap: "round")),
		block(inset: (x: 5mm, y: 1mm), text(fill: interj-fg-color, body))
	)
}

#let note(body) = interjection(body, [], color: blue)
#let comment(body) = interjection(body, [], color: green)

#let layout(name: "", ..fields) = {
	let bits = fields.pos().map(f => f.bits).sum()
	assert(bits <= 32)

	import "@preview/cetz:0.3.4"
	import "/source/config.typ": text-size-1, text-size-2, font-mono
	import "/source/config.typ": table-bg-color, text-weight-bold
	import "/source/config.typ": ifmt-empty-color

	set align(right)
	set text(size: text-size-1, font: font-mono)
	cetz.canvas(length: 100% / 32, {
		import cetz.draw: content, rect, line
		let (count, idx) = (0, 0)
		if(name != "") { content( // Format Name
			anchor: "east", padding: 0.1, (0,0.5),
			text(size: text-size-2)[#name]
		)}
		while count < bits {
			let f = fields.pos().at(idx)
			let label = f.at("label", default: "-")
			if label == none { label = "-" }
			let color = f.at("color", default: ifmt-empty-color)
			rect( // Enclosing Rectangle
				(count, 0), (count + f.bits, 1),
				stroke: 0.2mm + table-bg-color,
				fill: if label == "-" { ifmt-empty-color } else { color }
			)
			for i in range(count + 1, count + f.bits) { // Bit Notches
				line((i,0), (i,0.1), stroke: 0.2mm + table-bg-color)
				line((i,0.9), (i,1), stroke: 0.2mm + table-bg-color)
			}
			content( // Rightmost Bit Index
				anchor: "mid", (count + f.bits - 0.5 , 1.25),
				text[#{bits - count - f.bits}]
			)
			if f.bits > 1 { content( // Leftmost Bit Index
				anchor: "mid", (count + 0.5 , 1.25),
				text[#{bits - count - 1}]
			)}
			content( // Field Label
				anchor: "mid", (count + f.bits/2, 0.5),
				text(label)
			)
			idx = idx + 1
			count = count + f.bits
		}
	})
}

#import "/source/config.typ": ifmt-opc-color, ifmt-aux-color
#import "/source/config.typ": ifmt-reg-color, ifmt-imm-color

#let layout-wgil(
	name: "WGIL", opc: "opcode", tgt-g: "tgt.g",
	imm_hi: "imm20[19:16]", imm_mid: "imm20[15:8]", imm_lo: "imm20[7:0]"
) = layout(name: name,
	(bits: 8, color: ifmt-imm-color, label: imm_lo),
	(bits: 8, color: ifmt-imm-color, label: imm_mid),
	(bits: 4, color: ifmt-imm-color, label: imm_hi),
	(bits: 4, color: ifmt-reg-color, label: tgt-g),
	(bits: 8, color: ifmt-opc-color, label: opc)
)

#let layout-wggih(
	name: "WGGIH", opc: "opcode", tgt-g1: "tgt.g1", tgt-g2: "tgt.g2",
	imm_hi: "imm16[15:8]", imm_lo: "imm16[7:0]"
) = layout(name: name,
	(bits: 8, color: ifmt-imm-color, label: imm_lo),
	(bits: 8, color: ifmt-imm-color, label: imm_hi),
	(bits: 4, color: ifmt-reg-color, label: tgt-g2),
	(bits: 4, color: ifmt-reg-color, label: tgt-g1),
	(bits: 8, color: ifmt-opc-color, label: opc)
)

#let layout-wcgih(
	name: "WCGIH", opc: "opcode", tgt-g: "tgt.g", nt: "nt", tgt-c: "tgt.c",
	imm_hi: "imm16[15:8]", imm_lo: "imm16[7:0]"
) = layout(name: name,
	(bits: 8, color: ifmt-imm-color, label: imm_lo),
	(bits: 8, color: ifmt-imm-color, label: imm_hi),
	(bits: 1, color: ifmt-aux-color, label: nt),
	(bits: 3, color: ifmt-reg-color, label: tgt-c),
	(bits: 4, color: ifmt-reg-color, label: tgt-g),
	(bits: 8, color: ifmt-opc-color, label: opc)
)

#let layout-w3gib(
	name: "W3GIB", opc: "opcode", funct: "funct",
	tgt-g1: "tgt.g1", tgt-g2: "tgt.g2", src-g: "src.g", imm: "imm8"
) = layout(name: name,
	(bits: 8, color: ifmt-imm-color, label: imm),
	(bits: 4, color: ifmt-reg-color, label: src-g),
	(bits: 4, color: ifmt-opc-color, label: funct),
	(bits: 4, color: ifmt-reg-color, label: tgt-g2),
	(bits: 4, color: ifmt-reg-color, label: tgt-g1),
	(bits: 8, color: ifmt-opc-color, label: opc)
)

#let layout-wcggib(
	name: "WCGGIB", opc: "opcode", funct: "funct",
	tgt-g: "tgt.g", nt: "nt", tgt-c: "tgt.c", src-g: "src.g", imm: "imm8"
) = layout(name: name,
	(bits: 8, color: ifmt-imm-color, label: imm),
	(bits: 4, color: ifmt-reg-color, label: src-g),
	(bits: 4, color: ifmt-opc-color, label: funct),
	(bits: 1, color: ifmt-aux-color, label: nt),
	(bits: 3, color: ifmt-reg-color, label: tgt-c),
	(bits: 4, color: ifmt-reg-color, label: tgt-g),
	(bits: 8, color: ifmt-opc-color, label: opc)
)

#let layout-wcc3g(
	name: "WCC3G", opc: "opcode", funct: "funct",
	tgt-g1: "tgt.g1", tgt-g2: "tgt.g2", src-g: "src.g",
	nt: "nt", tgt-c: "tgt.c", ns: "ns", src-c: "src.c",
) = layout(name: name,
	(bits: 1, color: ifmt-aux-color, label: nt),
	(bits: 3, color: ifmt-reg-color, label: tgt-c),
	(bits: 1, color: ifmt-aux-color, label: ns),
	(bits: 3, color: ifmt-reg-color, label: src-c),
	(bits: 4, color: ifmt-reg-color, label: src-g),
	(bits: 4, color: ifmt-opc-color, label: funct),
	(bits: 4, color: ifmt-reg-color, label: tgt-g2),
	(bits: 4, color: ifmt-reg-color, label: tgt-g1),
	(bits: 8, color: ifmt-opc-color, label: opc)
)
