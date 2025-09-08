#let document = [

#import "/source/template.typ": typst-link, license-link
#let serif = "https://fonts.google.com/specimen/IBM+Plex+Serif"
#let sans = "https://fonts.google.com/specimen/IBM+Plex+Sabs"
#let mono = "https://fonts.google.com/specimen/Inconsolata"
#let nerd = "https://www.nerdfonts.com/font-downloads"

= About the Documentation
This volume discusses the nature of the documentation itself, the scope and
aim of the PHINIX+ project, and about the author as an individual and their
motives. As a result, the use of the first person in the following chapters is
unavoidable. The formal specification begins at Volume 1 if such details are
irrelevant for the reader.

The purpose of the documentation is to describe all of the features of the
PHINIX+system with maximum possible detail. Therefore, it tries to conform to
the typical requirements expected from technical documentation. The most
important details to be transparent about regarding the documents themselves
are thus the decisions about the look of the documents (styling) and about
the licensing around the documents.

== Styling Decisions
This documentation was written using the "#link(typst-link)[Typst]"
typesetting program. If the source code of the used template is not available
or the reader is not aware of Typst's syntax, the decisions made regarding
styling are hereby given:
-	Pages are A4 sized with 25mm of vertical
	and 20mm of horizontal margins.
-	For the bulk of the text, the serif font
	"#link(serif)[IBM Plex Serif]" was used.
-	For the headings and for the title, the sans serif font
	"#link(sans)[IBM Plex Sans]" was used.
-	For the code blocks the #link(nerd)[Nerd Fonts] variant
	of the monospace font "#link(mono)[Inconsolata]" was used.
-	Internal links (references) are in blue color with the
	exception of the contents page and footnotes.
-	External links (hyperlinks) are underlined and
	in blue color (as shown above).

In addition, the hereby given names for the varying-sized
collections of text have been adopted:
-	*Documentation* refers to the sum of the documents of the work.
-	*Volume* refers to an individual, specific document of the work.
-	*Chapter* refers to a collection of text under
	a first-level heading within a volume.
-	*Section* refers to a collection of text under
	a second-level heading within a chapter.
-	*Subsection* refers to a collection of text under
	a third-level heading within a section.

== Licensing Decisions
This documentation is licensed under the Creative Commons
#link(license-link)[BY-NC-SA 4.0] license. This project is not currently
intended to generate direct profit for the author and/or any other user of the
project, focusing instead on educational and novelty value. If you are making a
derivative of PHINIX+, you are kindly requested to retain this license per the
requirements of the license and attribute the original author. The license only
covers the architecture itself (this documentation) and not any implementations
of the described architecture.

]
