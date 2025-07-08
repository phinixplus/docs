#let keywords = (
	"PHINIX+", "Foreword",
	"Computer Engineering",
	"Computer Architecture"
)

#import "/source/template.typ": template
#show: x => template("Volume 0: Foreword", "0.5.0", keywords, x)

#import "document.typ": document; #document
#import "author.typ": author; #author
