#let regfile = [

#import "/source/utilities.typ": note, comment

= Register Files
A register file is a grouping of individually addressable memory cells, also
known as registers, that are closely coupled with the operation and structure
of a processor architecture. PHINIX+ defines three of these register files,
each with a slightly different purpose. The first two of the novel features
outlined in @table-novelfeatures are thus explained in detail in this chapter.

#note[
	Registers are the most common subjects of the instructions a CPU executes,
	especially if it follows the load-store paradigm wherein, as a consequence,
	no arithmetic/logic instruction can directly operate on memory.
]

#align(center, grid(columns: 2, gutter: 1em,
	table(columns: 3,
		table.header([Arch. Name], [Conv. Name], [Saving]),
		[\$x0], [\$zr], [N/A],
		[\$x1], [TBD], [TBD],
		[\$x2], [TBD], [TBD],
		[\$x3], [TBD], [TBD],
		[\$x4], [TBD], [TBD],
		[\$x5], [TBD], [TBD],
		[\$x6], [TBD], [TBD],
		[\$x7], [TBD], [TBD],
		[\$x8], [TBD], [TBD],
		[\$x9], [TBD], [TBD],
		[\$xA], [TBD], [TBD],
		[\$xB], [TBD], [TBD],
		[\$xC], [TBD], [TBD],
		[\$xD], [TBD], [TBD],
		[\$xE], [TBD], [TBD],
		[\$xF], [TBD], [TBD]
	),
	table(columns: 3,
		table.header([Arch. Name], [Conv. Name], [Saving]),
		[\$y0], [TBD], [TBD],
		[\$y1], [TBD], [TBD],
		[\$y2], [TBD], [TBD],
		[\$y3], [TBD], [TBD],
		[\$y4], [TBD], [TBD],
		[\$y5], [TBD], [TBD],
		[\$y6], [TBD], [TBD],
		[\$y7], [TBD], [TBD],
		[\$y8], [TBD], [TBD],
		[\$y9], [TBD], [TBD],
		[\$yA], [TBD], [TBD],
		[\$yB], [TBD], [TBD],
		[\$yC], [TBD], [TBD],
		[\$yD], [TBD], [TBD],
		[\$yE], [TBD], [TBD],
		[\$yF], [TBD], [TBD]
	),
	grid.cell(colspan: 2, table(columns: 3,
		table.header([Arch. Name], [Conv. Name], [Saving]),
		[\$c0], [TBD], [TBD],
		[\$c1], [TBD], [TBD],
		[\$c2], [TBD], [TBD],
		[\$c3], [TBD], [TBD],
		[\$c4], [TBD], [TBD],
		[\$c5], [TBD], [TBD],
		[\$c6], [TBD], [TBD],
		[\$c7], [TBD], [TBD]
	))
))

]
