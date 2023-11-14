= Registers

The first thing that a programmer learns about an architecture, in general, is what registers are exposed for use. The
set of registers that are available is, in a sense, part of the personality of an architecture. That is because registers
are, strictly, per the RISC design pattern, the only medium on which calculations can be done. They can be thought
of as hardware-provided variables. \

PHINIX+'s registers are, at first glance, unconventional though their layout borrows from the M68k which also had
two register files, one for data referred to as Dx and one for addresses (pointers) referred to as Ax. In our case, Dx
corresponds with the primary register file displayed in @primreg and Ax with the secondary in @secdreg. There also
exist a few special-purpose registers, in addition to the two register files, displayed in @specreg, whose functions will
be explained on a case-by-case basis. \

== General-Purpose Registers

The primary and secondary register files have no restrictions by the hardware on how they are used, with the exception
of \$x0 which reads always as 0 and discards writes, and of \$yC-\$yF which are reseved for system software and are
unavailable if the system implements and is in user mode. Each instruction can access at most two registers, each
from either register file. Writing back to both registers is allowed only when they originated from different register
files. In other words, each register file concurrently and independantly allows two reads and one write per instruction.
All of the general-purpose registers are 16 bits. \

#columns(2)[

#figure(caption: "PHINIX+'s primary register file", align(center, table(
	columns: (1fr, 1fr, 4fr, 2fr), stroke: 0.2mm,
	fill: (_, row) => if row == 0 {black} else {white},
	text(fill: white)[*Arch.*],
	text(fill: white)[*Conv.*],
	text(fill: white)[*Description*],
	text(fill: white)[*Save?*],
	[\$x0], [\$zr], [Constant Zero], [None],
	[\$x1], [\$at], [Assembler Temporary], [Caller],
	[\$x2], [\$rp], [Return Pointer], [Caller],
	[\$x3], [\$a0], [Arg./Return Value \#0], [Caller],
	[\$x4], [\$a1], [Arg./Return Value \#1], [Caller],
	[\$x5], [\$a2], [Arg./Return Value \#2], [Caller],
	[\$x6], [\$t0], [Temporary Value \#0], [Caller],
	[\$x7], [\$t1], [Temporary Value \#1], [Caller],
	[\$x8], [\$t2], [Temporary Value \#2], [Caller],
	[\$x9], [\$s0], [Saved Value \#0], [Callee],
	[\$xA], [\$s1], [Saved Value \#1], [Callee],
	[\$xB], [\$s2], [Saved Value \#2], [Callee],
	[\$xC], [\$s3], [Saved Value \#3], [Callee],
	[\$xD], [\$s4], [Saved Value \#4], [Callee],
	[\$xE], [\$s5], [Saved Value \#5], [Callee],
	[\$xF], [\$fp], [Frame Pointer], [Callee],
))) <primreg>

#colbreak()

#figure(caption: "PHINIX+'s secondary register file", align(center, table(
	columns: (1fr, 1fr, 4fr, 2fr), stroke: 0.2mm,
	fill: (_, row) => if row == 0 {black} else {white},
	text(fill: white)[*Arch.*],
	text(fill: white)[*Conv.*],
	text(fill: white)[*Description*],
	text(fill: white)[*Save?*],
	[\$y0], [\$t3], [Temporary Value \#3], [Caller],
	[\$y1], [\$t4], [Temporary Value \#4], [Caller],
	[\$y2], [\$t5], [Temporary Value \#5], [Caller],
	[\$y3], [\$a3], [Arg./Return Value \#3], [Caller],
	[\$y4], [\$a4], [Arg./Return Value \#4], [Caller],
	[\$y5], [\$a5], [Arg./Return Value \#5], [Caller],
	[\$y6], [\$s6], [Saved Value \#6], [Callee],
	[\$y7], [\$s7], [Saved Value \#7], [Callee],
	[\$y8], [\$s8], [Saved Value \#8], [Callee],
	[\$y9], [\$s9], [Saved Value \#9], [Callee],
	[\$yA], [\$gp], [Global Pointer], [Callee],
	[\$yB], [\$sp], [User Stack Pointer], [Callee],
	[\$yC], [\$k0], [System Value \#0], [Callee],
	[\$yD], [\$k1], [System Value \#1], [Callee],
	[\$yE], [\$k2], [System Value \#2], [Callee],
	[\$yF], [\$kp], [System Stack Pointer], [Callee],
))) <secdreg>

]

#pagebreak()

== Special-Purpose Registers

The special-purpose registers, by their name, have more narrow use-cases. Each one serves different functionality
and has unique accompanying instructions that operate on it. All of the special-purpose registers are also 16 bits.

#figure(caption: "PHINIX+'s special-purpose registers", align(center, box(width: 50%, table(
	columns: (1fr, 4fr, 2fr), stroke: 0.2mm,
	fill: (_, row) => if row == 0 {black} else {white},
	text(fill: white)[*Arch.*],
	text(fill: white)[*Description*],
	text(fill: white)[*Save?*],
	[\$ip], [Instruction Pointer], [None],
	[\$jp], [Interrupt Return Pointer], [None],
	[\$rf], [Reference Register], [Caller],
	[\$st], [Status Register], [Caller],
)))) <specreg>

A description of each of the registers is given here:
- *\$ip*: The instruction pointer; a register containing the address of the currently executing instruction.
- *\$jp*: The alternate instruction pointer or interrupt return pointer; in which the main one is saved when it's time to service an interrupt. This is required because, when exiting the interrupt handler, none of the other registers may have modified values (due to the interrupt's need to be transparent to user code) which leaves the need for a dedicated register to contain the return address. As a result, this register is also inaccessible from user mode code due to its volatility.
- *\$rf*: The reference register; having a dual purpose, can either be used to contain a reference value to compare against using special condition codes, or be used as a vector of 16 1-bit accumulators to do bit math either on condition codes to create more compound ones or on user-provided values. This is one of the most innovative features of PHINIX+.
- *\$st*: The status register; contains the four operation flags (NVCZ) generated after most calculations, software interrupt trigger bits, and general-purpose input/output bits intended to be used as status information to the outside world (eg. panel lights).

== The Standard Register Convention

#emph[Soon#emoji.tm]

#pagebreak()
