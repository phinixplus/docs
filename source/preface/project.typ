#let project = [

= About the Project
This documentation and the overall design and direction of the PHINIX+
project is my personal project which I have been working on during my
free time. Due to this, development naturally has been an ongoing effort,
with a time span measured in years. It is not surprising considering
the scale of the project and that this is, at least for now, a one man show.

== The Catalyst
I have consumed quite a lot of content regarding computer engineering over
the years, mostly from various channels on YouTube. This gave me the valuable
knowledge that made me curious enough, and made me feel confident enough to
try to implement something of my own, inspired by systems from the mid 80s to
the early 90s.

=== Expectations of the Past
I never got to experience early computing or the home computer revolution.
To me, that period in the history of computing was the most interesting since
the systems of the time where still quite simple, enough so as to allow the
owner to entirely understand how they would operate, yet made it into the
hands of ordinary people. This understanding was also perpetuated by the
fact that during that time it was expected that the owner knew how to
program their machine. Accumulation and handling of software was also much
more intimate since the internet did not exist. Everything was physical media.

Though this did arguably begin with the MITS Altair 8800 during the mid 70s,
it really only reached the masses with machines like the Commodore 64 and the
IBM Personal Computer (whose system architecture evolved into our modern
computers) in the early 80s. To this day, there exists almost a cult following
for these machines due to people's nostalgia and care for the past; the retro
community.

=== Limitations of the Past
Apart from the difference in how people used computers in the past, there
was also of course a big difference in the amount of performance that was
available. With such limited resources, programmers had to be extra careful
about what their operations would cost. This limiting environment resulted
in numerous clever techniques that took advantage of some quirk of the hardware
to gain in performance or to achieve things far above the expectation of the
designers of the hardware.

As a result, I believe that software engineering under the limitations of
systems of the past would much more qualify as an art form than that of today.
Programmers where (more than just) incentivized to come up with novel solutions
to a problem, in the process being in more direct control and understanding of
the hardware they were working on. It felt more authentic. It felt like a piece
of software was genuinely crafted with care and attention instead of just as a
means to profits--believe it or not, malware included.

== The Goal
So, having covered all the most important factors which have contributed to
me deciding to start this project, I shall finally explain what the purpose
of PHINIX+ is. In short, it is my attempt to recreate that experience from the
past while teaching myself the practical principles behind it. The goal is
first and foremost to educate myself, and secondarily to create at least a
half-descent retro-style system; something to be proud about.

In practice, all that means that PHINIX+ will be my honest attempt at a
RISC-style CPU with a system around it to match, based on designs of the
mid 80s to early 90s. I chose that time period and not something earlier
since my desired architecture (and implementation) is more similar to machines
from then, instead of earlier so-called proto-CISC systems like those based on
6502 or Z80 CPUs. However since I am trying to design in such a way so as to
allow others to implement their own systems based on the herein described
architecture, I will be leaving implementation details mostly out of this
documentation and so up to the implementer's discretion.

]
