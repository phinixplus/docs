#import "/source/template.typ": template
#show: x => template("Part 1: The CPU", "α.1", "July 2024", x)

= Heading
#lorem(50)
== Heading
#lorem(20)
== Heading
#lorem(20)
=== Heading
#lorem(20)

#line()

= Heading
#lorem(50)

#import "/source/utilities.typ": code
#code("/source/utilities.typ", "typst")