#let regfile = [

#import "/source/utilities.typ": note, comment

= Register Files
A register file is a grouping of individually addressable memory cells, also
known as registers, that are closely coupled with the operation and structure
of a processor architecture. PHINIX+ defines three of these register files,
each with a slightly different purpose. The first two of the novel features
outlined in @table-novelfeatures are thus formally introduced in this chapter.

#note[
	Registers are the most common subjects (also referred to as operands) of
	the instructions a CPU executes, especially if it follows the load-store
	paradigm wherein, as a consequence, no arithmetic/logic instruction can
	directly operate on memory.
]

== General Purpose Registers
The general purpose registers are a pair of register files, each one aimed
towards a narrower set of use cases. This is the first novel feature of
PHINIX+, initially noted in the first entry of @table-novelfeatures. Each file
consists of 16 registers for a total of 32 registers. The two register files
are to be detailed in the following two sections and an extra section
listing out the registers in table form.

#comment[
	The quantity of general purpose registers PHINIX+ provides, 32, is a
	commonality amongst the majority of RISC processor architectures,
	consistently more than the usual CISC architecture. The reason for this
	is that having instructions that do less work would necessitate more
	space to store intermediate values in.
]

=== Data Registers
The data registers are the most versatile set of registers available. 16
are provided, each one being 32 bits in width, denoted #emph[\$xN] (where
N is a single hexadecimal digit ranging from 0 to 9 and then from A to F).
They are intended to hold values loaded from or to be stored to memory and
to be the subject (operand) of most arithmetic and logic operations the CPU
performs.

#note[
	It is important to note that the first data register, #emph[\$x0] is not
	actually a register one can write to. Register #emph[\$x0] is a constant
	holding the value zero. This is a nigh universal design pattern across
	the RISC processor family and has been included in PHINIX+ for the same
	reasons.
]

#comment[
	Data register #emph[\$x0] being a constant zero aids in better usage of
	existing instructions (or conversely allows for the reduction of the needed
	instructions) in at least the following two ways:
	-	#[By allowing them to discard their result by storing to this
		register when only the condition code generated from that instruction
		is required. For example, a comparison instruction can be achieved by
		doing a subtraction and storing the result to #emph[\$x0].]
	-	#[The most common operation, either as a standalone instruction or as
		a component in the function of more complex instructions, is addition.
		By having a constant-zero value (the neutral element of addition)
		available all the time allows addition to be effectively bypassed,
		expanding the usage of many instructions. For example, a move
		instruction can be achieved by doing an addition with one of the
		operands being #emph[\$x0].]
]

=== Address Registers
The address registers are a secondary set of registers that are less versatile
computation-wise than the data registers. Just like the data registers, 16 are
provided, again, each one being 32 bits in width, denoted instead #emph[\$yN]
(where N is a single hexadecimal digit, ranging from 0 to 9 and then
from A to F).

While still having more available functionality than for just storing and
manipulating pointers, the address registers' primary purpose is nevertheless
for the aforementioned task or for serving as a bank of secondary storage
when the data registers are not enough to hold all datums of a computation.

#pagebreak()
=== Data and Address Register Tables
The previously discussed general purpose registers are hereby illustrated in
table form.

#figure(grid(columns: 2, gutter: 1em,
	table(columns: (40mm),
		table.header([Data Registers]),
		[\$x0], [\$x1], [\$x2], [\$x3], [\$x4], [\$x5], [\$x6], [\$x7],
		[\$x8], [\$x9], [\$xA], [\$xB], [\$xC], [\$xD], [\$xE], [\$xF],
	),
	table(columns: (40mm),
		table.header([Address Registers]),
		[\$y0], [\$y1], [\$y2], [\$y3], [\$y4], [\$y5], [\$y6], [\$y7],
		[\$y8], [\$y9], [\$yA], [\$yB], [\$yC], [\$yD], [\$yE], [\$yF]
	)
), caption: [PHINIX+'s general purpose registers]) <table-generalregs>

== Condition Code Registers
The condition code registers, or "flag" registers, are a collection of 8
registers each one being only 1 bit in width. Their purpose is, as the name
suggests, to hold intermediate condition codes for the purpose of program
control flow. Branch instructions, which are later discussed, are intimately
tied with this set of registers. #footnote[Branch instructions and how they
relate to the condition code registers are discussed in TODO.] This is the
second novel feature of PHINIX+, initially noted in the second entry of
@table-novelfeatures. They are denoted #emph[\$cN] (where N is a single octal
digit, ranging from 0 to 7).

#figure(table(columns: 1,
	table.header([Condition Code Registers]),
	[\$c0], [\$c1], [\$c2], [\$c3], [\$c4], [\$c5], [\$c6], [\$c7],
), caption: [PHINIX+'s condition code registers]) <table-condregs>

#note[
	Just like with data register #emph[\$x0], condition code register
	#emph[\$c0] holds a constant zero value, except in this case it's
	a single zero-bit.
]

#comment[
	Having a constant zero condition register likewise reduces the needed
	variants for the instructions that handle them while still providing
	more options for the programmer.
]

]
