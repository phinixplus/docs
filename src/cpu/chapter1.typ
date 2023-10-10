= Introduction
This document is the official specification for the architecture of the PHINIX+ Central Processing Unit.
It is intended to explain in detail the capabilities and the layout of the processor in an abstract manner
in order to remain agnostic of the possible implementations of it. \

While this document doesn't try to make any assertions of a "correct" sort of implementation, the architecture
was built with the intention to exploit pipelining to gain in performance. As a consequence of this design foresight,
pipelining is partly the namesake of the processor. Specifically, PHINIX+ stands for Pipelined High-speed INteger
Instruction eXecutor. The + is due to this design being an overhauled version of a previous system which never went
much beyond simulation. \

In short, the PHINIX+ processor is inspired by many existing architectures yet it adapts on the features borrowed and
also adds some unique elements. Specifically, it borrows from many RISC architectures including RISC-V and MIPS,
but it also has features seen mostly on CISC processors like x86 and M68k. It is best described as a 16-bit load-store
variable-length 2-op instructions architecture with dual register files and both flagged and flagless condition codes,
operating on a unified word-addressed code+data memory space, often referred to as a Von Neumann architecture.
A rudimentary system for interrupts and a privileged mode are also available. \

PHINIX+ is open source hardware and as such the source for this documentation and for reference implementations are available
under GPLv3 over at the author's #link("https://github.com/martandrMC/cpu-design/tree/main/phinix%2B")[GitHub page]. \

== Glossary
Esoteric terminology or PHINIX+-specific definitions of are listed below:
- *Architecture*: The abstract definition of instructions and registers present in the design.
- *Implementation*: The realisation of the architecture in hardware or software following a defined execution model.
- *Immediate*: A numeric value embedded directly in an instruction.
- *Register*: A small unit of memory inside the processor that is specified by the architecture.
- *Register file*: A grouping of registers with similar purposes that acts as an addressable unit.
- *Word*: One unit of memory in the PHINIX+ architecture, equal to 16 bits.

== Meta Details
This document is my foray into Typst and document preparation in general. If you find any mistakes or want
to provide feedback please visit the project's discord server: #link("https://discord.gg/EFKDF3VE9C")[PHINIX+ Forum].
Additionally, I can not guarantee the same level of formality displayed in other documentation sheets due to my
relative unfamiliarity with the subject. I hope you understand and won't let that aspect detract from the value
of this document.

Styling decisions for this document are the following:
- Normal text is styled using the #emph[Free Serif] typeface.
- Headings are styled using the #emph[DejaVu Sans] typeface in bold. Additionally, top level headings are underlined.
- Internal links (labels) are colored blue without underlining, with the exception of the Contents page.
- External (hyper)links are colored blue and underlined.

#pagebreak()
