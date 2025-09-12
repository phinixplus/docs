#let formats = [

#import "/source/gadgets.typ": comment, note
#import "/source/gadgets.typ": layout-wgil, layout-wggih, layout-wcgih
#import "/source/gadgets.typ": layout-w3gib, layout-wcggib, layout-wcc3g

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
	use as an operand for the operation or to which a result will be put.
	Since they have to address either a general purpose register or a
	condition code register, they are either 4 or 3 bits in size,
	respectively.

-	#emph[Immediate value] fields, used to directly supply a value (of a
	limited numeric range) to use as an operand for the operation. Much
	variation in the size of these fields is required in order to provide
	maximum versatility with the limited space. As a result, immediate
	value fields exist with sizes of 8, 16, or 20 bits.

#note[
	A negation selector control field always accompanies a condition code
	register address field, and so the pair is 4 bits in size overall. This
	was a strategic choice such that every component of the formats is a
	multiple of 4 bits in size, making it viable for a human to read machine
	code in hexadecimal format.
]

== Format Nomenclature
Each of the formats has been given a shorthand name derived from its
features. This name is split into four sections, each encoding a specific
feature of the format, in terms of what fields it includes.
+	The first can either be `W` or `H`, signifying the total size of the
	instruction, which can be 32 (word) or 16 (half) bits respectively.

+	Afterwards comes the specifier for the amount of condition code register
	address fields that the format carries. For each one, a `C` is placed in
	the name. In practice the amount ranges from zero up to two fields.

+	Next comes the specifier for the amount of general purpose register
	address fields. For each one, a `G` is placed in the name. However if
	the amount is more than two, use a digit to prefix the letter instead.
	In practice the amount ranges from zero up to three fields.

+	Lastly comes the, also optional, specifier for the immediate value field.
	If it is present, an `I` is placed in the name, and then an `L`, `H`, `B`,
	or `S` to signify the size of the immediate value, which can be 20 (long),
	16 (half), 8 (byte), or 4 (small) bits in length, respectively.

#comment[
	As a regular expression, the above rules would be:
	`[WH](C?C?)(G|GG|3G)?(I[LHBS])?`
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

#layout-wgil()
#layout-wggih()
#layout-wcgih()
#layout-w3gib()
#layout-wcggib()
#layout-wcc3g()

]
