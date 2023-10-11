#import "@preview/tablex:0.0.5": tablex, colspanx, rowspanx

= Instruction Formats
Since data and instructions (the components of code) are free to exist in the same memory space, the instructions have
to be aligned to the size of the data which in this case is 16 bits. Some formats fit instructions in just one word, but
others require an additional immediate value which takes up a second word. In total, there exist 8 distinct formats to
accomodate most instructions' argument needs without having unused operand fields. @instrfmt lists those 8 formats that
all PHINIX+ instructions fit into.

#figure(caption: "PHINIX+'s instruction formats", kind: table, align(center, box(width: 65%, tablex(
	columns: (1fr, 2fr, 2fr, 2fr, 2fr, 2fr), stroke: 0.2mm, align: center + horizon,
	fill: (col, row) => if col == 0 or row == 0 {black} else {white},
	[], text(fill: white)[*\[15:12\]*], text(fill: white)[*\[11:8\]*],
	text(fill: white)[*\[7:4\]*], text(fill: white)[*\[3:0\]*], text(fill: white)[*Extd. Imm.*],
	text(fill: white)[*S*], [Opc.\[3:0\]], colspanx(2)[Imm.\[7:0\]], [Dst.], [#emoji.crossmark],
	text(fill: white)[*MR*], colspanx(2)[Opc.\[7:0\]], [Src.], [Dst.], [#emoji.crossmark],
	text(fill: white)[*MR+*], colspanx(2)[Opc.\[7:0\]], [Src.], [Dst.], [#emoji.checkmark],
	text(fill: white)[*MRI*], colspanx(2)[Opc.\[7:0\]], [Imm.\[3:0\]], [Dst.], [#emoji.crossmark],
	text(fill: white)[*MI*], colspanx(2)[Opc.\[7:0\]], colspanx(2)[Imm.\[7:0\]], [#emoji.crossmark],
	text(fill: white)[*LR*], colspanx(3)[Opc.\[11:0\]], [Dst.], [#emoji.crossmark],
	text(fill: white)[*LR+*], colspanx(3)[Opc.\[11:0\]], [Dst.], [#emoji.checkmark],
	text(fill: white)[*LI*], colspanx(3)[Opc.\[11:0\]], [Imm.\[3:0\]], [#emoji.crossmark],
)))) <instrfmt>

== Instruction Field Nomenclature
The terms used in @instrfmt are explained and expanded upon here:
- *Extd. Imm.* stands for #emph[Extended Immediate]. It is always 16 bits in length. It takes up an entire second word following after the main word containing a number of fields described below. Depending on the instruction, it may not exist and as a result the space is ocupied by the first word of the next instruction. This is the only aspect of the instructions that is variable-length.
- *Opc.* stands for #emph[Operation Code] and is between 4 and 12 bits in length. This field identifies which instruction is actually being executed and dictates whether the Extended Immediate is present and in general which of the 8 instruction formats is to be used.
- *Src.* stands for #emph[Source] and is a register address which is always 4 bits in length. This register is only ever read from during instruction execution. It can indicate a register from either of the two register files, depending on the specific instruction.
- *Dst.* stands for #emph[Destination] and is also a register address. This register is first read from and then written to at the end of an instruction. It can indicate a register from either of the two register files, depending on the specific instruction.
- *Imm.* stands for #emph[Immediate] (value) and is between 4 and 8 bits in length. It differs from the Extended Immediate in that it doesn't ocupy a second word but rather uses space available within the first word. 4-bit immediates are referred to as #emph[Short] and 8-bit immediates as #emph[Long].

Additionally, the two numbers in square brackets separated by a colon notation signifies a range of bits within the word.
For example, the notation [3:0] signifies the first 4 bits (bit indecies starting at 0). This notation is part of the
Verilog Hardware Description Language and is used here for parity.

#pagebreak()

== Instruction Format Nomenclature
Each instruction format has its own name, as seen in column 1 of @instrfmt. Those names are not given randomly but are
instead based on the layout of the format itself. There are three parts that come together to form a name. The first indicates
the size of the operation code using the letters S, M, and L for #emph[Small] (4-bit), #emph[Medium] (8-bit), and #emph[Large]
(12-bit) respectively. The second part indicates the type of operands present. There are thee variants, R, I, and RI. R stands
for #emph[Register] and I stands for #emph[Immediate]. Lastly, the third part indicates the presence of a second word in the
instruction using the symbol +. \

It is important to point out that for small operation code formats, 12 bits are available for operands, for medium operation
code formats 8 bits are available, and for long operation code formats only 4 bits are available. This restriction affects how
the formats are named due to the inherent restrictions of each format. \

Now that each component is explained, each format's name will be broken down individually:
- *S*: No other layout information needed for this one since it's the only one with a small operation code.
- *MR*: Medium operation code with two registers as operands.
- *MR+*: Same as the above but extended with an immediate value word (16 bits).
- *MRI*: Medium operation code with one register and one immediate (4 bits) as operands.
- *MI*: Medium operation code with one immediate (8 bits) as operand.
- *LR*: Long operation code with one register as operand.
- *LR+*: Same as the above but extended with an immediate value word (16 bits).
- *LI*: Long operation code with one immediate (4 bits) as operand.

== Operand Types
As it may be apparent by this point, instructions, broadly, have two options for their operands. They can either take the value
off of a register after addressing a register file or embed the needed value directly into the instruction using immediates of
varying sizes. But that only covers the explicit operands. There are certain instructions that use implicit operands such as
constant values or registers outside of a register file for which there exists no address and thus its access must be indicated
by the operation code itself. Furthermore, each can be used for a variety of ways, or combined together to form more complex
behaviours. The ways each type of operand is used will be listed below starting with individual applications and then following
with combined ones.

The four different types of explicit operands are thus the following:
- *reg*: A 4-bit register address.
- *imm4*: A 4-bit immediate value.
- *imm8*: An 8-bit immediate value.
- *imm16*: A 16-bit immediate value.

#pagebreak()
