#let intro = [

= Introduction <heading-introduction>
This document is the official specification for the PHINIX+ Central Processing
Unit. It is intended to explain in detail the capabilities and the layout of
the processor in an abstract manner in order to remain agnostic of the possible
implementations of it. While this document doesn't try to make any assertions
of a “correct” sort of implementation, the architecture was built with the
intention to exploit pipelining to gain in performance.

== Ancestral History
PHINIX+ is a "constructed" acronym which stands for _Pipelined High-speed
INteger Instruction eXecutor_. The "+" in the name is meant to signify
advancements from a previously designed processor, PHINIX, from which most ideas
were directly taken and improved upon. PHINIX used 16-bit word-addressing, which
turned out to be unwieldy and did not deliver in terms of memory capacity.
PHINIX+ expands to 32 bits while also adding byte-addressing to simplify
integration with the existing computing paradigms, all based around 8-bit units.

== Influence Sources
PHINIX+ mainly derives from the _Reduced Instruction Set Computing_ (RISC)
paradigm. However, that does not mean it follows the established norm for a RISC
processor, opting instead for a more expansive set of instructions, mainly
concerning the improvement of flags management and bit math. The core principles
of RISC, like the load-store paradigm and the general usage nature of the
provided registers, do exist in PHINIX+ but not without being improved upon.

One of the most apparent features a programmer wishing to use PHINIX+ encounters
is the dual register file. This is a feature influenced directly by the Motorola
68000 series of processors. Though that processor was in no way following RISC,
the adoption of the dual register file was due to similar reasons. As a
result, PHINIX+ has been lovingly nicknamed the _Actually-RISC#emoji.tm m68k_
#footnote[Disclaimer, not actually a trademark.].

== Things Done Differently
As mentioned prior, PHINIX+ mostly follows RISC but has changed how a few
things work in the interest of exploration. Many of the decisions taken could be
considered "unorthodox", but one of the most important premises of this project
is to try new ways of doing things for the educational value. Great care has
been taken to devise methods that improve performance using the minimum amount
of required hardware. Following is a list of the most important novel features
of the CPU:

#show table.cell: set align(center + horizon)
#figure(table(columns: (1fr, 2fr),
	table.header([Feature], [Justification]),
	[Dual register files. #footnote[As mentioned prior in relation to the m68k.]
	(The separation of the registers into data and address register files.)],
	[Allows for a trivial auto-increment operation, removing the need for
	special hardware for the stack and other pointers. This feature also allows
	for two independent operations to be executed in parallel with little
	increase to the size of the implementation.],

	[Condition codes register file. (The ability to use any
	single-bit "flag" for any purpose.)],
	[Makes operations on them a feasible prospect, reducing the amount of
	branches. The now explicit nature of flag operations makes each instruction
	wishing to modify them now opt-in instead of opt-out, reducing flag use.],

	[Load-store instruction byte permutations. (The ability to choose a
	preferred ordering for the bytes when loading or storing them.)],
	[Addresses the age-old dilemma of little- VS big-endian while both making
	the least significant bits of an address useful and eliminating the need
	for bus errors, but doing so without requiring the system to perform
	unaligned memory accesses.]
), caption: [Notable novel features of PHINIX+]) <table-novelfeatures>

]
