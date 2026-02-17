#let formats = [

#import "/source/gadgets.typ": comment, note, layout
#import "/source/config.typ": ifmt-opc-color, ifmt-aux-color
#import "/source/config.typ": ifmt-reg-color, ifmt-imm-color

= Instruction Formats
Instructions are the set of fundamental operations the hardware itself
supports. They, along with the register file, are the two most important
things for a specification to cover, since they are the majority of what
defines the capabilities, scope and quirks of the architecture. However,
to best align with the RISC paradigm, each instruction has to fit into
one of the defined instruction formats; the topic of this chapter.

#comment[
	The reasoning behind the inclusion of instruction formats is quite
	simple yet impactful. The benefits of constraining the capabilities
	of the instructions to fit into the available formats outweighs that
	constraint. Most key are the following principles:
	-	Simplification of the architecture and
		implementations as per RISC principles
	-	Organization of the instructions into
		groups of similar-acting ones
	-	Orthogonality -- the principle of
		operand source indifference
]

== Format Composition
Instruction formats are a set of pre-defined layouts consisting of various
arrangements of fields that each instruction gets to use in a similar but
unique way to do its task. There exist three different types of fields
across all the defined formats that PHINIX+ uses, those being:
-	#emph[Control] fields, used for identifying the specific operation that
	is being requested. There are a few sub-types of control fields, each
	with a different size. Namely, there are #emph[operation code] fields
	with a size of 8 bits, #emph[function] fields with a size of 4 bits,
	and #emph[negation selector] fields with a size of 1 bit.

-	#emph[Register address] fields, used for selecting a specific register
	from a (predetermined by a control field) register file whose value to
	use as an operand for the operation (source) or to which a result will
	be put (destination). Since they have to address either a general
	purpose register or a condition code register, they are either 4 or 3
	bits in size, respectively.

-	#emph[Immediate value] fields, used to directly supply a value (of a
	limited numeric range) to use as an operand for the operation. Much
	variation in the size of these fields is required in order to provide
	maximum versatility with the limited space. As a result, immediate
	value fields exist with sizes of 4, 8, 16, or 20 bits.

#note[
	A negation selector control field always accompanies a condition code
	register address field, and so the pair is 4 bits in size overall. The
	purpose of the negation selector is to optionally invert the flag
	involved with the associated register.
]

#comment[
	It was a strategic choice that every component of the formats is a
	multiple of 4 bits in size, making it viable for a human to read
	machine code in hexadecimal format.
]

== Format Nomenclature
Each of the formats has been given a shorthand name derived from its
features. This name is split into four parts, each encoding a specific
feature of the format, in terms of what fields it includes.
+	First there's a `W` or an `H` to signify the total size of the
	instruction, 32 and 16 bits respectively. #footnote[While not
	in the base instruction set, reservations exist for half-width
	"compressed" instruction formats.]

+	Afterwards appears a `C` for each of the zero to two condition
	code register address fields.

+	Next appears a `G` for each of the zero to three general purpose
	register address fields. In the case of three, the count (only `3`
	in this case) prefixes the symbol instead of it being repeated.

+	Lastly, in formats including an immediate, comes an `I` and then
	either an `S`, a `B`, an `H`, or an `L`, corresponding to one of
	the aforementioned respective sizes.
	#footnote[One of those reservations for half-width
	instructions being the 4-bit "small" immediate.]

#comment[
	As a regular expression, the above rules would be:
	`[WH](C?C?)(G|GG|3G)?(I[SBHL])?`
]

== Format Labeling
In the instruction format illustrations that follow, each field will also
contain a label to identify itself and so that in the next chapter about
the list of instructions themselves they can be given meaningful names.
-	Immediate value fields are labeled as `immN` where `N` is the total
	length of the field. Optionally, if the field is split up, there will
	follow a range tag in the form of `[H:L]` where `H` and `L` are the high
	and low indices respectively for the part of the field this section
	contains.

-	Register address fields are more varied. They can either be labeled as
	`src`, which means this address is only used to read from a register
	(source), or as `tgt`, which means this address can be used for both
	reading from and writing to a register (target). Then follows either
	`.g` for general purpose register address fields or `.c` for condition
	code ones. Finally there may be a number to differentiate multiple
	instances.

-	Control fields are much simpler since there's only the three aforementioned
	sub-types. Operation code fields are labeled `opcode`, function fields are
	labeled `funct`, and negation selector fields are labeled either `nt` or
	`ns` depending whether their companion register address field is either a
	target or a source address, respectively.

#comment[
	Immediate value fields get split up and shuffled around and thus require
	range specifiers in their labeling because an attempt was made to maximize
	the overlap between different formats. Specifically, the field is split
	byte-wise and then reversed, so that bigger versions of the field overlap
	their low parts with the smaller versions and thus hardware requirements
	are reduced.
]

== The List
Having covered the composition and nomenclature behind the instruction formats,
the list of instruction formats that PHINIX+ actually includes are shown in
this section. There exist a total of six of them, accommodating the whole
spectrum of needs, from those that require just register address fields to
those that require just one big immediate value field.

#note[
	Each field has been color-coded for ease of pattern recognition.
	Specifically, control fields are colored red or teal, register
	address fields are colored green, and immediate value fields are
	colored yellow.
]

#layout(name: "WGIL",
	(bits: 8, color: ifmt-imm-color, label: "imm20[7:0]"),
	(bits: 8, color: ifmt-imm-color, label: "imm20[15:8]"),
	(bits: 4, color: ifmt-imm-color, label: "imm20[19:16]"),
	(bits: 4, color: ifmt-reg-color, label: "tgt.g"),
	(bits: 8, color: ifmt-opc-color, label: "opcode")
)

#layout(name: "WGGIH",
	(bits: 8, color: ifmt-imm-color, label: "imm16[7:0]"),
	(bits: 8, color: ifmt-imm-color, label: "imm16[15:8]"),
	(bits: 4, color: ifmt-reg-color, label: "src.g"),
	(bits: 4, color: ifmt-reg-color, label: "tgt.g"),
	(bits: 8, color: ifmt-opc-color, label: "opcode")
)

#layout(name: "WCGIH",
	(bits: 8, color: ifmt-imm-color, label: "imm16[7:0]"),
	(bits: 8, color: ifmt-imm-color, label: "imm16[15:8]"),
	(bits: 1, color: ifmt-aux-color, label: "nt"),
	(bits: 3, color: ifmt-reg-color, label: "tgt.c"),
	(bits: 4, color: ifmt-reg-color, label: "tgt.g"),
	(bits: 8, color: ifmt-opc-color, label: "opcode")
)

#layout(name: "W3GIB",
	(bits: 8, color: ifmt-imm-color, label: "imm8"),
	(bits: 4, color: ifmt-reg-color, label: "src.g2"),
	(bits: 4, color: ifmt-opc-color, label: "funct"),
	(bits: 4, color: ifmt-reg-color, label: "src.g1"),
	(bits: 4, color: ifmt-reg-color, label: "dst.g"),
	(bits: 8, color: ifmt-opc-color, label: "opcode")
)

#layout(name: "WCGGIB",
	(bits: 8, color: ifmt-imm-color, label: "imm8"),
	(bits: 4, color: ifmt-reg-color, label: "src.g"),
	(bits: 4, color: ifmt-opc-color, label: "funct"),
	(bits: 1, color: ifmt-aux-color, label: "nt"),
	(bits: 3, color: ifmt-reg-color, label: "tgt.c"),
	(bits: 4, color: ifmt-reg-color, label: "dst.g"),
	(bits: 8, color: ifmt-opc-color, label: "opcode")
)

#layout(name: "WCC3G",
	(bits: 1, color: ifmt-aux-color, label: "nt"),
	(bits: 3, color: ifmt-reg-color, label: "tgt.c"),
	(bits: 1, color: ifmt-aux-color, label: "ns"),
	(bits: 3, color: ifmt-reg-color, label: "src.c"),
	(bits: 4, color: ifmt-reg-color, label: "src.g2"),
	(bits: 4, color: ifmt-opc-color, label: "funct"),
	(bits: 4, color: ifmt-reg-color, label: "src.g1"),
	(bits: 4, color: ifmt-reg-color, label: "dst.g"),
	(bits: 8, color: ifmt-opc-color, label: "opcode")
)

]
