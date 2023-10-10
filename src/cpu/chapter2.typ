#import "@preview/tablex:0.0.5": tablex, colspanx, rowspanx

= Instruction Formats
Since data and instructions (the components of code) are free to exist in the same memory space, the instructions have
to be aligned to the size of the data which in this case is 16 bits. Some formats fit instructions in just one word, but
others require an additional immediate value which takes up a second word. In total, there exist 8 distinct formats to
accomodate most instructions' argument needs without having unused operand fields. @instrfmt lists those 8 formats that
all PHINIX+ instructions fit into.

#figure(caption: "PHINIX+'s instruction formats", kind: table, align(center, box(width: 65%, tablex(
	columns: (0.5fr, 1fr, 1fr, 1fr, 1fr, 1fr), stroke: 0.2mm, align: center + horizon,
	fill: (col, row) => if col == 0 or row == 0 {black} else {white},
	[], text(fill: white)[\[15:12\]], text(fill: white)[\[11:8\]],
	text(fill: white)[\[7:4\]], text(fill: white)[\[3:0\]], text(fill: white)[Extd. Imm.],
	text(fill: white)[S], [Opc.\[3:0\]], colspanx(2)[Imm.\[7:0\]], [Dst.], [#emoji.crossmark],
	text(fill: white)[MR], colspanx(2)[Opc.\[7:0\]], [Src.], [Dst.], [#emoji.crossmark],
	text(fill: white)[MR+], colspanx(2)[Opc.\[7:0\]], [Src.], [Dst.], [#emoji.checkmark],
	text(fill: white)[MRI], colspanx(2)[Opc.\[7:0\]], [Imm.\[3:0\]], [Dst.], [#emoji.crossmark],
	text(fill: white)[MI], colspanx(2)[Opc.\[7:0\]], colspanx(2)[Imm.\[7:0\]], [#emoji.crossmark],
	text(fill: white)[LR], colspanx(3)[Opc.\[11:0\]], [Dst.], [#emoji.crossmark],
	text(fill: white)[LR+], colspanx(3)[Opc.\[11:0\]], [Dst.], [#emoji.checkmark],
	text(fill: white)[LI], colspanx(3)[Opc.\[11:0\]], [Imm.\[3:0\]], [#emoji.crossmark],
)))) <instrfmt>

== Instruction Field Nomenclature
The terms used in @instrfmt are explained and expanded upon here:
- *Extd. Imm.* stands for Extended Immediate. It is always 16 bits in length. It takes up an entire second word following after the main word containing a number of fields described below. Depending on the instruction, it may not exist and as a result the space is ocupied by the first word of the next instruction. This is the only aspect of the instructions that is variable-length.
- *Opc.* stands for Operation Code and is between 4 and 12 bits in length. This field identifies which instruction is actually being executed and dictates whether the Extended Immediate is present and in general which of the 8 instruction formats is to be used.
- *Src.* stands for Source and is a register address which is always 4 bits in length. This register is only ever read from during instruction execution. It can indicate a register from either of the two register files, depending on the specific instruction.
- *Dst.* stands for Destination and is also a register address. This register is first read from and then written to at the end of an instruction. It can indicate a register from either of the two register files, depending on the specific instruction.
- *Imm.* stands for Immediate (value) and is between 4 and 8 bits in length. It differs from the Extended Immediate in that it doesn't ocupy a second word but rather uses space available within the first word. 4-bit immediates are referred to as #emph[Short] and 8-bit immediates as #emph[Long].

Additionally, the two numbers in square brackets separated by a colon notation signifies a range of bits within the word.
For example, the notation [3:0] signifies the first 4 bits (bit indecies starting at 0). This notation is part of the
Verilog Hardware Description Language and is used here for parity.

#pagebreak()

== Instruction Format Nomenclature

== Argument Types

- *register*: 
- *short-imm*:
- *long-imm*:
- *extd-imm*:
- *bit*:

== Addressing Modes
- *register*: The effective address is the value of a specified register.
- *base-offset*: The effective address is the value from a specified register plus a 16-bit immediate value.
- *relative*: The effective address is the value of the current instruction pointer plus an 8-bit immediate value.
- *port*: An 8-bit immediate vlaue is used to select a device from the separate I/O address space.

#pagebreak()
