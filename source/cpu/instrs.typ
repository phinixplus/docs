#let instr-info(desc, effect, extras) = grid(
	columns: (auto, 1fr), inset: 0.5em,
	..([*Description*], desc, [*Effect*], effect) +
	if extras != [] { ([*Extras*], extras) } else { () }
)

#let instrs = [

#import "/source/gadgets.typ": layout
#import "/source/config.typ": ifmt-opc-color, ifmt-aux-color
#import "/source/config.typ": ifmt-reg-color, ifmt-imm-color

= The Instruction Set

== AUI -- Add Upper Immediate
#layout(name: "WGGIH",
	(bits: 16, color: ifmt-imm-color, label: "imm"),
	(bits: 4, color: ifmt-reg-color, label: "src"),
	(bits: 4, color: ifmt-reg-color, label: "dst"),
	(bits: 8, color: ifmt-opc-color, label: "")
)

#instr-info(
	[Shift the immediate value `imm` left 16 bits, add it to the data
	register `src` and store the result to the data register `dst`.],
	`DRF[dst] = (imm << 16) + DRF[src]`, []
)

== REL -- Add Upper Immediate and Instruction Pointer
#layout(name: "WGGIH",
	(bits: 16, color: ifmt-imm-color, label: "imm"), (bits: 4),
	(bits: 4, color: ifmt-reg-color, label: "dst"),
	(bits: 8, color: ifmt-opc-color, label: "")
)

#instr-info(
	[Shift the immediate value `imm` left 16 bits, add it to the
	address of the next instruction (instruction pointer plus 4)
	and store the result to the data register `dst`.],
	`DRF[dst] = (imm << 16) + $ip + 4`, []
)

== JNLi -- Unconditional Far Jump and Link, Immediate Displacement
#layout(name: "WGIL",
	(bits: 20, color: ifmt-imm-color, label: "offset"),
	(bits:  4, color: ifmt-reg-color, label: "link"),
	(bits:  8, color: ifmt-opc-color, label: "")
)

#instr-info(
	[Save the address of the next instruction (instruction pointer plus 4)
	to the data register `link`. Add the sign-extended immediate value `offset`
	to the instruction pointer.],
	`DRF[link] = $ip + 4 , $ip += SXT(offset << 1)`,
	[The `offset` is in increments of 16 bits (half-words) and so is shifted
	left by 1. Thus the attainable range of the jump is #sym.plus.minus 1 MiB.]
)

== JNLr -- Unconditional Jump and Link, Register + Immediate
#layout(name: "WGGIH",
	(bits: 16, color: ifmt-imm-color, label: "offset"),
	(bits: 4, color: ifmt-reg-color, label: "base"),
	(bits: 4, color: ifmt-reg-color, label: "link"),
	(bits: 8, color: ifmt-opc-color, label: "")
)

#instr-info(
	[Save the address of the next instruction (instruction pointer plus 4) to
	the data register `link`. Add the data register `base` to the sign-extended
	immediate value `offset` and store the result to the instruction pointer.],
	`DRF[link] = $ip + 4 , $ip = SXT(offset << 1) + DRF[base]`,
	[The `offset` is in increments of 16 bits (half-words)
	and so is shifted left by 1.]
)

== JMP -- Conditional Jump, Register + Immediate
#layout(name: "WCGIH",
	(bits: 16, color: ifmt-imm-color, label: "offset"),
	(bits: 4, color: ifmt-aux-color, label: "cond"),
	(bits: 4, color: ifmt-reg-color, label: "base"),
	(bits: 8, color: ifmt-opc-color, label: "")
)

#instr-info(
	[Conditionally on the optionally negated condition code register `cond`,
	add the data register `base` to the sign-extended immediate value `offset`
	and store the result to the instruction pointer.],
	`IF cond { $ip = SXT(offset << 1) + DRF[base] }`,
	[The `offset` is in increments of 16 bits (half-words)
	and so is shifted left by 1.]
)

]
