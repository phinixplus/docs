#let regfile = [

#import "/source/utilities.typ": note, comment

= Register Files
A register file is a grouping of individually addressable memory cells, also
known as registers, that are closely coupled with the operation and structure
of a processor architecture. PHINIX+ defines three of these register files,
each with a slightly different purpose. The first two of the novel features
outlined in @table-novelfeatures are thus explained in detail in this chapter.

#note[
	Registers are the most common subjects (also referred to as operands) of
	the instructions a CPU executes, especially if it follows the load-store
	paradigm wherein, as a consequence, no arithmetic/logic instruction can
	directly operate on memory.
]

== General Purpose Registers
The general purpose registers are a pair of register files, each file aimed
towards a narrower set of use cases. This is the first novel feature of
PHINIX+, initially noted in the first entry of @table-novelfeatures. Each file
consists of 16 registers for a total of 32 registers. The two register files
are to be detailed in the following two subsections and an extra subsection
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
N, a single hexadecimal digit ranging from 0 to 9 and then from A to F).
They are intended to store values loaded from or to be stored to memory and
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
		doing a subtraction and storing the result to register zero.]
	-	#[By allowing instructions that address memory to coalesce under a
		single addressing mode, "reg + imm". This is such because when
		supplying #emph[\$x0] as the register, the effective address becomes
		just the immediate, and by supplying a zero immediate the effective
		address becomes the supplied register. #footnote[Addressing modes as
		they relate to PHINIX+ are discussed in TODO.]]
]

=== Address Registers
The address registers are a secondary set of registers that are less versatile
computation-wise than the data registers. Just like the data registers, 16 are
provided, again each one being 32 bits in width, denoted instead #emph[\$yN]
(where N, a single hexadecimal digit, ranging from 0 to 9 and then from A to F).

While still having more available functionality than for just storing and
manipulating pointers, the address registers' primary purpose is nevertheless
for the aforementioned task or as a bank of secondary storage when the data
registers are not enough to hold all datums of a computation.

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
registers each one only 1 bit in width. Their purpose is, as the name suggests,
to hold intermediate condition codes for the purpose of program control flow.
Branch instructions which are later discussed are intimately tied with this set
of registers. #footnote[Branch instructions and how they relate to the condition
code registers are discussed in TODO.] This is the second novel feature of
PHINIX+, initially noted in the second entry of @table-novelfeatures. They are
denoted #emph[\$cN] (where N, a single octal digit, ranging from 0 to 7).

#figure(table(columns: 1,
	table.header([Condition Code Registers]),
	[\$c0], [\$c1], [\$c2], [\$c3], [\$c4], [\$c5], [\$c6], [\$c7],
), caption: [PHINIX+'s condition code registers]) <table-condregs>

#comment[
	Condition code register #emph[\$c0] is a register that constantly and
	forever holds a zero bit. This simplifies the logic needed to handle
	a cascading set of conditions and reduces the amount of instructions
	required to handle all the needed cases.
]

== Register Calling Convention
The tables of registers previously showcased contained just one column which
lists the "architectural names" of the registers which denotes the systematic
name given to the register for the purposes of a hardware point-of-view. An
implementer doesn't care how the registers are used because they are all generic
so they get generic architectural names.

In this section the registers are re-examined, this time concerning a software
point-of-view instead. In contrast with the implementer, a programmer needs to
organize the registers given to them in a consistent manner in order to ensure
proper behavior when calling into subroutines, thus a #emph[convention] for
#emph[calling], a pre-agreed set of rules to ensure compatibility between
interacting subroutines.

To assist in this endeavour this document provides a reference, standard calling
convention that any software written for the processor is advised to use such
that software written by different developers can interoperate. A calling
convention's whole purpose is to provide a common ground for software
development, so that someones's code is able to use someone else's.

#comment[
	Developers are free to come up with an alternative convention to better
	suit their needs, it just then falls unto them to interface with other
	existing software which is not compatible with their custom convention.
]

=== The Concept of Saving
In the act of a subroutine call, there are two hypothetical entities at play:
the code performing the call--referred to as the caller, and the code being
called--referred to as the callee. Using these roles as a framework for a
calling convention yields the simplest form of segregation based on whose duty
it is to "clean up" the register, revert its contents to a known-good state.
Thus each register can be assigned to either be saved by the caller or by the
callee. The PHINIX+ calling convention bases its design on this principle.

In practice, what it means for a register to be caller-saved is that the code
being called has no obligation to maintain the contents of the register to
its initial value. After the subroutine returns the caller has to assume that
all of the caller-saved registers now contain garbage values. Thus it's the
duty of the caller to preserve the values of registers it wants to continue
using after the subroutine call.

#comment[
	There are mainly two ways the caller can preserve the value of
	caller-saved register that it wants to keep using after the subroutine
	return. Those are:
	-	#[Exploiting the stack by pushing the value of the register
		onto its stack frame. #footnote[The stack is a concept that is
		explained in detail in TODO.] <footnote-stack>]
	-	#[Moving the value of the register onto another, callee-saved
		register that had previously been saved itself.]
]

Likewise, what it means in practice for a register to be callee-saved is that
the code doing the call expects that the value of that register remains the same
after the return of the subroutine without it having to do anything. Thus it's
the duty of the code being called, the callee, to preserve the value in some
way before using it and then revert the register to the old value before
returning.

#comment[
	There are, agin, mainly two ways the callee can preserve the value of
	callee-saved register that it later intends to use. Those are:
	-	#[Exploiting the stack by pushing the value of the register
		onto its stack frame. #footnote(<footnote-stack>)]
	-	#[Moving the value of the register onto another, caller-saved register.]
]

=== Convention Tables Glossary <blah>
The three tables to follow, @table-dataregs-conv, @table-addrregs-conv, and
@table-condregs-conv, contain a compact description of how they are intended
to be used by the software developer. The terms used in these tables are hereby
explained.

The headers of the tables contain these four entries with the exception of the
condition code registers table which contains only the first and last entries:
-	#[#emph[Architectural Name] is the one column of the original table.]
-	#[#emph[Convention Name] lists out the name that a programmer will use
	inside their aseembly language development environment to refer to the
	specific register. It is an abbreviated form of the register's intended
	purpose.]
-	#[#emph[Description] expands on the #emph[Convention Name] by listing out
	in full the intended purpose of the specific register. Not every register
	has a unique purpose so smaller groupings of registers with a common purpose
	are additionally numbered.]
-	#[#emph[Saving] lists out the assigned saving of the specific register,
	either caller-save or callee-save (in the cases where it applies to do so).
	The implications for each of the two savings are explained in the previous
	sub-section.]

=== Data Register Convention
The following table is an expanded version of the before shown table of data
registers (left half of @table-generalregs). Three additional columns have been
added to detail the proposed standard calling convention for the data register
file.

#figure(table(columns: 4,
	table.header([Architectural Name], [Convention Name], [Description], [Saving]),
	[\$x0], [\$zr], [Constant Zero], [N/A],
	[\$x1], [\$at], [Assembler Temporary], [Caller],
	[\$x2], [\$rp], [Return Pointer], [Caller],
	[\$x3], [\$t0], [Temporary Value \#0], [Caller],
	[\$x4], [\$t1], [Temporary Value \#1], [Caller],
	[\$x5], [\$t2], [Temporary Value \#2], [Caller],
	[\$x6], [\$a0], [Subroutine Argument \#0], [Caller],
	[\$x7], [\$a1], [Subroutine Argument \#1], [Caller],
	[\$x8], [\$a2], [Subroutine Argument \#2], [Caller],
	[\$x9], [\$s0], [Saved Value \#0], [Callee],
	[\$xA], [\$s1], [Saved Value \#1], [Callee],
	[\$xB], [\$s2], [Saved Value \#2], [Callee],
	[\$xC], [\$s3], [Saved Value \#3], [Callee],
	[\$xD], [\$s4], [Saved Value \#4], [Callee],
	[\$xE], [\$s5], [Saved Value \#5], [Callee],
	[\$xF], [\$fp], [Frame Pointer], [Callee]
), caption: [PHINIX+'s data registers]) <table-dataregs-conv>

=== Address Register Convention
The following table is an expanded version of the before shown table of address
registers (right half of @table-generalregs). Three additional columns have been
added to detail the proposed standard calling convention for the address
register file in the same manner as before.

#figure(table(columns: 4,
	table.header([Architectural Name], [Convention Name], [Description], [Saving]),
	[\$y0], [\$a3], [Subroutine Argument \#3], [Caller],
	[\$y1], [\$a4], [Subroutine Argument \#4], [Caller],
	[\$y2], [\$a5], [Subroutine Argument \#5], [Caller],
	[\$y3], [\$t3], [Temporary Value \#3], [Caller],
	[\$y4], [\$t4], [Temporary Value \#4], [Caller],
	[\$y5], [\$t5], [Temporary Value \#5], [Caller],
	[\$y6], [\$t6], [Temporary Value \#6], [Caller],
	[\$y7], [\$t7], [Temporary Value \#7], [Caller],
	[\$y8], [\$s6], [Saved Value \#6], [Callee],
	[\$y9], [\$s7], [Saved Value \#7], [Callee],
	[\$yA], [\$gp], [Globals Pointer], [Callee],
	[\$yB], [\$sp], [User Stack Pointer], [Callee],
	[\$yC], [\$k0], [System Reserved \#0], [Callee],
	[\$yD], [\$k1], [System Reserved \#1], [Callee],
	[\$yE], [\$k2], [System Reserved \#2], [Callee],
	[\$yF], [\$kp], [System Stack Pointer], [Callee]
), caption: [PHINIX+'s address registers]) <table-addrregs-conv>

#note[
	The last four registers in the address register file are "privileged".
	That means that they are accessible only when the processor is in a special
	mode of operation reserved for managerial code like an operating system's
	kernel. #footnote[PHINIX+'s privileged execution mode is explained in detail
	in TODO.] When not in this mode, the registers act nominally the same as the
	data register #emph[\$zr]. An implementer may however choose to have the
	processor react on such a violating access by alerting the privileged code
	of such an action. #footnote[Such an alert would constitute an interrupt.
	Interrupts are explained in detail in TODO.]
]

=== Condition Code Register Convention
The following table is an expanded version of the before shown table of
condition code registers (@table-condregs). Only one additional column has been
added to detail the proposed standard calling convention for the condition code
register file. Only a saving convention has been assigned to this file in
contrast to the other two due the nature of the file. All of the registers
are in the same and only grouping with callee saving.

#figure(table(columns: 2,
	table.header([Architectural Name], [Saving]),
	[\$c0], [N/A],
	[\$c1], [Callee],
	[\$c2], [Callee],
	[\$c3], [Callee],
	[\$c4], [Callee],
	[\$c5], [Callee],
	[\$c6], [Callee],
	[\$c7], [Callee]
), caption: [PHINIX+'s condition code registers]) <table-condregs-conv>

#comment[
	Having eight condition code registers, each one being 1 bit in width means
	that saving and restoring the contents can be done in one fell swoop. The
	entire register file's contents can fit into a single byte. To aid in this
	mechanic, all of the registers have the same saving (with the exception of
	#emph[\$c0], on which saving is not applicable due to its constant nature).
]

]
