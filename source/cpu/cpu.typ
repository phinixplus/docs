#let keywords = (
	"PHINIX+", "CPU",
	"Instruction Set",
	"Computer Engineering",
	"Computer Architecture"
)

#import "/source/template.typ": template
#show: x => template("Volume 1: The CPU", "0.4.7", keywords, x)

#import "preface.typ": preface; #preface
#import "intro.typ": intro; #intro
#import "regfile.typ": regfile; #regfile
