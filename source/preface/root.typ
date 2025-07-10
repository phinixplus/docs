#let keywords = (
	"PHINIX+", "Preface",
	"Computer Engineering",
	"Computer Architecture"
)

#import "/source/config.typ": docs-ver
#import "/source/template.typ": template
#show: x => template("Volume 0: Preface", docs-ver, keywords, x)

#import "document.typ": document; #document
#import "author.typ": author; #author
#import "project.typ": project; #project
