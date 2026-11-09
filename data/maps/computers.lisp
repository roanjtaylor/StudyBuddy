(:MAP :ID "computers" :TITLE "Computers" :COMPRESSION
 "A switch controls a switch; everything else is layers of programs loading programs.")
(:GROUP :ID "switches" :COMPRESSION "A switch can control another switch.")
(:GROUP :ID "stored-program" :COMPRESSION "Instructions are data in the same memory.")
(:GROUP :ID "loaders" :COMPRESSION "Every layer is a program that loads the next.")
(:GROUP :ID "sharing" :COMPRESSION "Many programs share one machine.")
(:GROUP :ID "languages" :COMPRESSION "Languages are compressions over machine code.")
(:GROUP :ID "network" :COMPRESSION "Machines talk.")
(:GROUP :ID "learned" :COMPRESSION "Programs can be found, not written.")
(:NODE :ID "transistor" :TITLE "Transistor as a switch" :COMPRESSION
 "A small voltage at one terminal lets or blocks a current between two others, so one signal can control another."
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
 "XOR gives the sum bit and AND the carry; chain one per bit and you add numbers of any width.
XOR da el bit de suma y AND el acarreo; encadena uno por cada bit y podrás sumar números de cualquier ancho.
XOR donne le bit de somme et AND la retenue ; enchaîne-en un par bit et tu pourras additionner des nombres de n'importe quelle largeur.
XOR liefert das Summenbit und AND den Übertrag; verkette je Bit eines, und du kannst Zahlen beliebiger Breite addieren."
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
 "This is one bit of RAM. Memory is just a loop." :GROUP "switches" :PREREQS
 ("logic-gates" "clock") :ERA 1918)
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
(:NODE :ID "lisp-image" :TITLE "The Lisp image" :COMPRESSION
 "A running program whose entire state, including its own compiler, can be saved to disk and resumed."
 :BODY "Loading becomes resuming: the layer you edit is the layer that is running." :GROUP
 "loaders" :PREREQS ("editor" "code-and-data-alike") :ERA 1962)
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
 "Read a form, evaluate it inside the running program, print the result; the program grows while it runs."
 :BODY
 "Development without restarting. The program is a living thing you converse with, not a file you rebuild."
 :GROUP "languages" :PREREQS ("code-as-data" "lisp-image") :ERA 1962)
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
 :GROUP "learned" :PREREQS ("adder") :ERA 1943)
(:NODE :ID "gradient-training" :TITLE "Training by gradient descent" :COMPRESSION
 "Measure the error, compute how each weight moved it, nudge every weight the other way, repeat millions of times."
 :BODY
 "The program is not written; it is found by this loop. Learning is just optimisation with a lot of parameters."
 :GROUP "learned" :PREREQS ("neuron-weighted-sum") :ERA 1986)
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
