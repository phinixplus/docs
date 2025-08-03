#let keywords = (
	"PHINIX+", "CPU",
	"Instruction Set",
	"Computer Engineering",
	"Computer Architecture"
)

#import "/source/config.typ": docs-ver
#import "/source/template.typ": template
#show: x => template("Volume 1: The CPU", docs-ver, keywords, x)

#import "intro.typ": intro; #intro
#import "regfile.typ": regfile; #regfile
#import "ifmts.typ": ifmts; #ifmts
#import "instrs.typ": instrs; #instrs
