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

== Data Registers
The data registers are the most versatile set of registers available. Sixteen
(16) are provided, all 32 bits in width, denoted #emph[\$xN] (where N, a single
hexadecimal digit ranging from 0 to 9 and then from A to F).

#note[
	Data registers are intended to store values loaded from or to be stored to
	memory and to be the subject of most arithmetic and logic operations the
	CPU performs.
]

#figure(table(columns: 3,
	table.header([Architectural Name], [Convention Name], [Saving]),
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
), caption: [PHINIX+'s data registers]) <table-dataregs>

#comment[
	Data register #emph[\$x0] is a register that constantly and forever holds
	the value zero. It aids in better usage of existing instructions by allowing
	them to discard their result by storing to this register when only the
	condition code generated from that instruction is required. For example, a
	comparison instruction can be achieved by doing a subtraction and storing
	the result to register zero. This is a nigh universal design pattern across
	the RISC processor family.
]

== Address Registers
The address registers are a secondary set of registers that are less versatile
computation-wise than the data registers. Just like the data registers, sixteen
(16) are provided, again all 32 bits in width, denoted instead #emph[\$yN]
(where N, a single hexadecimal digit, ranging from 0 to 9 and then from A to F).

#note[
	While still having more available functionality than for just storing
	and manipulating pointers, the address registers' primary purpose is
	nevertheless for manipulating and storing pointers or as a bank of
	secondary storage when the data registers are not enough to hold all
	datums of a computation.
]

#figure(table(columns: 3,
	table.header([Architectural Name], [Convention Name], [Saving]),
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
), caption: [PHINIX+'s address registers]) <table-addrregs>

== Condition Code Registers
The condition code registers are the most special one of the bunch. Eight (8) of
them are provided, each one being just 1 bit in width. They are denoted
#emph[\$cN] (where N, a single octal digit, ranging from 0 to 7).

#note[
	A condition code register's purpose is to hold intermediate "flags",
	assisting in program control flow. The branch instructions to be later
	discussed are intimately tied with this set of registers.
]

#figure(table(columns: 3,
	table.header([Architectural Name], [Convention Name], [Saving]),
	[\$c0], [\$c0], [N/A],
	[\$c1], [\$c1], [Callee],
	[\$c2], [\$c2], [Callee],
	[\$c3], [\$c3], [Callee],
	[\$c4], [\$c4], [Callee],
	[\$c5], [\$c5], [Callee],
	[\$c6], [\$c6], [Callee],
	[\$c7], [\$c7], [Callee]
), caption: [PHINIX+'s condition code registers]) <table-condregs>

#comment[
	Condition code register #emph[\$c0] is a register that constantly and
	forever holds a zero bit. This simplifies the logic needed to handle
	a cascading set of conditions and reduces the amount of instructions
	required to handle all the needed cases.
]

#comment[
	Having eight condition code registers, each one being 1 bit in width means
	that saving and restoring the contents can be done in one fell swoop. The
	entire register file's contents can fit into a single byte. To aid in this
	mechanic, all of the registers have the same saving convention (with the
	exception of #emph[\$c0], on which saving is not applicable due to its
	constant nature).
]

]
