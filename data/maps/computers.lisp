(:MAP :ID "computers" :TITLE "Computers" :COMPRESSION
 "A switch controls a switch; everything else is layers of programs loading programs." :AXIS
 ((:FROM 1855 :TO 1935 :SCALE 0.1)))
(:GROUP :ID "switches" :COMPRESSION "A switch can control another switch.")
(:GROUP :ID "stored-program" :COMPRESSION "Instructions are data in the same memory.")
(:GROUP :ID "sharing" :COMPRESSION "Many programs share one machine.")
(:GROUP :ID "symbolic-ai" :COMPRESSION
 "Intelligence as hand-written symbols and rules, which worked in narrow cases and hit a wall.")
(:GROUP :ID "languages" :COMPRESSION "Languages are compressions over machine code.")
(:GROUP :ID "connectionism" :COMPRESSION
 "A function with adjustable weights can be fit to examples instead of being programmed.")
(:GROUP :ID "loaders" :COMPRESSION "Every layer is a program that loads the next.")
(:GROUP :ID "surfaces" :COMPRESSION
 "As switches shrink and get cheaper, the computer moves from a shared room to the desk, the pocket, the wall and the face.")
(:GROUP :ID "network" :COMPRESSION "Machines talk.")
(:GROUP :ID "learned" :COMPRESSION "Programs can be found, not written.")
(:NODE :ID "transistor" :TITLE "Transistor as a switch" :COMPRESSION
 "A small voltage at one terminal lets or blocks a current between two others, so one signal can control another.
Un voltaje pequeño en un terminal permite o bloquea una corriente entre otros dos, de modo que una señal puede controlar a otra."
 :BODY
 "Every computer is billions of these and nothing else is physical; all the rest is arrangement."
 :GROUP "switches" :PREREQS NIL :ERA 1947)
(:NODE :ID "logic-gates" :TITLE "Logic gates" :COMPRESSION
 "Two switches in series is AND, in parallel is OR, one that inverts is NOT; every other function is made of these."
 :BODY
 "Boolean logic becomes hardware: a claim about truth is now a circuit you can buy. A logic gate is a circuit whose output is a fixed function of its inputs, where each signal is one of two levels (low = 0, high = 1). The function is a Boolean operation (Boole 1854), and Shannon showed in 1937 that circuits of switches implement it.

## What it is made of
Switches that control other switches. Today the switch is a MOSFET transistor: a voltage on the gate connects or disconnects a path between source and drain. Earlier generations used relays, vacuum tubes, or diode-resistor networks. The gate's logic comes from how the switches are wired, not from the switch type.

- **Series** (path conducts only if both switches are on) = AND
- **Parallel** (path conducts if either is on) = OR
- **Inverting** (switch on pulls output to 0; off lets a pull-up make it 1) = NOT

## Primitive examples

**Switch/relay level (the idea in its purest form)**
- AND: a battery, two switches in series, a lamp. Lamp lights only if A and B are closed.
- OR: two switches in parallel. Lamp lights if A or B is closed.
- NOT: a relay whose normally-closed contact feeds the lamp. Energise the coil and the lamp goes out.

**Truth tables**

| A | B | AND | OR | NAND | NOR | XOR |
|---|---|-----|----|------|-----|-----|
| 0 | 0 | 0 | 0 | 1 | 1 | 0 |
| 0 | 1 | 0 | 1 | 1 | 0 | 1 |
| 1 | 0 | 0 | 1 | 1 | 0 | 1 |
| 1 | 1 | 1 | 1 | 0 | 0 | 0 |

NOT: 0→1, 1→0.

**CMOS (how chips do it)**
- NOT: one PMOS from supply to output, one NMOS from output to ground, same input on both gates. Exactly one conducts, so the output is always actively driven.
- NAND: two NMOS in series to ground, two PMOS in parallel to supply. Output is 0 only when both inputs are 1.
- NOR: the dual: NMOS in parallel, PMOS in series.
- AND and OR are NAND/NOR followed by a NOT, so they cost more transistors. That is why NAND and NOR are the natural CMOS gates.

## Why a few gates are enough
NAND alone is *functionally complete*: NOT(A) = NAND(A,A); AND = NOT(NAND); OR(A,B) = NAND(NOT A, NOT B) (De Morgan). So any Boolean function, hence any digital computer, can be built from one gate type. NOR is also complete.

## Gates to memory and arithmetic
- Half adder: sum = A XOR B, carry = A AND B. Chain adders to add numbers.
- Feed gates back on themselves (two cross-coupled NORs) and you get an SR latch: memory from logic.

## Common confusions
- Gates are not \"software\": a gate is a physical voltage relationship; 0 and 1 are voltage ranges, not exact values.
- Real gates take time (propagation delay) and that limits clock speed.

## Primary sources
- Boole, *An Investigation of the Laws of Thought* (1854)
- Shannon, \"A Symbolic Analysis of Relay and Switching Circuits\" (1937)"
 :GROUP "switches" :PREREQS ("transistor") :ERA 1938)
(:NODE :ID "adder" :TITLE "Adding with gates" :COMPRESSION
 "XOR gives the sum bit and AND the carry; chain one per bit and you add numbers of any width."
 :BODY
 "Adding is just wiring: voltages pass through gates, and the pattern that comes out happens to be the right answer. It is school addition, column by column with a carry, using only 0 and 1.

## One column: the half adder

| A | B | sum | carry |
|---|---|-----|-------|
| 0 | 0 | 0 | 0 |
| 0 | 1 | 1 | 0 |
| 1 | 0 | 1 | 0 |
| 1 | 1 | 0 | 1 |

- sum = A XOR B (1 when the inputs differ)
- carry = A AND B (1 only when both are 1)

Two gates add two bits. (1+1 = \"10\": write 0, carry 1.)

## A column with a carry in: the full adder

Every column after the first also receives a carry from its right, so it adds three bits: A, B and carry-in.

- sum = A XOR B XOR carry-in
- carry-out = (A AND B) OR (carry-in AND (A XOR B))

Build it from two half adders (the second adds carry-in to the first's sum) and an OR joining their carries.

## Any width: chain them

Connect each carry-out to the next carry-in. N full adders add N-bit numbers. This is the **ripple-carry adder**.

Example, 011 + 001: bit 0 gives 0 carry 1; bit 1 gives 0 carry 1; bit 2 gives 1. Result 100 = 4.

Its weakness: the carry must ripple through every column, which limits speed. Carry-lookahead fixes this by computing carries in parallel."
 :GROUP "switches" :PREREQS ("logic-gates") :ERA 1937)
(:NODE :ID "clock" :TITLE "The clock" :COMPRESSION
 "A square wave tells every gate when to look at its inputs, turning a chaos of signals into a sequence of steps."
 :BODY
 "Time inside a computer is discrete because of this. Every 'cycle' you ever hear about is one tick."
 :GROUP "switches" :PREREQS ("logic-gates") :ERA 1945)
(:NODE :ID "flip-flop" :TITLE "Flip-flop as one bit of memory" :COMPRESSION
 "Two gates wired in a loop hold a value until pushed." :BODY
 "A computer needs somewhere to keep a value after the signal that set it has gone. The flip-flop does this with no moving parts and no special material: memory is just a loop.

**Mechanism.** Wire two inverting stages (NOR gates, NAND gates or amplifying tubes/transistors) so that each one's output is the other's input. The loop has two stable states: Q=1 with Q̄=0, or Q=0 with Q̄=1. Each stage reinforces the other, so the state holds until an input pushes it over. Set drives it to one state and Reset to the other; with both inactive it holds. That is one bit.

A single gate fed back on itself (an OR whose output returns to its input) also latches, but only one way: once at 1 it can never be cleared. Two inverting stages give a bit that can be written both ways. The stages must also have gain, restoring a clean 0 or 1 each trip around the loop, or the stored value decays.

**History.**
- 1830s: the electromagnetic relay (Joseph Henry, 1835). A relay whose own contact feeds its coil is a holding circuit, the first one-stage latch.
- 1906: de Forest's triode gives an electronic switch and amplifier.
- 1918: Eccles and Jordan patent two cross-coupled triodes, the first true bistable circuit (published in *Radio Review*, 1919). \"Flip-flop\" is a later name.
- 1930s: Wynn-Williams chains bistables into scale-of-two counters.
- 1940s: Colossus and ENIAC use tube flip-flops for registers, but they are too costly for bulk memory, so delay lines, Williams tubes and magnetic core follow.
- 1960s onward: transistors and ICs. The 6-transistor SRAM cell, two cross-coupled inverters plus two access transistors, is still the CPU cache bit.

This is one bit of RAM."
 :GROUP "switches" :PREREQS ("logic-gates" "clock") :ERA 1918)
(:NODE :ID "ram" :TITLE "RAM as an addressed grid" :COMPRESSION
 "A decoder turns an address number into one selected row of flip-flops you can read or overwrite."
 :BODY
 "The address is the first abstraction: a number names a place. Pointers, arrays and files all descend from it."
 :GROUP "switches" :PREREQS ("flip-flop" "adder") :ERA 1968)
(:NODE :ID "fetch-decode-execute" :TITLE "The fetch-decode-execute loop" :COMPRESSION
 "Read the word at the program counter, work out which operation it names, do it, move on, forever."
 :BODY "This loop is the whole CPU; everything else is speed. Nothing a computer does is not this."
 :GROUP "stored-program" :PREREQS ("ram" "clock") :ERA 1945)
(:NODE :ID "registers-pc" :TITLE "Registers and the program counter" :COMPRESSION
 "A handful of fast words inside the CPU; one of them, the PC, holds the address of the next instruction."
 :BODY
 "The PC is the computer's single thread of attention. Jumps, calls and interrupts are all just writes to it."
 :GROUP "stored-program" :PREREQS ("flip-flop") :ERA 1945)
(:NODE :ID "instruction-set" :TITLE "The instruction set" :COMPRESSION
 "The fixed menu of operations the hardware understands, each a bit pattern with fields naming the operation and its operands."
 :BODY
 "The ISA is the contract between the hardware and every program ever written for it; change it and all software breaks."
 :GROUP "stored-program" :PREREQS ("fetch-decode-execute" "registers-pc") :ERA 1964)
(:NODE :ID "machine-code-assembly" :TITLE "Machine code and assembly" :COMPRESSION
 "Assembly is machine code with names instead of numbers; an assembler is a lookup table inside a loop."
 :BODY "The first program that writes programs. From here on, programs are text." :GROUP
 "stored-program" :PREREQS ("instruction-set") :ERA 1949)
(:NODE :ID "reset-vector-bootstrap" :TITLE "Reset vector and bootstrap" :COMPRESSION
 "At power-on the PC is forced to a fixed address in ROM, and whatever program sits there runs first."
 :BODY "There is no magic at startup: the machine begins by executing an address someone chose."
 :GROUP "stored-program" :PREREQS ("fetch-decode-execute") :ERA 1951)
(:NODE :ID "code-and-data-alike" :TITLE "Code and data in one memory" :COMPRESSION
 "Instructions are just numbers in RAM, so a program can read, write and generate other programs."
 :BODY
 "This one decision makes compilers, loaders and interpreters possible, and also every buffer-overflow exploit."
 :GROUP "stored-program" :PREREQS ("fetch-decode-execute" "ram") :ERA 1945)
(:NODE :ID "firmware-uefi" :TITLE "Firmware (BIOS/UEFI)" :COMPRESSION
 "The program in ROM at the reset vector: it checks the hardware, finds a disk, copies the next program into RAM and jumps to it."
 :BODY "The first loader. Everything after it is software that was loaded by software." :GROUP
 "loaders" :PREREQS ("reset-vector-bootstrap") :ERA 1981)
(:NODE :ID "bootloader" :TITLE "The bootloader" :COMPRESSION
 "A small program whose only job is to find the kernel on disk, put it in memory and hand over the PC."
 :BODY
 "Each layer is too big for the layer below to load directly, so there is a chain of ever larger loaders."
 :GROUP "loaders" :PREREQS ("firmware-uefi") :ERA 1992)
(:NODE :ID "kernel" :TITLE "The kernel" :COMPRESSION
 "The one program that runs with full power over the hardware and lends it, piece by piece, to every other program."
 :BODY "Everything you call 'the operating system' is this program plus the programs it loads."
 :GROUP "loaders" :PREREQS ("bootloader" "code-and-data-alike") :ERA 1969)
(:NODE :ID "drivers" :TITLE "Device drivers" :COMPRESSION
 "Kernel code that turns 'write these bytes' into the exact register pokes one particular device needs."
 :BODY "Hardware diversity is hidden here, so every program above sees the same few verbs." :GROUP
 "loaders" :PREREQS ("kernel") :ERA 1969)
(:NODE :ID "shell" :TITLE "The shell" :COMPRESSION
 "A program that reads a line, finds a program by that name, and asks the kernel to run it with the rest of the line as arguments."
 :BODY "The first user interface, and still the one every other is a wrapper around." :GROUP
 "loaders" :PREREQS ("kernel") :ERA 1971)
(:NODE :ID "editor" :TITLE "The editor" :COMPRESSION
 "A program that holds a file in memory as text and writes it back; the tool every other program is written in."
 :BODY
 "Programs are text files, so the editor is where software is born, including the next editor."
 :GROUP "loaders" :PREREQS ("shell") :ERA 1976)
(:NODE :ID "processes-threads" :TITLE "Processes and threads" :COMPRESSION
 "A process is a program plus its own memory; a thread is one program counter and stack inside it."
 :BODY "The unit the kernel shares the machine between. Everything you run is one of these." :GROUP
 "sharing" :PREREQS ("kernel" "registers-pc") :ERA 1965)
(:NODE :ID "scheduler" :TITLE "The scheduler" :COMPRESSION
 "On a timer tick the kernel stops the running program, saves its registers, restores another's and jumps; 'at the same time' is a trick."
 :BODY "One CPU appears to be many. Concurrency bugs are this trick showing through." :GROUP
 "sharing" :PREREQS ("processes-threads" "clock") :ERA 1962)
(:NODE :ID "virtual-memory" :TITLE "Virtual memory" :COMPRESSION
 "Every address a program uses is translated through a table the kernel owns, so each program sees its own private memory."
 :BODY "Programs cannot read or corrupt each other, and memory can be larger than RAM." :GROUP
 "sharing" :PREREQS ("ram" "processes-threads") :ERA 1962)
(:NODE :ID "files" :TITLE "Files" :COMPRESSION
 "A name mapped to a sequence of bytes on a disk; a directory is a file that lists other files."
 :BODY
 "Persistence and naming in one idea. Almost everything the kernel offers is made to look like a file."
 :GROUP "sharing" :PREREQS ("kernel" "drivers") :ERA 1965)
(:NODE :ID "syscall-boundary" :TITLE "The system call boundary" :COMPRESSION
 "A program asks the kernel for something with a special instruction that raises privilege, passes a number, and drops it again on return."
 :BODY
 "The only door between a program and the hardware. Every library call eventually ends here or stays in user space."
 :GROUP "sharing" :PREREQS ("kernel" "instruction-set") :ERA 1969)
(:NODE :ID "os-as-referee" :TITLE "The OS as referee" :COMPRESSION
 "The kernel exists to share the hardware fairly and keep programs from touching each other; everything else it does is convenience."
 :BODY
 "Explains why an OS is needed at all, and what it is not: it is not the desktop, the shell or the apps."
 :GROUP "sharing" :PREREQS ("scheduler" "virtual-memory" "syscall-boundary") :ERA 1969)
(:NODE :ID "compiler-vs-interpreter" :TITLE "Compiler versus interpreter" :COMPRESSION
 "A compiler translates a whole program into machine code once; an interpreter reads and performs it a piece at a time while it runs."
 :BODY
 "The two ways a text becomes behaviour. Everything from Python to the CPU's own microcode sits somewhere between."
 :GROUP "languages" :PREREQS ("machine-code-assembly" "code-and-data-alike") :ERA 1957)
(:NODE :ID "call-stack" :TITLE "The call stack" :COMPRESSION
 "Each function call pushes its return address and locals; a return pops them, so calls nest and recursion is free."
 :BODY
 "Functions, locals and recursion are all this one data structure. A stack overflow is it running out."
 :GROUP "languages" :PREREQS ("registers-pc" "ram") :ERA 1960)
(:NODE :ID "garbage-collection" :TITLE "Garbage collection" :COMPRESSION
 "Memory a program can no longer reach is found by walking from the roots and freed automatically."
 :BODY
 "Removes a whole class of bugs by making the runtime, not the programmer, account for memory."
 :GROUP "languages" :PREREQS ("call-stack") :ERA 1959)
(:NODE :ID "code-as-data" :TITLE "Code as data" :COMPRESSION
 "When programs are written as the language's own data structures, a program can read, build and rewrite programs."
 :BODY "Macros, interpreters-in-the-language and the whole bottom-up style follow from it." :GROUP
 "languages" :PREREQS ("compiler-vs-interpreter" "code-and-data-alike") :ERA 1960)
(:NODE :ID "image-and-repl" :TITLE "The image and the REPL" :COMPRESSION
 "A running program reads a form, evaluates it inside itself and prints the result, so it grows while it runs, and its whole state, compiler included, can be saved to disk and resumed."
 :BODY
 "Most programs are rebuilt from source and restarted from nothing. A Lisp system works the other way: the program stays alive, and you change it from the inside. This is why the language, the editor and the running program can all be one thing.

**The REPL.** Read a form, evaluate it inside the running program, print the result, loop. Because code is data (see Code as data), the reader turns text into the same structures the evaluator runs. A new function defined at the prompt joins the program immediately, with no restart and no separate build step.

**The image.** Because the compiler and evaluator are part of the running program, everything the program has become is just memory: functions, data, and the compiler itself. Dump that memory to disk and you have an image. Load the image later and the program resumes exactly where it was, with everything you defined still there.

**Together.** The REPL grows the program while it runs. The image keeps what it grew. Development is then a conversation with a live system rather than a cycle of edit, compile and run."
 :GROUP "languages" :PREREQS ("code-as-data") :ERA 1962)
(:NODE :ID "types" :TITLE "Types" :COMPRESSION
 "A type is a claim about what a value is, checked before a run (static) or during it (dynamic) so wrong combinations are caught."
 :BODY
 "The main tool for making a compiler catch your mistakes, and the main argument in language design."
 :GROUP "languages" :PREREQS ("compiler-vs-interpreter") :ERA 1973)
(:NODE :ID "packets-ip" :TITLE "Packets and IP" :COMPRESSION
 "A message is cut into addressed envelopes that each find their own way across the network; nothing in the middle keeps state."
 :BODY
 "Statelessness in the middle is why the internet scales and why it can lose, duplicate or reorder anything."
 :GROUP "network" :PREREQS ("os-as-referee") :ERA 1974)
(:NODE :ID "tcp" :TITLE "TCP" :COMPRESSION
 "Number the packets, acknowledge each, resend the lost ones, and an unreliable network becomes a reliable ordered stream."
 :BODY "Reliability is built on top of unreliability, in software, at the edges." :GROUP "network"
 :PREREQS ("packets-ip") :ERA 1974)
(:NODE :ID "sockets" :TITLE "Sockets" :COMPRESSION
 "The kernel's file-like handle for a network connection: open, read, write, close." :BODY
 "A connection to another machine becomes just another thing a program reads and writes." :GROUP
 "network" :PREREQS ("tcp" "files" "syscall-boundary") :ERA 1983)
(:NODE :ID "http" :TITLE "HTTP" :COMPRESSION
 "A text request naming a resource, a text response carrying it; stateless, one exchange at a time."
 :BODY
 "The lingua franca of the web, and why every web app has to invent its own way to remember you."
 :GROUP "network" :PREREQS ("sockets") :ERA 1991)
(:NODE :ID "browser-as-renderer" :TITLE "The browser as renderer" :COMPRESSION
 "A program that fetches text over HTTP, parses it into a tree, and paints the tree." :BODY
 "The browser is a document viewer that got a programming language; everything on the web is drawn by it."
 :GROUP "network" :PREREQS ("http") :ERA 1990)
(:NODE :ID "client-server" :TITLE "Client and server" :COMPRESSION
 "One program waits and answers; many programs ask. Where the state lives decides what the program is."
 :BODY
 "The shape of almost every networked system, and the question behind every architecture argument."
 :GROUP "network" :PREREQS ("sockets") :ERA 1984)
(:NODE :ID "web-as-app-platform" :TITLE "The web as application platform" :COMPRESSION
 "Send the browser a program along with the page, and the server becomes the thing the program talks to."
 :BODY
 "Turns a document viewer into the universal runtime; most software you use arrives this way."
 :GROUP "network" :PREREQS ("browser-as-renderer" "client-server") :ERA 1995)
(:NODE :ID "neuron-weighted-sum" :TITLE "The neuron as a weighted sum" :COMPRESSION
 "Multiply each input by a weight, add them up, squash the result: a tiny adjustable function."
 :BODY "The unit everything in machine learning is made of; there is no cleverness inside it."
 :GROUP "connectionism" :PREREQS ("adder") :ERA 1958)
(:NODE :ID "gradient-training" :TITLE "Training by gradient descent" :COMPRESSION
 "Measure the error, compute how each weight moved it, nudge every weight the other way, repeat millions of times."
 :BODY
 "The program is not written; it is found by this loop. Learning is just optimisation with a lot of parameters."
 :GROUP "connectionism" :PREREQS ("neuron-weighted-sum") :ERA 1986)
(:NODE :ID "transformer" :TITLE "The transformer" :COMPRESSION
 "Each token looks at every other token, weighs how much it matters, and mixes in what it finds; stacked many times, this reads."
 :BODY
 "The architecture behind every current language model; attention replaced recurrence and made training parallel."
 :GROUP "learned" :PREREQS ("gradient-training") :ERA 2017)
(:NODE :ID "next-token" :TITLE "Next-token prediction" :COMPRESSION
 "Train on one objective: given the text so far, guess the next piece. Everything else emerges from doing that well."
 :BODY
 "The surprising fact of the era: one dumb objective at scale yields reasoning, code and conversation."
 :GROUP "learned" :PREREQS ("transformer") :ERA 2018)
(:NODE :ID "model-as-loop-plus-weights" :TITLE "A model is a loop plus weights" :COMPRESSION
 "Inference is a fixed program running the same arithmetic over billions of learned numbers; the weights are the program."
 :BODY
 "Demystifies the model: a file of numbers and a short loop that applies them, nothing hidden."
 :GROUP "learned" :PREREQS ("next-token" "fetch-decode-execute") :ERA 2020)
(:NODE :ID "gpu-inference" :TITLE "GPUs and inference" :COMPRESSION
 "Thousands of simple cores do the same multiply-add in lockstep, and a model's arithmetic fits that shape exactly."
 :BODY "Why models run on graphics cards and why compute, not ideas, bounds what can be trained."
 :GROUP "learned" :PREREQS ("model-as-loop-plus-weights" "clock") :ERA 2012)
(:NODE :ID "wrapper-as-app-layer" :TITLE "The wrapper as application layer" :COMPRESSION
 "A program that assembles context, calls the model, reads its answer and acts on it; the new shell."
 :BODY
 "Where the model meets the rest of the stack: tools, files, the web. Most AI products are this loop."
 :GROUP "learned" :PREREQS ("model-as-loop-plus-weights" "web-as-app-platform" "shell") :ERA 2022)
(:NODE :ID "mainframe-terminals" :TITLE "Mainframes and terminals" :COMPRESSION
 "When a machine costs a building, many people share it through dumb terminals and the operating system rations it."
 :BODY
 "This is the starting surface, and it explains why sharing (scheduling, memory protection, privilege) was invented before personal computers existed. One expensive machine, many users at keyboards connected by wire; all the computing happens in the centre. Client and server later recreates this shape over the network."
 :GROUP "surfaces" :PREREQS NIL :ERA 1964)
(:NODE :ID "scaling-moore" :TITLE "Shrinking switches" :COMPRESSION
 "Etching more transistors per chip makes each one cheaper and faster, and every new surface is that cost curve crossing a threshold."
 :BODY
 "The integrated circuit (1958) put many transistors on one slice; Moore's 1965 observation was that the count per chip kept doubling. Cheaper and lower-power switches are what made a minicomputer, then a desk machine, then a phone possible. The same programs-loading-programs stack moved onto each new size of machine."
 :GROUP "surfaces" :PREREQS NIL :ERA 1965)
(:NODE :ID "personal-computer" :TITLE "The personal computer" :COMPRESSION
 "When a whole CPU fits on one chip, one person can own a machine, and the kernel's job shifts from rationing to serving one user."
 :BODY
 "The microprocessor (1971) made the CPU a single part. The home machine (Altair, Apple II, 1975-77) brought the loader chain, from ROM through disk to shell, to a desk, and made software a product."
 :GROUP "surfaces" :PREREQS NIL :ERA 1977)
(:NODE :ID "gui" :TITLE "Bitmap display and pointer" :COMPRESSION
 "Treat the screen as a grid of memory the program paints and a pointer as an input device, and the machine can be operated by pointing instead of typing."
 :BODY
 "Xerox's Alto (1973) held the screen as pixels in RAM, so any program could draw anything. Windows, icons and mouse followed. This is the shell's successor for most people, and the browser later paints its tree the same way."
 :GROUP "surfaces" :PREREQS NIL :ERA 1973)
(:NODE :ID "mobile-embedded" :TITLE "Phones and embedded computers" :COMPRESSION
 "With a battery, a radio and sensors added, the computer goes in the pocket or inside other things, and power budget becomes the main design constraint."
 :BODY
 "Microcontrollers (1970s) hide computers in cars, appliances and toys. The smartphone (2007) fuses a full OS, touch screen, GPS, camera and network into one device. Energy per operation, not speed, shapes its chips and its scheduler."
 :GROUP "surfaces" :PREREQS NIL :ERA 2007)
(:NODE :ID "wearables-spatial" :TITLE "Wearables and spatial computing" :COMPRESSION
 "Glasses and headsets put the display on the face and sense the room, so the interface becomes the world around you."
 :BODY
 "The latest step in the same trend: smaller, closer, always on. Cameras and depth sensors track head and hands, and the program anchors drawings to places. It is the bitmap display and pointer idea with the screen replaced by your field of view."
 :GROUP "surfaces" :PREREQS NIL :ERA 2014)
(:NODE :ID "computability" :TITLE "Turing machines and computability" :COMPRESSION
 "A simple machine reading and writing symbols on a tape can compute anything computable, and some questions, like whether a program halts, no program can answer."
 :BODY
 "Before building computers, Turing asked what 'computing' even means; his answer defines what every machine in this map can and cannot do.

A Turing machine is a head on an endless tape of cells. It has a finite table of rules: in state S, reading symbol X, write Y, move left or right, go to state T. That is all. Yet anything any computer can compute, this can compute too (the Church–Turing thesis: a claim about the word 'computable', not a theorem).

The limit: no program can decide, for every program and input, whether it will halt. If one could, feed it a program that does the opposite of whatever the decider predicts about it, and you get a contradiction. So some well-posed questions are unanswerable by any machine, however fast or large.

Source: Turing, 'On Computable Numbers, with an Application to the Entscheidungsproblem' (1936)."
 :GROUP "stored-program" :PREREQS NIL :ERA 1936)
(:NODE :ID "databases" :TITLE "Databases" :COMPRESSION
 "Keep structured data in tables behind a query language, and let the system handle storage, concurrency and crash recovery."
 :BODY
 "Codd's relational model (1970) separated what you ask from how it is stored. Transactions let many programs change shared state without corrupting it. It is the next layer above files, and most servers are mainly a database with a front door."
 :GROUP "sharing" :PREREQS NIL :ERA 1970)
(:NODE :ID "cloud-virtualization" :TITLE "Virtualization and the cloud" :COMPRESSION
 "A program that pretends to be a whole machine lets one physical computer be sliced and rented out as many."
 :BODY
 "A hypervisor does for whole operating systems what the kernel does for processes. Rented machines in data centres (2006 on) bring back the mainframe shape: thin clients such as phones talk to big shared computers."
 :GROUP "network" :PREREQS NIL :ERA 2006)
(:NODE :ID "cryptography" :TITLE "Cryptography and trust" :COMPRESSION
 "Public-key mathematics lets strangers share secrets and verify identity over a network that anyone can read."
 :BODY
 "Diffie and Hellman (1976) showed that two parties could agree on a key in public. Encryption, signatures and certificates make HTTPS, software updates and secure boot trustworthy, and they are why a signed bootloader can check the kernel it loads."
 :GROUP "network" :PREREQS NIL :ERA 1976)
(:NODE :ID "bits-representation" :TITLE "Bits and representation" :COMPRESSION
 "Anything, whether numbers, text, sound or pictures, can be stored as patterns of on/off switches, by agreeing on a code."
 :BODY
 "A switch only has two states, so every other kind of information has to be encoded in them. This is why one machine can handle everything.

Integers use place value in base 2, with a fixed width (8, 32, 64 bits) and two's complement for negatives. Text maps each character to a number (ASCII, Unicode). Fractions use a sign, exponent and mantissa (floating point). Colours, sound samples and pixels are numbers too.

The bits mean nothing by themselves. The same 32 bits can be an integer, a colour or an instruction, depending on what reads them. Shannon named the unit the *bit* in 1948."
 :GROUP "switches" :PREREQS NIL :ERA 1948)
(:NODE :ID "caches" :TITLE "Caches and the memory hierarchy" :COMPRESSION
 "Small fast memory holds copies of recently used parts of big slow memory, and programs mostly reuse what they just touched."
 :BODY
 "CPUs run far faster than RAM can answer, so a CPU that fetched everything from RAM would mostly wait. The fix is a hierarchy: registers, then small caches, then RAM, then disk, each larger, slower and cheaper than the one before.

On each access the hardware checks the cache first. A hit returns quickly. A miss fetches a whole block from the level below and keeps it. This works because programs show locality: they reuse the same addresses soon (temporal) and touch nearby addresses next (spatial). Wilkes proposed the idea in 1965 as \"slave memory\"."
 :GROUP "stored-program" :PREREQS NIL :ERA 1965)
(:NODE :ID "linking-loading" :TITLE "Linking and loading" :COMPRESSION
 "An executable file is a program plus instructions for placing it in memory, and a loader copies it in, fixes up addresses and jumps to its start."
 :BODY
 "Every layer in this chain must turn a file on disk into a running program. Compiled pieces are separate object files with unresolved references to each other's functions. A linker joins them and resolves those names to addresses.

The result is an executable with a header saying where the code and data go and where execution starts. The loader (in the kernel or the bootloader) maps those sections into memory, adjusts addresses if needed, and sets the PC to the entry point. Dynamic linking defers part of this to load time, so programs share libraries."
 :GROUP "loaders" :PREREQS NIL :ERA 1960)
(:NODE :ID "interrupts" :TITLE "Interrupts" :COMPRESSION
 "Hardware can force the CPU to save its place and jump to a handler, so devices and timers get attention without the running program polling for them."
 :BODY
 "Without interrupts, a program would have to keep asking each device whether it needs anything. An interrupt is a signal from a timer, disk, network card or keyboard. The CPU finishes the current instruction, saves the PC and registers, and jumps to a handler address looked up in a table. When the handler finishes, execution resumes where it stopped.

The scheduler's timer tick, device drivers and the system call mechanism all work this way. Exceptions such as page faults and division by zero use the same path."
 :GROUP "sharing" :PREREQS NIL :ERA 1953)
(:NODE :ID "concurrency-locks" :TITLE "Concurrency and locks" :COMPRESSION
 "When threads share memory, the result can depend on timing, so a lock lets only one thread at a time touch the shared piece."
 :BODY
 "Threads can be switched at any instruction, so two threads that read, change and write the same variable can overwrite each other's work. This is a race condition, and it is hard to reproduce because it depends on timing.

A lock (Dijkstra's semaphore, 1965) lets one thread enter a critical section while the others wait. Atomic hardware instructions make the lock itself safe. Locks bring their own hazards: deadlock, where threads each wait for the other, and lost speed from waiting. Alternatives are message passing and immutable data."
 :GROUP "sharing" :PREREQS NIL :ERA 1965)
(:NODE :ID "parsing-grammars" :TITLE "Parsing and grammars" :COMPRESSION
 "A grammar defines which strings are valid programs, and a parser turns text into a tree that the rest of the language machinery works on."
 :BODY
 "Compilers, interpreters, shells and browsers all begin by turning flat text into structure. A lexer first splits characters into tokens. A parser then applies grammar rules (written in BNF, introduced for Algol 60) to build a syntax tree that shows nesting and precedence.

Every later step works on the tree: type checking, code generation or direct evaluation. Languages that write code as their own data structures, like Lisp, make this step almost trivial."
 :GROUP "languages" :PREREQS NIL :ERA 1960)
(:NODE :ID "dns-naming" :TITLE "Naming and DNS" :COMPRESSION
 "A distributed hierarchical directory maps human names to IP addresses, so no one machine has to know every name."
 :BODY
 "Packets travel by number, but people use names. DNS (Mockapetris, 1983) replaced a single shared hosts file with a tree of servers. Root servers point to servers for each top-level domain, which point to servers for each domain.

A resolver asks down the chain and caches the answers for a time given by the owner. Whoever controls a name's records controls where it leads, which is why DNS matters for security as well."
 :GROUP "network" :PREREQS NIL :ERA 1983)
(:NODE :ID "embeddings" :TITLE "Embeddings" :COMPRESSION
 "Each token becomes a learned vector of numbers, positioned so that things used in similar ways end up close together."
 :BODY
 "A network can only do arithmetic, so text has to become numbers. An embedding table gives each token a vector of hundreds or thousands of values, learned during training. Tokens that appear in similar contexts end up with similar vectors, and directions in the space come to carry meaning (word2vec, 2013).

The transformer's first step is looking up these vectors, and each layer then refines them using context. Embeddings of whole passages let programs search by meaning rather than by exact words."
 :GROUP "learned" :PREREQS NIL :ERA 2013)
(:NODE :ID "post-training" :TITLE "Post-training" :COMPRESSION
 "After next-token pretraining, further training on examples and human preference signals turns a text continuer into an assistant that follows instructions."
 :BODY
 "A pretrained model continues any text, including a question with another question. Post-training changes its behaviour with further training. Supervised fine-tuning on example conversations teaches the format. Reinforcement from human or model feedback (RLHF, 2022) rewards answers people prefer.

The architecture is the same and only the weights shift. This step is what makes a model usable as the engine inside a wrapper."
 :GROUP "learned" :PREREQS NIL :ERA 2022)
(:NODE :ID "boolean-algebra" :TITLE "Boolean algebra" :COMPRESSION
 "Logic reduces to arithmetic on 0 and 1 (AND, OR, NOT), so reasoning can be done by calculation, and later by circuits."
 :BODY
 "Boolean algebra is why a pile of switches can do reasoning: true and false become 1 and 0, and AND, OR and NOT become operations you can calculate with and simplify like ordinary algebra.

Boole (*The Laws of Thought*, 1854) gave the rules. Any statement built from AND, OR and NOT can be rewritten, simplified and checked by symbol manipulation. Shannon's 1938 thesis showed that switching circuits obey the same algebra, so a logical expression can be turned directly into a circuit, and a circuit can be simplified with algebra."
 :GROUP "switches" :PREREQS NIL :ERA 1854)
(:NODE :ID "relay-vacuum-tube" :TITLE "Relays and vacuum tubes" :COMPRESSION
 "Before transistors, a switch controlled by a signal was an electromagnet (relay) or a heated filament and grid (tube)."
 :BODY
 "Relays and tubes are the same idea built two ways: a small signal controls a larger flow. So one switch's output can drive another's input. Chained together, they make gates, and gates wired in a loop make memory.

## How the ideas developed

- **1820:** Ørsted shows an electric current deflects a compass needle, so currents make magnetism.
- **1825:** Sturgeon builds the first electromagnet.
- **1831:** Faraday shows induction, linking electricity and magnetism in both directions. This is the physics underneath, not the switch itself.
- **1830s:** Joseph Henry builds strong electromagnets and uses them to switch a circuit at a distance. Edward Davy patents a telegraph relay in 1837.
- **1847–54:** Boole's algebra of true/false values. It was only later applied to circuits.
- **1880:** While working on carbon-filament light bulbs, Edison noticed carbon built up on the glass and a small current flowed from the hot filament to a metal plate within the bulb, but only when the plate was positively charged. He patented the findings, unsure what caused them. (The electron had not been discovered; J. J. Thomson identified it in 1897. Edison's discovery is now called thermionic emission. The carbon was a separate effect, caused by carbon evaporating from the hot filament.)
- **1897:** J. J. Thomson identifies the electron as a particle. This is what later lets the Edison effect be understood.
- **1904:** Fleming, who had studied the Edison effect, builds the diode, which passes current one way only. He sees it as a detector for radio waves.
- **1906:** De Forest adds the grid (the triode). A voltage now controls a current, which gives amplification and fast switching.
- **1900s–1910s:** Telephone exchanges are built from relays and switching machines, which makes large networks of switches normal engineering.
- **1918:** Eccles and Jordan build the tube flip-flop. A circuit now stores one bit and holds its state until it is changed.
- **1937–38:** Claude Shannon shows that Boolean algebra describes relay and switch circuits exactly. Logic design now has a theory behind it.
- **1947:** The transistor. The logic and memory designs stay the same, but the switch under them becomes small, cool and cheap.

## How they were applied

- **1837–44:** Telegraph. Relays regenerate the signal along the line (Morse, Davy, Henry's work).
- **1900s–1930s:** Telephone exchanges and railway signalling use relays at large scale.
- **1906–1920s:** Radio detection and amplification with tubes. The 1915 transcontinental telephone line uses tube repeaters.
- **1937–40:** Stibitz's relay adder and Bell Labs' relay calculators.
- **1941:** Zuse's Z3, a programmable relay computer.
- **1942:** Atanasoff–Berry computer, a tube-based special-purpose calculator.
- **1943–44:** Colossus, designed by Tommy Flowers and used at Bletchley Park to break the German Lorenz cipher. It was a special-purpose machine built almost entirely from tubes (about 1,500 in the first version, about 2,400 in the second), doing Boolean logic and counting at electronic speed.
- **1944:** Harvard Mark I, an electromechanical calculator.
- **1943–46:** ENIAC, with over 17,000 tubes, built for artillery firing tables and unveiled in 1946.
- **Late 1940s–50s:** The first transistor computers replace tube machines.

## Why the transistor still mattered

Size, heat, power draw and failure rate set the limits of these machines. Tube filaments burned out, so ENIAC's size and reliability were limited by its tube count. Relay contacts wore out, and the machines were slow. The logic design was already known, so the transistor was a hardware replacement that made the same designs far faster, smaller and more reliable."
 :GROUP "switches" :PREREQS NIL :ERA 1906)
(:NODE :ID "symbolic-reasoning" :TITLE "Symbolic reasoning" :COMPRESSION
 "Represent facts as symbols and search through logical steps, and a program can prove theorems and plan."
 :BODY
 "This was the first serious bet on machine intelligence: if thinking is manipulating symbols, a program that manipulates symbols can think. It sets up everything the later eras reacted against.

Newell and Simon's Logic Theorist (1956) proved theorems by searching a tree of logical moves. McCarthy's Advice Taker (1958) proposed a program that holds facts as symbolic sentences and deduces what to do. Lisp was built for this work, because programs and symbol structures are the same kind of data (see Code as data).

The limit is that every fact and rule has to be written by a person, and search explodes combinatorially outside small, tidy domains."
 :GROUP "symbolic-ai" :PREREQS NIL :ERA 1956)
(:NODE :ID "expert-systems" :TITLE "Expert systems" :COMPRESSION
 "Encode a specialist's knowledge as if-then rules and let an inference engine chain them to reach conclusions."
 :BODY
 "Expert systems were the commercial peak of symbolic AI. They showed that narrow expertise could be turned into a program without solving general intelligence.

A knowledge base holds rules such as \"if the infection is X and the patient is Y, then suspect Z\". An inference engine matches rules against known facts and fires them, chaining conclusions. MYCIN (1976) diagnosed infections. DEC's XCON (1980) configured computer orders and saved the company millions. Lisp machines were sold to run this kind of software.

The cost was the knowledge bottleneck. Experts had to be interviewed and their know-how turned into rules by hand. The rules were brittle at the edges, and each one added had to be checked against the others."
 :GROUP "symbolic-ai" :PREREQS NIL :ERA 1980)
(:NODE :ID "ai-winters" :TITLE "The AI winters" :COMPRESSION
 "When promises outran what rules, data and hardware could deliver, funding collapsed, and the idea that waited was learning from data."
 :BODY
 "The winters show that an idea can be right and still fail because the machine under it is too small. They also explain why the learned era began when it did.

The first winter (mid-1970s) followed the Lighthill report and the limits of single-layer perceptrons that Minsky and Papert pointed out (1969). The second (1987 on) came when the Lisp-machine market collapsed and expert systems proved costly to maintain and brittle outside their narrow domains.

The lesson is that hand-written knowledge does not scale and that learning from data needed far more compute than existed. Backpropagation (1986) was available, but it took GPUs and large datasets (2012 on) to make it pay off."
 :GROUP "symbolic-ai" :PREREQS NIL :ERA 1987)
(:NODE :ID "integrated-circuit" :TITLE "The integrated circuit" :COMPRESSION
 "Build many transistors and their wiring on one piece of silicon, and a circuit becomes a manufactured part instead of an assembly of parts."
 :BODY
 "Wiring individual transistors by hand caps how complex a machine can be, because every connection is a place to fail. The integrated circuit removes that cap.

Kilby (1958) and Noyce (1959) showed that transistors, resistors and the wires between them can all be made on one slab of silicon in the same steps. Complexity then costs the same per step however many transistors are on the chip, which is what makes Shrinking switches possible and later the microprocessor."
 :GROUP "switches" :PREREQS NIL :ERA 1958)
(:NODE :ID "microprocessor" :TITLE "The microprocessor" :COMPRESSION
 "Put the whole CPU on a single chip, and a computer becomes a part you can buy for the price of a component."
 :BODY
 "Before 1971 a CPU was a board or a cabinet of chips. The Intel 4004 (1971) and then the 8080 and 6502 put registers, an adder and the fetch-decode-execute loop on one die.

The cost of a processor then follows the chip cost curve, so hobbyists and small firms can build machines around it. This is the step that makes The personal computer possible."
 :GROUP "surfaces" :PREREQS NIL :ERA 1971)
(:NODE :ID "scaling-laws" :TITLE "Scaling laws" :COMPRESSION
 "Model error falls smoothly and predictably as parameters, data and compute grow, so making models bigger becomes an engineering plan."
 :BODY
 "Kaplan et al. (2020) measured that loss on next-token prediction follows power laws in model size, dataset size and compute across many orders of magnitude. Training runs can therefore be planned by extrapolating from small ones.

This explains why the field shifted toward larger runs on GPUs: the returns were forecastable before the money was spent. Later work (Hoffmann et al., 2022) refined the balance between model size and data."
 :GROUP "learned" :PREREQS NIL :ERA 2020)
(:NODE :ID "reasoning-rl" :TITLE "Reasoning through reinforcement learning" :COMPRESSION
 "Train a model against outcomes that can be checked, and it learns to spend tokens working a problem out before it answers."
 :BODY
 "Post-training with human preferences teaches style and obedience. For math, code and puzzles the answer can be verified automatically, so a model can be rewarded for being right.

Reinforcement learning against that reward makes models produce long chains of intermediate steps, backtrack and check themselves (OpenAI o1, 2024; DeepSeek-R1, 2025). Capability then grows with compute spent at answer time as well as at training time."
 :GROUP "learned" :PREREQS NIL :ERA 2024)
(:NODE :ID "universal-machine" :TITLE "The universal machine" :COMPRESSION
 "One fixed machine can read the description of any other machine from its tape and imitate it, so a single device can do every computation."
 :BODY
 "This is why general-purpose computers exist at all: you need not build a new machine per task, only supply a new description.

Turing encoded a machine's rule table as symbols on a tape. A universal machine reads that encoded table plus the input, then step by step does what the described machine would do. Program and data are the same kind of thing: symbols to be read.

Every stored-program computer is this idea in hardware: the fetch-decode-execute loop is the universal machine, and the program in RAM is the description it imitates. It also explains why interpreters, emulators and virtual machines are possible.

Source: Turing, 'On Computable Numbers' (1936), section 6."
 :GROUP "stored-program" :PREREQS NIL :ERA 1936)
