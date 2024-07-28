#import "/source/template.typ": template
#show: x => template("Part 1: The CPU", "0.0.2", x)

= Heading
#lorem(50)

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
