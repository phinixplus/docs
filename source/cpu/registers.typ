#let registers = [

#import "/source/gadgets.typ": note, comment

= Registers
A register is an individually addressable memory cell that serves to
store some core piece of data regarding the state of the processor. As
a result they closely coupled with the operation and structure of the
processor's architecture. A register file, then, is a grouping of these
registers that serve a common purpose. PHINIX+ defines two of these
register files as well as a few extra registers not part of a
single register file, each one serving a different purpose.

#note[
	Registers are the most common subjects (also referred to as operands) of
	the instructions a CPU executes, especially if it follows the load-store
	paradigm wherein, as a consequence, no arithmetic/logic instruction can
	directly operate on memory.
]

== General Purpose Register File
The general purpose registers constitute the core of the programmer's model
of PHINIX+. Every operation that manipulates some piece of data has to act
on one of these registers -- address generation, mathematical operations,
memory and peripheral access, to name a few of them. Concretely, 16 of them
are provided, each one being 32 bits in width, denoted #emph[\$gN] (where
N is a single hexadecimal digit ranging from 0 to 9 and then from A to F).

#comment[
	The quantity of general purpose registers PHINIX+ provides, 16, while
	not the most common choice amongst RISC designs (that would be 32), is
	still in line with established ones like RV32E and ARM32.
]

#note[
	It is important to note that the first data register, #emph[\$g0] is not
	actually a register one can write to. Register #emph[\$g0] is a constant
	holding the value zero. This is a nigh universal design pattern across
	the RISC processor family and has been included in PHINIX+ for the same
	reasons.
]

#comment[
	Data register #emph[\$g0] being a constant zero aids in better usage
	of existing instructions (or conversely allows for the reduction of the
	needed instructions) in at least the following two ways:
	-	#[By allowing them to discard their result by storing to this
		register when only the condition code generated from that instruction
		is required. For example, a comparison instruction can be achieved by
		doing a subtraction and storing the result to #emph[\$g0].]
	-	#[The most common operation, either as a standalone instruction or as
		a component in the function of more complex instructions, is addition.
		By having a constant-zero value (the neutral element of addition)
		available all the times allows addition to be effectively bypassed,
		expanding the usage of many instructions. For example, a move
		instruction can be achieved by doing an addition with one of
		the operands being #emph[\$g0].]
]

== Condition Code Register File
The condition code, or "flag" registers exit to hold intermediate
condition codes for the purpose of program control flow (predicated
\/ conditional instructions not just limited to jumps) but they are
also dedicated to doing bit-precise operations. Specifically, 8 of
them are provided, each one being 1 bit in width, denoted #emph[\$cN]
(where N is a single octal digit, ranging from 0 to 7).

#note[
	Unlike with data register #emph[\$g0], condition code register
	#emph[\$c0] does not hold a constant zero value. #footnote[This lack
	is addressed instead through the recommended calling convention provided
	in Volume TODO.] Every register in this register file is accessible.
]

#comment[
	Having a constant zero condition register would reduce the
	needed variants for the instructions that handle them, however
	the importance of 8, and not just 7 available registers was
	important to make the bit-precise operations viable, since a
	byte contains 8 bits.
]

== Special Purpose Registers
Apart from the main set of registers that are grouped into the two register
files that have previously been analyzed, there's a few extra registers not
part of a register file that exist to serve a specific purpose. Their exact
number changes depending on which modules the specific implementation of
PHINIX+ decides to also implement. The complete list is as follows:
-	#[#emph[\$ip] is the address of the currently executing instruction --
	it stands for #emph[Instruction Pointer]. It is automatically incremented
	during the process of instruction fetch, or directly written to by control
	flow instructions. Every implementation has to include this register.]
-	#[#emph[\$jp] stores the return address used when handling interrupts.
	It is only accessible when in privileged mode. It is automatically
	updated to the value of #emph[\$ip] when entering an interrupt. Only
	implementations with the IPM module include this register. #footnote[
	Details on the IPM module are provided in Volume TODO.]]

#comment[
	#emph[\$jp] is called that because it's closely related to
	#emph[\$ip] and the letter J follows the letter I in the alphabet.
]

== Table Summary
After having explained each of the categories, bellow follows a table that
summarizes the complete set of registers that the PHINIX+ architecture
makes available to the programmer.

#figure(grid(columns: 2, gutter: 1em,
	grid.cell(rowspan: 2, table(columns: (50mm),
		table.header([General Purpose Registers]),
		[\$g0], [\$g1], [\$g2], [\$g3], [\$g4], [\$g5], [\$g6], [\$g7],
		[\$g8], [\$g9], [\$gA], [\$gB], [\$gC], [\$gD], [\$gE], [\$gF],
	)),
	table(columns: (50mm),
		table.header([Condition Code Registers]),
		[\$c0], [\$c1], [\$c2], [\$c3], [\$c4], [\$c5], [\$c6], [\$c7],
	),
	table(columns: (50mm),
		table.header([Special Purpose Registers]),
		[\$ip], [\$jp]
	)
), caption: [PHINIX+'s complete set of registers])

]
