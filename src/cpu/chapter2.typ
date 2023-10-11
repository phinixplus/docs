= Registers

#columns(2)[

#align(center, table(
	columns: (1fr, 1fr, 4fr, 2fr), stroke: 0.2mm,
	fill: (_, row) => if row == 0 {black} else {white},
	text(fill: white)[*Arch.*],
	text(fill: white)[*Conv.*],
	text(fill: white)[*Description*],
	text(fill: white)[*Save?*],
	[x0], [\$zr], [Constant Zero], [None],
	[x1], [\$at], [Assembler Temporary], [Caller],
	[x2], [\$rp], [Return Pointer], [Caller],
	[x3], [\$a0], [Arg./Return Value \#0], [Caller],
	[x4], [\$a1], [Arg./Return Value \#1], [Caller],
	[x5], [\$a2], [Arg./Return Value \#2], [Caller],
	[x6], [\$t0], [Temporary Value \#0], [Caller],
	[x7], [\$t1], [Temporary Value \#1], [Caller],
	[x8], [\$t2], [Temporary Value \#2], [Caller],
	[x9], [\$s0], [Saved Value \#0], [Callee],
	[xA], [\$s1], [Saved Value \#1], [Callee],
	[xB], [\$s2], [Saved Value \#2], [Callee],
	[xC], [\$s3], [Saved Value \#3], [Callee],
	[xD], [\$s4], [Saved Value \#4], [Callee],
	[xE], [\$s5], [Saved Value \#5], [Callee],
	[xF], [\$fp], [Frame Pointer], [Callee],
))

#colbreak()

#align(center, table(
	columns: (1fr, 1fr, 4fr, 2fr), stroke: 0.2mm,
	fill: (_, row) => if row == 0 {black} else {white},
	text(fill: white)[*Arch.*],
	text(fill: white)[*Conv.*],
	text(fill: white)[*Description*],
	text(fill: white)[*Save?*],
	[y0], [\$t3], [Temporary Value \#3], [Caller],
	[y1], [\$t4], [Temporary Value \#4], [Caller],
	[y2], [\$t5], [Temporary Value \#5], [Caller],
	[y3], [\$a3], [Arg./Return Value \#3], [Caller],
	[y4], [\$a4], [Arg./Return Value \#4], [Caller],
	[y5], [\$a5], [Arg./Return Value \#5], [Caller],
	[y6], [\$s6], [Saved Value \#6], [Callee],
	[y7], [\$s7], [Saved Value \#7], [Callee],
	[y8], [\$s8], [Saved Value \#8], [Callee],
	[y9], [\$s9], [Saved Value \#9], [Callee],
	[yA], [\$gp], [Global Pointer], [Callee],
	[yB], [\$sp], [User Stack Pointer], [Callee],
	[yC], [\$k0], [System Value \#0], [Callee],
	[yD], [\$k1], [System Value \#1], [Callee],
	[yE], [\$k2], [System Value \#2], [Callee],
	[yF], [\$kp], [System Stack Pointer], [Callee],
))

]

#align(center, box(width: 50%, table(
	columns: (1fr, 4fr, 2fr), stroke: 0.2mm,
	fill: (_, row) => if row == 0 {black} else {white},
	text(fill: white)[*Arch.*],
	text(fill: white)[*Description*],
	text(fill: white)[*Save?*],
	[\$ip], [Instruction Pointer], [None],
	[\$jp], [Interrupt Return Pointer], [None],
	[\$rf], [Reference Register], [Caller],
	[\$st], [Status Register], [Caller],
)))

#pagebreak()
