#let preface = [

#import "/source/template.typ": discord-link, license-link
#let serif = "https://fonts.google.com/specimen/IBM+Plex+Serif"
#let sans = "https://fonts.google.com/specimen/IBM+Plex+Sabs"
#let mono = "https://fonts.google.com/specimen/Inconsolata"

= Preface
This section discusses the nature of the documentation itself, the scope and
aim of the PHINIX+ project, and about the author as an individual and their
motives. As a result, the use of the first person in the following section is
unavoidable. The formal specification begins at @Introduction if such details
are irrelevant for the reader.

== About the Document
The purpose of the document is to describe with maximum possible detail all the
features of the PHINIX+ system. It therefore tries to conform to the typical
requirements expected from technical documentation. The most important details
to be transparent about regarding the document itself are thus the decisions
about the look of the document (styling) and about the licensing around the
document.

=== Styling Decisions
This document was written using the "#link("https://typst.app/")[Typst]"
typesetting program. If the source code of the used template is not available
or the reader is not aware of Typst's syntax, the decisions made regarding
styling are hereby given:
 - Pages are A4 sized with 25mm of vertical and 20mm of horizontal margins.
 - For the bulk of the text the serif font
   "#link(serif)[IBM Plex Serif]" was used.
 - For the headings and for the title the sans serif font
   "#link(sans)[IBM Plex Sans]" was used.
 - For the code blocks the monospace font
   "#link(mono)[Inconsolata]" was used.
 - Internal links (references) are in blue color with
   the exception of the contents page and footnotes.
 - External links (hyperlinks) are underlined and
   in blue color (as shown above).

=== Licensing Decisions
This document is licensed under the Creative Commons
#link(license-link)[BY-NC-SA 4.0] license. This project is not currently
intended to generate direct profit for the author and/or any other user of the
project, focusing instead on educational and novelty value. If you are making a
derivative of PHINIX+ you are kindly requested to retain this license per the
requirements of the license and attribute the original author. The license only
covers the architecture itself (this document) and not any implementations of
the described architecture.

== About the Author
Though I do know my way around the field of processor design and implementation,
I have no formal experience with the subject. Everything I know about regarding
the topic I have learned by myself and with help from other people online.
However I am in the process of attending a computer engineering course at a
polytechnic university.

Typesetting is also an activity which I have had to teach myself. My university
did provide me a "Technical Document Writing" lesson though it was in reality
of little help. As a result, if you would like to suggest something regarding
the document don't hesitate to reach out on #link(discord-link)[Discord].

== About the Project
This documentation and the overall design and direction of the PHINIX+ project
is my personal project which I have been working on during my free time. I never
got to experience early computing or the home computer revolution. As a result,
I made it my goal to come up with a completely independent computational system
that would mimic the experience of using systems of the late 1980s to early
1990s.

PHINIX+ attempts to be a platform from which many of the concepts common in
the modern computing environment could be understood (such as Operating Systems)
through re-implementation, as well as a platform on which the retro community
could build upon. PHINIX+ thus tries to cater to many use cases and it should
be wholly up to the implementer which of those use cases is most important for
what they want out of the system.

]
