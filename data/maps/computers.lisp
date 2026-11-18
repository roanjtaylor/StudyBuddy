(:MAP :ID "computers" :TITLE "Computers" :COMPRESSION
 "A switch controls a switch; everything else is layers of programs loading programs." :AXIS
 ((:FROM 1855 :TO 1905 :SCALE 0.15)) :KINDS (("hardware" "#e8833a") ("software" "#3b82f6")))
(:GROUP :ID "switches" :COMPRESSION "A switch can control another switch.")
(:GROUP :ID "stored-program" :COMPRESSION
 "Instructions are data in the same memory, and a theory of the machine says what it can compute and how fast the step count grows.")
(:GROUP :ID "loaders" :COMPRESSION
 "From the address a wire forces at power-on, every layer is a program that loads the next.")
(:GROUP :ID "sharing" :COMPRESSION
 "Many programs share one machine, and disk-shaped data structures make the shared data findable.")
(:GROUP :ID "languages" :COMPRESSION
 "Languages are compressions over machine code, built on tables and trees.")
(:GROUP :ID "symbolic-ai" :COMPRESSION
 "Intelligence as hand-written symbols and rules, which worked in narrow cases and hit the wall of combinatorial search.")
(:GROUP :ID "connectionism" :COMPRESSION
 "A function with adjustable weights can be fit to examples instead of being programmed.")
(:GROUP :ID "networks" :COMPRESSION
 "Machines talk: small addressed packets find their own way across a dumb federation of networks no one owns, graph algorithms route them, and on top a stateless text protocol and a renderer make a shared document space that becomes the application platform, gets ranked, and is served from rented slices of machines.")
(:GROUP :ID "surfaces" :COMPRESSION
 "As switches shrink and get cheaper, the computer moves from a shared room to the desk, the pocket, the wall and the face.")
(:GROUP :ID "learned" :COMPRESSION "Programs can be found, not written.")
(:NODE :KIND "hardware" :ID "transistor" :TITLE "Transistor as a switch" :COMPRESSION
 "A small voltage at one terminal lets or blocks a current between two others, so one signal can control another."
 :BODY
 "Every computer is billions of these and nothing else is physical; all the rest is arrangement. A transistor is a switch that no hand flips: a voltage does it. Because the output of one transistor can be the control input of the next, switches can be chained into logic, memory and arithmetic.

**How it works (the MOSFET, the type in chips):** a voltage on one leg creates or removes a conducting path between the other two. No voltage on the control leg means no path and the switch is off. Enough voltage means a path and the switch is on.

**The three legs**

- **Gate**: the control input. You apply the small voltage here. Almost no current flows into it.
- **Source**: where the current enters the switch.
- **Drain**: where the current leaves. The gate decides whether current can get from source to drain.

**The materials**

- **Conductor (metal or polysilicon)**: forms the gate electrode and the wires. Current flows freely.
- **Insulator (silicon dioxide or a modern high-k oxide)**: a very thin layer between the gate and the silicon. The gate's electric field passes through it, but current does not. This is why the gate draws almost no current.
- **Semiconductor (silicon)**: the borderline material, neither a good conductor nor a good insulator. Its conductivity can be changed:
  - Doping adds impurities that make regions rich in free electrons (n-type) or in missing electrons, called holes (p-type). The source and drain are one type, and the body between them is the other.
  - The gate's field pulls charge into the thin region under the oxide, called the channel. That turns the silicon from insulating to conducting, and current can flow from source to drain.

**How it is made**

Transistors are not assembled one by one. Billions are printed at once on a wafer by repeating a cycle of depositing a layer, patterning it with light, and etching or implanting through the pattern. The steps for a simple planar n-type transistor:

1. **Wafer**: start with a slice of ultra-pure single-crystal silicon, lightly doped p-type, polished flat.
2. **Gate insulator**: heat the wafer in oxygen so a few nanometres of silicon dioxide grow on the surface (modern chips deposit a high-k oxide instead).
3. **Gate electrode**: deposit a layer of polysilicon (or metal) over the oxide.
4. **Pattern the gate** (photolithography): coat with light-sensitive resist, shine light through a mask, wash away the exposed resist, then etch away the gate material everywhere the resist is gone. A small strip of gate stays.
5. **Source and drain**: fire dopant ions (for example phosphorus or arsenic) into the wafer. The gate strip blocks them, so the n-type source and drain form on either side of it, automatically lined up with the gate (self-aligned). Heating (annealing) repairs the crystal and activates the dopants. The p-type body is left between them.
6. **Wiring**: cover everything with insulating oxide, etch small holes down to the gate, source and drain, fill them with metal (tungsten) as contacts, then add many layers of copper wires, each separated by insulator, to connect transistors into circuits.

Smaller transistors need finer patterning (extreme-ultraviolet light in the newest chips) and different shapes: FinFETs and gate-all-around transistors wrap the gate around the channel for better control, but the idea of gate, oxide, channel, source and drain is the same.

**Off and on**

- Gate voltage low: no channel, so source and drain are isolated (off, a 0).
- Gate voltage high: a channel forms, so source and drain are connected (on, a 1).

Silicon is useful because its conductivity can be switched by a voltage. The oxide keeps the control signal separate from the current it controls."
 :GROUP "switches" :PREREQS NIL :ERA 1947)
(:NODE :KIND "hardware" :ID "logic-gates" :TITLE "Logic gates" :COMPRESSION
 "Two switches in series is AND, in parallel is OR, one that inverts is NOT; every other function is made of these."
 :BODY
 "A computer is just switches that control other switches, and wiring them in a few ways gives you logic: a claim about truth becomes a circuit. A logic gate is a circuit whose output is a fixed function of its inputs, where each signal is one of two voltage levels (low = 0, high = 1).

## The three basic gates

Each switch is a transistor: a voltage on its gate connects or disconnects a path.

- **AND**: two switches in series. Current flows only if A and B are both on.
- **OR**: two switches in parallel. Current flows if A or B is on.
- **NOT**: a switch to ground with a pull-up. On pulls the output to 0; off lets the output rise to 1.

| A | B | AND | OR | NAND | XOR |
|---|---|-----|----|------|-----|
| 0 | 0 | 0 | 0 | 1 | 0 |
| 0 | 1 | 0 | 1 | 1 | 1 |
| 1 | 0 | 0 | 1 | 1 | 1 |
| 1 | 1 | 1 | 1 | 0 | 0 |

NOT: 0→1, 1→0.

## Why a few gates are enough

NAND alone is functionally complete: NOT(A) = NAND(A,A); AND = NOT(NAND); OR(A,B) = NAND(NOT A, NOT B) (De Morgan). So any Boolean function, and any digital computer, can be built from one gate type. In CMOS, NAND and NOR are the cheapest gates, so chips use them.

From gates you get arithmetic (half adder: sum = A XOR B, carry = A AND B) and memory (two cross-coupled NORs make an SR latch).

## Common confusions

- **Gates are voltages, not software.** 0 and 1 are voltage ranges (for example, below 0.35 V reads as 0 and above 0.65 V as 1 on a 1 V supply), and the band between them is undefined. A gate's output is itself a voltage, driven firmly towards the supply or ground, so a sloppy input is restored to a clean level after a stage or two. This is why digital circuits tolerate noise.
- **Gates take time (propagation delay).** The delay is not the silicon \"warming up\"; carriers respond almost instantly. It is charging: the next transistor's gate and the wire are capacitors, and a transistor can supply only limited current, so the voltage rises along an RC curve. The next stage switches only when that voltage crosses its threshold. Delays add along a chain of gates, and the clock period must be longer than the slowest chain, which limits clock speed.

## Primary sources

- Boole, \"*An Investigation of the Laws of Thought*\" (1854)
- Shannon, \"*A Symbolic Analysis of Relay and Switching Circuits*\" (1937)"
 :GROUP "switches" :PREREQS ("transistor") :ERA 1938)
(:NODE :KIND "hardware" :ID "adder" :TITLE "Adding with gates" :COMPRESSION
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
(:NODE :KIND "hardware" :ID "clock" :TITLE "The clock" :COMPRESSION
 "A square wave tells every gate when to look at its inputs, turning a chaos of signals into a sequence of steps."
 :BODY
 "Gates are never instantaneous: after an input changes, an output wobbles for a moment before it settles. Without a shared beat, a computer would be a chaos of half-finished answers. The clock is a square wave that tells every flip-flop when to look at its input, so time inside a computer becomes discrete. Every \"cycle\" you ever hear about is one tick.

## How it works

- **Gates compute, flip-flops remember.** Combinational gates work out the next state (in a counter, \"Q + 1\"). Flip-flops hold the current state.
- **Only the rising edge counts.** On each rising edge, every flip-flop copies its D input into Q. Between edges, the gates are free to wobble, and nobody is looking.
- **The period has a floor.** The period must be longer than the slowest gate path plus the flip-flop's setup time. If it is shorter, a flip-flop copies an answer that isn't ready yet and the state goes wrong. This is why a CPU has a maximum clock speed. Shorter gate delays (smaller transistors) allow a faster clock.
- **Skew.** If the edge reaches some flip-flops later than others, the same problem appears from another direction. This is called clock skew.

## Where the clock comes from

It is a crystal **and** an oscillating circuit: the crystal sets the frequency, and the circuit keeps it going.

1. **Quartz crystal.** Quartz is piezoelectric: squeezing it makes a voltage, and a voltage makes it flex. A thin cut slice has a very sharp mechanical resonance set by its size, typically 8–50 MHz, or 32,768 Hz in watches. It has no power of its own. It is a very precise tuning fork that can be driven electrically.
2. **Sustaining circuit (a Pierce oscillator).** One inverter has its output fed back to its input through the crystal, with two small capacitors. The inverter amplifies noise, and the crystal passes back only energy near its resonance. The loop builds up and settles at that one frequency. A gate then squares the sine-like output into 0s and 1s.
3. **PLL (phase-locked loop).** Crystals top out at tens of MHz, so a 3 GHz CPU does not use a 3 GHz crystal. An on-chip voltage-controlled oscillator is divided down, compared with the crystal, and steered until it runs at an exact multiple (for example 100 MHz × 30). Changing the multiplier is how a CPU changes its speed.
4. **Clock tree.** Buffers arranged in a branching tree deliver the square wave to millions of flip-flops at nearly the same instant, to keep skew small.

A bare ring of inverters can also act as a clock, because its period is set by the gate delay. It is cheap but drifts with temperature and voltage, so it is used only where precision doesn't matter."
 :GROUP "switches" :PREREQS ("logic-gates") :ERA 1945)
(:NODE :KIND "hardware" :ID "flip-flop" :TITLE "Flip-flop as one bit of memory" :COMPRESSION
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
(:NODE :KIND "hardware" :ID "ram" :TITLE "RAM as an addressed grid" :COMPRESSION
 "A decoder turns an address number into one selected row of flip-flops you can read or overwrite."
 :BODY
 "Computers need somewhere to keep millions of values and a way to say *which one* — the answer is to give every place a number. That number, the address, is the first abstraction in computing; pointers, arrays, files and variables all descend from it.

## The mechanism

RAM is a grid. Each cell holds one bit in a tiny latch (a flip-flop-like loop of transistors that holds 0 or 1 as long as power is on). A row of cells is a *word*, for example 8 bits.

1. **Address in.** The address is just binary wires, e.g. A2 A1 A0 = 101 (5).
2. **Decoder.** A circuit of AND gates and inverters. Each output is an AND of the address bits, true or inverted, so exactly one output goes high. For 3 address bits, row 5 = A2 · ¬A1 · A0. That output is the *word line* for that row.
3. **Word line → access transistors.** The high word line switches on one transistor per cell in the row, joining each cell to a vertical *bit line*. All other rows stay disconnected. This is the core idea of the group: a switch (the decoder output) controls other switches (the access transistors).
4. **Read or write.** To read, sense amplifiers on the bit lines see each selected cell's stored voltage. To write, drivers force the bit lines to the new values and overwrite the latches in the selected row.

n address wires select among 2^n rows, so 30 wires reach about a billion words.

## Is the decoder a circuit or a protocol?

A circuit. It is pure combinational logic with no memory, no steps and no negotiation: change the address and the outputs follow after a few gate delays. A protocol is a set of agreed rules for timing and messages, such as how a CPU asks DRAM for data. A protocol sits *around* RAM and decides when the address and the read/write signals are valid. The decoder is the hardware that makes the address mean something.

## What it physically is

Real SRAM cells are not clocked D flip-flops. Each is 6 transistors: four form two cross-coupled inverters (the same feedback idea as an SR latch built from two NOR gates) and two are the access transistors. The word line is wired to their gates, and the bit lines run to their source/drain terminals. Gates are polysilicon, wiring is layered metal (copper in modern chips) separated by glass insulator, and the whole thing is patterned on silicon. DRAM, the main memory in most computers, stores the bit as charge on a capacitor with a single access transistor, so it needs periodic refreshing. The addressing scheme (decoder, word line, bit line) is the same.

## Why it matters

Because any address is reached in about the same time, the memory is called *random access*. A CPU can fetch anything by number without scanning through what comes before it. Every higher-level structure, such as an array index, a pointer or a file offset, is a number that eventually arrives at a decoder like this one."
 :GROUP "switches" :PREREQS ("flip-flop" "adder") :ERA 1968)
(:NODE :KIND "hardware" :ID "fetch-decode-execute" :TITLE "The fetch-decode-execute loop"
 :COMPRESSION
 "Read the word at the program counter, work out which operation it names, do it, move on, forever."
 :BODY "This loop is the whole CPU; everything else is speed. Nothing a computer does is not this."
 :GROUP "stored-program" :PREREQS ("ram" "clock") :ERA 1945)
(:NODE :KIND "hardware" :ID "registers-pc" :TITLE "Registers and the program counter" :COMPRESSION
 "A handful of fast words inside the CPU; one of them, the PC, holds the address of the next instruction."
 :BODY
 "The PC is the computer's single thread of attention. Jumps, calls and interrupts are all just writes to it."
 :GROUP "stored-program" :PREREQS ("flip-flop") :ERA 1945)
(:NODE :KIND "hardware" :ID "instruction-set" :TITLE "The instruction set" :COMPRESSION
 "The fixed menu of operations the hardware understands, each a bit pattern with fields naming the operation and its operands."
 :BODY
 "The ISA (instruction set architecture) is the contract between the hardware and every program ever written for it; change it and all software breaks.

ISA stands for **Instruction Set Architecture**: the \"instruction set\" is the menu of operations, and the \"architecture\" is everything a programmer can see and rely on, as distinct from how a particular chip implements it.

An instruction is a bit pattern split into fields: an opcode naming the operation (add, load, branch) and operand fields naming registers, memory addresses or constants. Because instructions are stored in memory as data, the processor fetches a pattern, decodes the fields, and executes it.

The ISA fixes the instructions, the registers, the data types, and how memory is addressed. It does not fix the circuitry, so many different chips (slow or fast, small or large) can implement the same ISA and run the same software.

**RISC vs CISC** are two styles of ISA. RISC (MIPS, ARM, RISC-V) has few simple instructions of fixed width, and only load/store touch memory, so decoding and pipelining are easy. CISC (VAX, x86) has many instructions of varying length, some doing a lot, with operands straight from memory. Modern x86 chips decode CISC instructions into RISC-like internal micro-operations, which shows the contract at work: the same ISA can run on very different circuitry."
 :GROUP "stored-program" :PREREQS ("fetch-decode-execute" "registers-pc") :ERA 1964)
(:NODE :KIND "software" :ID "machine-code-assembly" :TITLE "Machine code and assembly" :COMPRESSION
 "Assembly is machine code with names instead of numbers; an assembler is a lookup table inside a loop."
 :BODY "The first program that writes programs. From here on, programs are text." :GROUP
 "stored-program" :PREREQS ("instruction-set") :ERA 1949)
(:NODE :KIND "hardware" :ID "reset-vector-bootstrap" :TITLE "Reset vector and bootstrap"
 :COMPRESSION
 "At power-on the PC is forced to a fixed address in ROM, and whatever program sits there runs first."
 :BODY
 "There is no magic at startup, and no program can run before some program runs: the chain of loaders has to start somewhere, and this is where. The reset line forces the program counter to a fixed address wired into the CPU, that address lies in read-only memory, and whatever word sits there is fetched, decoded and executed like any other.

The program at that address is the first loader. It cannot assume anything, since RAM holds garbage and no device has been set up, so it does the least it can: bring the hardware to a known state, find a larger program on some storage, copy it into RAM and jump to it. Every layer after it (firmware, bootloader, kernel, shell) is a program that was loaded by the one before and whose main job is to load the next. The bootstrap is just the first link, and the only one chosen by a wire rather than by software."
 :GROUP "loaders" :PREREQS ("fetch-decode-execute") :ERA 1951)
(:NODE :KIND "software" :ID "code-and-data-alike" :TITLE "Code and data in one memory" :COMPRESSION
 "Instructions are just numbers in RAM, so a program can read, write and generate other programs."
 :BODY
 "Treating instructions as ordinary numbers in memory is what lets software build software: compilers, loaders, operating systems and interpreters all exist because a program can write bytes and then run them. The same openness is behind every buffer-overflow exploit.

**The mechanism.** In a stored-program (von Neumann) machine, instructions and data share one memory and one address space. The CPU fetches an instruction the same way it loads a number. So a program can read another program, modify it, or generate a new one, and then jump to it.

**The contrast: Harvard.** Early machines kept the program apart from the data. The Harvard Mark I (1944) read its instructions from punched paper tape, and ENIAC was programmed by rewiring cables and switches. In a Harvard design, instructions and data have separate memories, each with its own address space and usually its own bus. The CPU can fetch an instruction and access data in the same cycle, which is fast and predictable. But the running program cannot write new code, and changing the program means changing the physical medium.

**Why von Neumann won.** Von Neumann's *First Draft of a Report on the EDVAC* (1945) put the program into the same memory as the data. Programs then became something a computer could manipulate, so one machine could translate, load and run other programs, and could be reprogrammed in seconds. That is far more powerful than any fixed program tape. The price is that data can be executed as code, which is the root of code-injection attacks.

**Today's machines are hybrids.** A modern CPU has separate L1 instruction and data caches, which is Harvard-like for speed. Below that is one RAM, which is von Neumann. Memory protection (NX / W^X) takes back some of the openness: a page can be writable or executable, but not both. Microcontrollers such as AVR and PIC, and many DSPs, remain true Harvard designs."
 :GROUP "stored-program" :PREREQS ("fetch-decode-execute" "ram") :ERA 1945)
(:NODE :KIND "software" :ID "firmware-uefi" :TITLE "Firmware (BIOS/UEFI)" :COMPRESSION
 "The program in ROM at the reset vector: it checks the hardware, finds a disk, copies the next program into RAM and jumps to it."
 :BODY "The first loader. Everything after it is software that was loaded by software." :GROUP
 "loaders" :PREREQS ("reset-vector-bootstrap") :ERA 1981)
(:NODE :KIND "software" :ID "bootloader" :TITLE "The bootloader" :COMPRESSION
 "A small program whose only job is to find the kernel on disk, put it in memory and hand over the PC."
 :BODY
 "Each layer is too big for the layer below to load directly, so there is a chain of ever larger loaders."
 :GROUP "loaders" :PREREQS ("firmware-uefi") :ERA 1992)
(:NODE :KIND "software" :ID "kernel" :TITLE "The kernel" :COMPRESSION
 "The one program that runs with full power over the hardware and lends it, piece by piece, to every other program."
 :BODY "Everything you call 'the operating system' is this program plus the programs it loads."
 :GROUP "loaders" :PREREQS ("bootloader" "code-and-data-alike") :ERA 1969)
(:NODE :KIND "software" :ID "drivers" :TITLE "Device drivers" :COMPRESSION
 "Kernel code that turns 'write these bytes' into the exact register pokes one particular device needs."
 :BODY "Hardware diversity is hidden here, so every program above sees the same few verbs." :GROUP
 "loaders" :PREREQS ("kernel") :ERA 1969)
(:NODE :KIND "software" :ID "shell" :TITLE "The shell" :COMPRESSION
 "A program that reads a line, finds a program by that name, and asks the kernel to run it with the rest of the line as arguments."
 :BODY "The first user interface, and still the one every other is a wrapper around." :GROUP
 "loaders" :PREREQS ("kernel") :ERA 1971)
(:NODE :KIND "software" :ID "editor" :TITLE "The editor" :COMPRESSION
 "A program that holds a file in memory as text and writes it back; the tool every other program is written in."
 :BODY
 "Programs are text files, so the editor is where software is born, including the next editor."
 :GROUP "loaders" :PREREQS ("shell") :ERA 1976)
(:NODE :KIND "software" :ID "processes-threads" :TITLE "Processes and threads" :COMPRESSION
 "A process is a program plus its own memory; a thread is one program counter and stack inside it."
 :BODY "The unit the kernel shares the machine between. Everything you run is one of these." :GROUP
 "sharing" :PREREQS ("kernel" "registers-pc") :ERA 1965)
(:NODE :KIND "software" :ID "scheduler" :TITLE "The scheduler" :COMPRESSION
 "On a timer tick the kernel stops the running program, saves its registers, restores another's and jumps; 'at the same time' is a trick."
 :BODY "One CPU appears to be many. Concurrency bugs are this trick showing through." :GROUP
 "sharing" :PREREQS ("processes-threads" "clock") :ERA 1962)
(:NODE :KIND "software" :ID "virtual-memory" :TITLE "Virtual memory" :COMPRESSION
 "Every address a program uses is translated through a table the kernel owns, so each program sees its own private memory."
 :BODY
 "Virtual memory lets many programs share one machine safely (the MMU, or memory management unit, is a small piece of CPU hardware that translates every address a program uses into a real RAM address): each program believes it owns a huge private memory, programs cannot read or corrupt each other, and memory can be larger than RAM.

**Mechanism.** Programs use *virtual addresses*. On every load, store and instruction fetch, the hardware's MMU (the translator described above) translates the address using a **page table** owned by the kernel. Memory is split into fixed-size pages (usually 4 KB) that map to physical frames of RAM. Each process has its own table, so the same virtual address in two processes maps to different frames, or to nothing. A program has no address that reaches another's memory.

**Beyond RAM (demand paging).** Each page-table entry has a *present* bit. If the page is in RAM, access proceeds at full speed. If not, the CPU raises a **page fault** (an interrupt); the kernel loads the page from disk into a free frame, evicting another page if RAM is full, updates the table, and restarts the instruction. The program only notices the delay. Locality makes this workable: RAM acts as a cache for the disk. When the working set exceeds RAM, the system **thrashes**.

**Further ideas**
- **The illusion:** each program sees one flat address space (e.g. 2⁴⁸ bytes), not a slice of RAM. Frames are handed out dynamically and need not be contiguous.
- **The kernel decides** which pages sit in RAM and which sit on disk (swap space or the file itself), not the program.
- **TLB:** a small cache of recent translations. Without it, every access would need extra memory reads to walk the table.
- **Permission bits:** read/write/execute and user/kernel flags in each entry. The kernel can make code read-only and protect its own memory. An access to an unmapped or forbidden page causes a fault (segfault).
- **Deliberate sharing:** the kernel can map one physical frame into several processes (shared libraries, shared memory), and can map files into memory.
- **Limits:** virtual memory confines memory access only. Files, the network and system calls are controlled by separate permissions."
 :GROUP "sharing" :PREREQS ("ram" "processes-threads") :ERA 1962)
(:NODE :KIND "software" :ID "files" :TITLE "Files" :COMPRESSION
 "A name mapped to a sequence of bytes on a disk; a directory is a file that lists other files."
 :BODY
 "Programs die and power goes out, but data must not. Files give every program the same simple promise: put bytes under a name, and they will still be there later, whoever asks for them. Persistence and naming are one idea, and the kernel offers almost everything else through the same interface.

## The problem files solve

RAM is fast but forgets at power-off. A disk (SSD or hard drive) remembers, but it only offers numbered fixed-size blocks (typically 512 B to 4 KB). Nobody wants to remember \"my essay is in blocks 8812, 8813 and 40211\". The file system is the kernel layer that turns blocks into named, variable-length sequences of bytes.

## Mechanism

- **Inode.** Each file is described by a small record holding its size, owner, permissions, timestamps and the list of disk blocks that hold its bytes. The inode has no name.
- **Directory.** A directory is itself a file whose contents are a table of (name, inode number) pairs. A path like `/home/ana/essay.txt` is resolved by starting at the root directory, looking up `home`, reading that directory, looking up `ana`, and so on. Nesting names this way gives a tree.
- **Names are separate from files.** Because a directory entry only points to an inode, two names can point to the same file (a hard link). The file's blocks are freed when the last name is removed and no program still has it open.
- **File descriptor.** A program calls `open(path)` and gets back a small integer. Every later `read(fd, ...)` or `write(fd, ...)` uses that integer, and the kernel remembers the current position and checks permissions. The program never sees blocks.
- **Permissions.** The inode records who may read, write or execute. Since many programs and users share one disk, this is how the kernel enforces who may touch what.

## Everything is a file

The open/read/write/close interface turned out to fit far more than disks. Keyboards, terminals, pipes between programs, network sockets and kernel information (`/proc`) can all be opened and read as byte streams. A program written to read a file can often read from a pipe or a device unchanged. This is the main reason the idea generates so much of the rest of the system. Ritchie and Thompson describe it in \"The UNIX Time-Sharing System\" (CACM, 1974).

## Speed and safety

- **Page cache.** Disks are far slower than RAM, so the kernel keeps recently used file data in memory. A `write` usually returns once the data is in the cache, not once it is on the disk.
- **Durability.** `fsync` forces the data to the disk. Without it, a crash can lose recent writes.
- **Crash consistency.** Adding a file touches several structures: the directory, the inode and the data blocks. A crash halfway through could leave them inconsistent. Journaling (and copy-on-write file systems) first record the intended change so it can be finished or undone after a crash.

## What a file is not

A file is just bytes. The kernel does not know whether it holds text, an image or a program. Structure comes from the programs that read it. Databases build tables, indexes and transactions on top of files to get what plain files don't give."
 :GROUP "sharing" :PREREQS ("kernel" "drivers") :ERA 1965)
(:NODE :KIND "software" :ID "syscall-boundary" :TITLE "The system call boundary" :COMPRESSION
 "A program asks the kernel for something with a special instruction that raises privilege, passes a number, and drops it again on return."
 :BODY
 "The only door between a program and the hardware. Every library call eventually ends here or stays in user space."
 :GROUP "sharing" :PREREQS ("kernel" "instruction-set") :ERA 1969)
(:NODE :KIND "software" :ID "os-as-referee" :TITLE "The OS as referee" :COMPRESSION
 "The kernel exists to share the hardware fairly and keep programs from touching each other; everything else it does is convenience."
 :BODY
 "Many programs share one CPU, one pool of RAM and one set of devices, and none can be trusted. Without a referee, one bug could hog the CPU, overwrite another program's memory or corrupt the disk. The **kernel**, the core of the OS, is that referee.

## Two jobs

1. **Share**: split the machine among programs.
2. **Protect**: stop programs harming each other or the kernel.

Stack: hardware, then kernel, then all programs. The shell, desktop and bundled apps are ordinary programs that ask the kernel for things. The kernel *is* the handling layer; there is no layer between it and the apps.

## Enforcement (hardware-backed)

- **Privilege modes**: kernel can do anything; user programs can't touch devices or others' memory.
- **Syscalls**: a program traps into the kernel at a fixed entry point; the kernel checks the request, then does it or refuses.
- **Timer interrupt**: forces control back to the kernel, so no program can keep the CPU.
- **MMU**: kernel sets page tables; hardware checks every memory access.

## What it manages

| Resource | Kernel mechanism | Idea |
|---|---|---|
| CPU | Scheduler time-slices | Time-sharing |
| Memory | Virtual memory: private address spaces via page tables | Isolation |
| Storage | File system: blocks become named files with permissions | Abstraction |
| Devices | Drivers and interrupts behind a uniform interface | Abstraction |
| Processes | Create, pause, end; IPC and synchronisation | Containment |
| Permissions | Identity and rights checked on each request | Protection |

Two moves repeat: **abstraction** (a file instead of raw blocks) and **multiplexing with isolation** (each program feels it owns the resource).

## Examples

- **Two programs, one core**: the timer fires, the kernel saves one program's registers, loads the other's, and resumes it.
- **Same address, different data**: address 0x1000 in two processes maps to different RAM. An address a process doesn't own causes an MMU fault, and the kernel kills just that process.
- **Saving a file**: `write()` traps in, the kernel checks permissions, and the disk driver writes blocks.
- **Keystroke**: interrupt, then the kernel handler routes it to the focused program only.
- **Crash**: the kernel reclaims the dead program's memory and files; the others carry on."
 :GROUP "sharing" :PREREQS ("scheduler" "virtual-memory" "syscall-boundary") :ERA 1969)
(:NODE :KIND "software" :ID "compiler-vs-interpreter" :TITLE "Compiler versus interpreter"
 :COMPRESSION
 "A compiler translates a whole program into machine code once; an interpreter reads and performs it a piece at a time while it runs."
 :BODY
 "The two ways a text becomes behaviour. Everything from Python to the CPU's own microcode sits somewhere between."
 :GROUP "languages" :PREREQS ("machine-code-assembly" "code-and-data-alike") :ERA 1957)
(:NODE :KIND "software" :ID "call-stack" :TITLE "The call stack" :COMPRESSION
 "Each function call pushes its return address and locals; a return pops them, so calls nest and recursion is free."
 :BODY
 "Functions, locals and recursion are all this one data structure. A stack overflow is it running out."
 :GROUP "languages" :PREREQS ("registers-pc" "ram") :ERA 1960)
(:NODE :KIND "software" :ID "garbage-collection" :TITLE "Garbage collection" :COMPRESSION
 "Memory a program can no longer reach is found by walking from the roots and freed automatically."
 :BODY
 "Removes a whole class of bugs by making the runtime, not the programmer, account for memory."
 :GROUP "languages" :PREREQS ("call-stack") :ERA 1959)
(:NODE :KIND "software" :ID "code-as-data" :TITLE "Code as data" :COMPRESSION
 "When programs are written as the language's own data structures, a program can read, build and rewrite programs."
 :BODY "Macros, interpreters-in-the-language and the whole bottom-up style follow from it." :GROUP
 "languages" :PREREQS ("compiler-vs-interpreter" "code-and-data-alike") :ERA 1960)
(:NODE :KIND "software" :ID "image-and-repl" :TITLE "The image and the REPL" :COMPRESSION
 "A running program reads a form, evaluates it inside itself and prints the result, so it grows while it runs, and its whole state, compiler included, can be saved to disk and resumed."
 :BODY
 "Most programs are rebuilt from source and restarted from nothing. A Lisp system works the other way: the program stays alive, and you change it from the inside. This is why the language, the editor and the running program can all be one thing.

**The REPL.** Read a form, evaluate it inside the running program, print the result, loop. Because code is data (see Code as data), the reader turns text into the same structures the evaluator runs. A new function defined at the prompt joins the program immediately, with no restart and no separate build step.

**The image.** Because the compiler and evaluator are part of the running program, everything the program has become is just memory: functions, data, and the compiler itself. Dump that memory to disk and you have an image. Load the image later and the program resumes exactly where it was, with everything you defined still there.

**Together.** The REPL grows the program while it runs. The image keeps what it grew. Development is then a conversation with a live system rather than a cycle of edit, compile and run."
 :GROUP "languages" :PREREQS ("code-as-data") :ERA 1962)
(:NODE :KIND "software" :ID "types" :TITLE "Types" :COMPRESSION
 "A type is a claim about what a value is, checked before a run (static) or during it (dynamic) so wrong combinations are caught."
 :BODY
 "The main tool for making a compiler catch your mistakes, and the main argument in language design."
 :GROUP "languages" :PREREQS ("compiler-vs-interpreter") :ERA 1973)
(:NODE :KIND "software" :ID "packets-ip" :TITLE "Packets and IP" :COMPRESSION
 "A message is cut into addressed envelopes that each find their own way across the network; nothing in the middle keeps state."
 :BODY
 "Statelessness in the middle is why the internet scales and why it can lose, duplicate or reorder anything."
 :GROUP "networks" :PREREQS ("os-as-referee") :ERA 1974)
(:NODE :KIND "software" :ID "tcp" :TITLE "TCP" :COMPRESSION
 "Number the packets, acknowledge each, resend the lost ones, and an unreliable network becomes a reliable ordered stream."
 :BODY "Reliability is built on top of unreliability, in software, at the edges." :GROUP "networks"
 :PREREQS ("packets-ip") :ERA 1974)
(:NODE :KIND "software" :ID "sockets" :TITLE "Sockets" :COMPRESSION
 "The kernel's file-like handle for a network connection: open, read, write, close." :BODY
 "A connection to another machine becomes just another thing a program reads and writes." :GROUP
 "networks" :PREREQS ("tcp" "files" "syscall-boundary") :ERA 1983)
(:NODE :KIND "software" :ID "http" :TITLE "HTTP" :COMPRESSION
 "A text request naming a resource, a text response carrying it; stateless, one exchange at a time."
 :BODY
 "The lingua franca of the web, and why every web app has to invent its own way to remember you."
 :GROUP "networks" :PREREQS ("sockets") :ERA 1991)
(:NODE :KIND "software" :ID "browser-as-renderer" :TITLE "The browser as renderer" :COMPRESSION
 "A program that fetches text over HTTP, parses it into a tree, and paints the tree." :BODY
 "The browser is a document viewer that got a programming language; everything on the web is drawn by it."
 :GROUP "networks" :PREREQS ("http") :ERA 1990)
(:NODE :KIND "software" :ID "client-server" :TITLE "Client and server" :COMPRESSION
 "One program waits and answers; many programs ask. Where the state lives decides what the program is."
 :BODY
 "The shape of almost every networked system, and the question behind every architecture argument."
 :GROUP "networks" :PREREQS ("sockets") :ERA 1984)
(:NODE :KIND "software" :ID "web-as-app-platform" :TITLE "The web as application platform"
 :COMPRESSION
 "Send the browser a program along with the page, and the server becomes the thing the program talks to."
 :BODY
 "Turns a document viewer into the universal runtime; most software you use arrives this way."
 :GROUP "networks" :PREREQS ("browser-as-renderer" "client-server") :ERA 1995)
(:NODE :KIND "software" :ID "neuron-weighted-sum" :TITLE "The neuron as a weighted sum"
 :COMPRESSION
 "Multiply each input by a weight, add them up, squash the result: a tiny adjustable function."
 :BODY "The unit everything in machine learning is made of; there is no cleverness inside it."
 :GROUP "connectionism" :PREREQS ("adder") :ERA 1958)
(:NODE :KIND "software" :ID "gradient-training" :TITLE "Training by gradient descent" :COMPRESSION
 "Measure the error, compute how each weight moved it, nudge every weight the other way, repeat millions of times."
 :BODY
 "The program is not written; it is found by this loop. Learning is just optimisation with a lot of parameters."
 :GROUP "connectionism" :PREREQS ("neuron-weighted-sum") :ERA 1986)
(:NODE :KIND "software" :ID "transformer" :TITLE "The transformer" :COMPRESSION
 "Each token looks at every other token, weighs how much it matters, and mixes in what it finds; stacked many times, this reads."
 :BODY
 "The architecture behind every current language model; attention replaced recurrence and made training parallel."
 :GROUP "learned" :PREREQS ("gradient-training") :ERA 2017)
(:NODE :KIND "software" :ID "next-token" :TITLE "Next-token prediction" :COMPRESSION
 "Train on one objective: given the text so far, guess the next piece. Everything else emerges from doing that well."
 :BODY
 "The surprising fact of the era: one dumb objective at scale yields reasoning, code and conversation."
 :GROUP "learned" :PREREQS ("transformer") :ERA 2018)
(:NODE :KIND "software" :ID "model-as-loop-plus-weights" :TITLE "A model is a loop plus weights"
 :COMPRESSION
 "Inference is a fixed program running the same arithmetic over billions of learned numbers; the weights are the program."
 :BODY
 "Demystifies the model: a file of numbers and a short loop that applies them, nothing hidden."
 :GROUP "learned" :PREREQS ("next-token" "fetch-decode-execute") :ERA 2020)
(:NODE :KIND "hardware" :ID "gpu-inference" :TITLE "GPUs and inference" :COMPRESSION
 "Thousands of simple cores do the same multiply-add in lockstep, and a model's arithmetic fits that shape exactly."
 :BODY "Why models run on graphics cards and why compute, not ideas, bounds what can be trained.

how big would claude sonnet be if downloaded to query it locally on my laptop"
 :GROUP "learned" :PREREQS ("model-as-loop-plus-weights" "clock") :ERA 2012)
(:NODE :KIND "software" :ID "wrapper-as-app-layer" :TITLE "The wrapper as application layer"
 :COMPRESSION
 "A program that assembles context, calls the model, reads its answer and acts on it; the new shell."
 :BODY
 "Where the model meets the rest of the stack: tools, files, the web. Most AI products are this loop."
 :GROUP "learned" :PREREQS ("model-as-loop-plus-weights" "web-as-app-platform" "shell") :ERA 2022)
(:NODE :KIND "hardware" :ID "mainframe-terminals" :TITLE "Mainframes and terminals" :COMPRESSION
 "When a machine costs a building, many people share it through dumb terminals and the operating system rations it."
 :BODY
 "This is the starting surface, and it explains why sharing (scheduling, memory protection, privilege) was invented before personal computers existed. One expensive machine, many users at keyboards connected by wire; all the computing happens in the centre. Client and server later recreates this shape over the network."
 :GROUP "surfaces" :PREREQS NIL :ERA 1964)
(:NODE :KIND "hardware" :ID "scaling-moore" :TITLE "Shrinking switches" :COMPRESSION
 "Etching more transistors per chip makes each one cheaper and faster, and every new surface is that cost curve crossing a threshold."
 :BODY
 "The integrated circuit (1958) put many transistors on one slice; Moore's 1965 observation was that the count per chip kept doubling. Cheaper and lower-power switches are what made a minicomputer, then a desk machine, then a phone possible. The same programs-loading-programs stack moved onto each new size of machine."
 :GROUP "surfaces" :PREREQS NIL :ERA 1965)
(:NODE :KIND "hardware" :ID "personal-computer" :TITLE "The personal computer" :COMPRESSION
 "When a whole CPU fits on one chip, one person can own a machine, and the kernel's job shifts from rationing to serving one user."
 :BODY
 "The microprocessor (1971) made the CPU a single part. The home machine (Altair, Apple II, 1975-77) brought the loader chain, from ROM through disk to shell, to a desk, and made software a product."
 :GROUP "surfaces" :PREREQS NIL :ERA 1977)
(:NODE :KIND "hardware" :ID "gui" :TITLE "Bitmap display and pointer" :COMPRESSION
 "Treat the screen as a grid of memory the program paints and a pointer as an input device, and the machine can be operated by pointing instead of typing."
 :BODY
 "Xerox's Alto (1973) held the screen as pixels in RAM, so any program could draw anything. Windows, icons and mouse followed. This is the shell's successor for most people, and the browser later paints its tree the same way."
 :GROUP "surfaces" :PREREQS NIL :ERA 1973)
(:NODE :KIND "hardware" :ID "mobile-embedded" :TITLE "Phones and embedded computers" :COMPRESSION
 "With a battery, a radio and sensors added, the computer goes in the pocket or inside other things, and power budget becomes the main design constraint."
 :BODY
 "Microcontrollers (1970s) hide computers in cars, appliances and toys. The smartphone (2007) fuses a full OS, touch screen, GPS, camera and network into one device. Energy per operation, not speed, shapes its chips and its scheduler."
 :GROUP "surfaces" :PREREQS NIL :ERA 2007)
(:NODE :KIND "hardware" :ID "wearables-spatial" :TITLE "Wearables and spatial computing"
 :COMPRESSION
 "Glasses and headsets put the display on the face and sense the room, so the interface becomes the world around you."
 :BODY
 "The latest step in the same trend: smaller, closer, always on. Cameras and depth sensors track head and hands, and the program anchors drawings to places. It is the bitmap display and pointer idea with the screen replaced by your field of view."
 :GROUP "surfaces" :PREREQS NIL :ERA 2014)
(:NODE :KIND "software" :ID "computability" :TITLE "Turing machines and computability" :COMPRESSION
 "A simple machine reading and writing symbols on a tape can compute anything computable, and some questions, like whether a program halts, no program can answer."
 :BODY
 "Before building computers, Turing asked what 'computing' even means; his answer defines what every machine in this map can and cannot do.

A Turing machine is a head on an endless tape of cells. It has a finite table of rules: in state S, reading symbol X, write Y, move left or right, go to state T. That is all. Yet anything any computer can compute, this can compute too (the Church–Turing thesis: a claim about the word 'computable', not a theorem).

The limit: no program can decide, for every program and input, whether it will halt. If one could, feed it a program that does the opposite of whatever the decider predicts about it, and you get a contradiction. So some well-posed questions are unanswerable by any machine, however fast or large.

Source: Turing, 'On Computable Numbers, with an Application to the Entscheidungsproblem' (1936)."
 :GROUP "stored-program" :PREREQS NIL :ERA 1936)
(:NODE :KIND "software" :ID "databases" :TITLE "Databases" :COMPRESSION
 "Keep structured data in tables behind a query language, and let the system handle storage, concurrency and crash recovery."
 :BODY
 "A database is what you get when a system understands the meaning of your data, not just its bytes, and guarantees it stays correct while many programs change it at once. Most servers are mainly a database with a front door.

**Mechanism.** Codd's relational model (1970) separated what you ask from how it is stored: you write a declarative query (`WHERE age > 30`), and a planner picks the fastest route, using indexes (B-trees) rather than scanning every row. Data lives in tables with a schema, and keys and constraints enforce integrity. Underneath are ordinary files, plus a write-ahead log for crash recovery. Transactions (ACID) let many programs change shared state without corrupting it: atomic (all or nothing), consistent, isolated (via locks or versions), durable (the log survives a crash).

**Why a file system doesn't qualify.** A file system is itself a kind of database, a hierarchical key-value store (path → bytes), and NTFS (New Technology File System, Microsoft's default Windows file system) uses database-like structures internally. The difference is what it guarantees about the contents:

| | File system | Database |
|---|---|---|
| Knows about contents | No, just bytes | Yes, via schema and types |
| Find things | By path or name | By any property (`WHERE age > 30`) |
| Multi-step changes | None, so a crash mid-way leaves a mess | Atomic transactions |
| Concurrent writers | Last write wins, or file locks | Isolation |
| Integrity rules | None | Keys, constraints |

**Test:** can you say \"move £50 from A to B\" and be guaranteed that either both changes happen or neither does, even if power dies mid-way, while others read and write at the same time? A file system can't. A database can.

Two checks that separate them:
- **Query by content, not location.** Finding \"all users over 30\" in a file system means opening every file yourself. A database does it declaratively, using indexes.
- **Multi-object atomicity.** A file system's guarantees mostly cover its own metadata, such as a single rename. A database extends them to your data.

Loose definition: a database is a file system whose contents have meaning to the system, with transactions on top. Cloud or external storage is incidental; a database on one laptop is still a database."
 :GROUP "sharing" :PREREQS NIL :ERA 1970)
(:NODE :KIND "software" :ID "cloud-virtualization" :TITLE "Virtualization and the cloud"
 :COMPRESSION
 "A program that pretends to be a whole machine lets one physical computer be sliced and rented out as many."
 :BODY
 "A hypervisor does for whole operating systems what the kernel does for processes. Rented machines in data centres (2006 on) bring back the mainframe shape: thin clients such as phones talk to big shared computers."
 :GROUP "networks" :PREREQS NIL :ERA 2006)
(:NODE :KIND "software" :ID "cryptography" :TITLE "Cryptography and trust" :COMPRESSION
 "Public-key mathematics lets strangers share secrets and verify identity over a network that anyone can read."
 :BODY
 "Diffie and Hellman (1976) showed that two parties could agree on a key in public. Encryption, signatures and certificates make HTTPS, software updates and secure boot trustworthy, and they are why a signed bootloader can check the kernel it loads."
 :GROUP "networks" :PREREQS NIL :ERA 1976)
(:NODE :KIND "software" :ID "bits-representation" :TITLE "Bits and representation" :COMPRESSION
 "Anything, whether numbers, text, sound or pictures, can be stored as patterns of on/off switches, by agreeing on a code."
 :BODY
 "A switch only has two states, so every other kind of information has to be encoded in them. This is why one machine can handle everything.

Integers use place value in base 2, with a fixed width (8, 32, 64 bits) and two's complement for negatives. Text maps each character to a number (ASCII, Unicode). Fractions use a sign, exponent and mantissa (floating point). Colours, sound samples and pixels are numbers too.

The bits mean nothing by themselves. The same 32 bits can be an integer, a colour or an instruction, depending on what reads them. Shannon named the unit the *bit* in 1948."
 :GROUP "switches" :PREREQS NIL :ERA 1948)
(:NODE :KIND "hardware" :ID "caches" :TITLE "Caches and the memory hierarchy" :COMPRESSION
 "Small fast memory holds copies of recently used parts of big slow memory, and programs mostly reuse what they just touched."
 :BODY
 "CPUs run far faster than RAM can answer, so a CPU that fetched everything from RAM would mostly wait. The fix is a hierarchy: registers, then small caches, then RAM, then disk, each larger, slower and cheaper than the one before.

On each access the hardware checks the cache first. A hit returns quickly. A miss fetches a whole block from the level below and keeps it. This works because programs show locality: they reuse the same addresses soon (temporal) and touch nearby addresses next (spatial). Wilkes proposed the idea in 1965 as \"slave memory\"."
 :GROUP "stored-program" :PREREQS NIL :ERA 1965)
(:NODE :KIND "software" :ID "linking-loading" :TITLE "Linking and loading" :COMPRESSION
 "An executable file is a program plus instructions for placing it in memory, and a loader copies it in, fixes up addresses and jumps to its start."
 :BODY
 "Every layer in this chain must turn a file on disk into a running program. Compiled pieces are separate object files with unresolved references to each other's functions. A linker joins them and resolves those names to addresses.

The result is an executable with a header saying where the code and data go and where execution starts. The loader (in the kernel or the bootloader) maps those sections into memory, adjusts addresses if needed, and sets the PC to the entry point. Dynamic linking defers part of this to load time, so programs share libraries."
 :GROUP "loaders" :PREREQS NIL :ERA 1960)
(:NODE :KIND "hardware" :ID "interrupts" :TITLE "Interrupts" :COMPRESSION
 "Hardware can force the CPU to save its place and jump to a handler, so devices and timers get attention without the running program polling for them."
 :BODY
 "Without interrupts, a program would have to keep asking each device whether it needs anything. An interrupt is a signal from a timer, disk, network card or keyboard. The CPU finishes the current instruction, saves the PC and registers, and jumps to a handler address looked up in a table. When the handler finishes, execution resumes where it stopped.

The scheduler's timer tick, device drivers and the system call mechanism all work this way. Exceptions such as page faults and division by zero use the same path."
 :GROUP "sharing" :PREREQS NIL :ERA 1953)
(:NODE :KIND "software" :ID "concurrency-locks" :TITLE "Concurrency and locks" :COMPRESSION
 "When threads share memory, the result can depend on timing, so a lock lets only one thread at a time touch the shared piece."
 :BODY
 "When threads share memory, the answer a program gives can depend on luck. Locks are the standard way to take that luck out.

Threads can be switched at any instruction, so two threads that read, change and write the same variable can overwrite each other's work. If both read 0, both add 1 and both write, the result is 1, not 2. This is a race condition: the result depends on the relative timing of uncoordinated threads. It is hard to reproduce because the timing differs on every run.

A lock (Dijkstra's semaphore, 1965) lets one thread enter a critical section while the others wait. Atomic hardware instructions make the lock itself safe. Locks bring their own hazards: deadlock, where threads each wait for the other, and lost speed from waiting. Alternatives are message passing and immutable data.

**Relation to ACID.** Databases face the same problem and name the guarantees they want with the acronym ACID:

- **A**tomicity: a transaction happens entirely or not at all.
- **C**onsistency: the data's rules still hold afterwards.
- **I**solation: concurrent transactions behave as if they ran one at a time.
- **D**urability: once committed, the result survives a crash.

Locks are the classic mechanism for isolation (two-phase locking, Gray et al., 1976), and a critical section is atomic in the sense that no other thread sees it half-done. Consistency still depends on the programmer's rules. Durability is a separate matter of storage, which locks do not address."
 :GROUP "sharing" :PREREQS NIL :ERA 1965)
(:NODE :KIND "software" :ID "parsing-grammars" :TITLE "Parsing and grammars" :COMPRESSION
 "A grammar defines which strings are valid programs, and a parser turns text into a tree that the rest of the language machinery works on."
 :BODY
 "Compilers, interpreters, shells and browsers all begin by turning flat text into structure. A lexer first splits characters into tokens. A parser then applies grammar rules (written in BNF, introduced for Algol 60) to build a syntax tree that shows nesting and precedence.

Every later step works on the tree: type checking, code generation or direct evaluation. Languages that write code as their own data structures, like Lisp, make this step almost trivial."
 :GROUP "languages" :PREREQS NIL :ERA 1960)
(:NODE :KIND "software" :ID "dns-naming" :TITLE "Naming and DNS" :COMPRESSION
 "A distributed hierarchical directory maps human names to IP addresses, so no one machine has to know every name."
 :BODY
 "Packets travel by number, but people use names. DNS (Mockapetris, 1983) replaced a single shared hosts file with a tree of servers. Root servers point to servers for each top-level domain, which point to servers for each domain.

A resolver asks down the chain and caches the answers for a time given by the owner. Whoever controls a name's records controls where it leads, which is why DNS matters for security as well."
 :GROUP "networks" :PREREQS NIL :ERA 1983)
(:NODE :KIND "software" :ID "embeddings" :TITLE "Embeddings" :COMPRESSION
 "Each token becomes a learned vector of numbers, positioned so that things used in similar ways end up close together."
 :BODY
 "A network can only do arithmetic, so text has to become numbers. An embedding table gives each token a vector of hundreds or thousands of values, learned during training. Tokens that appear in similar contexts end up with similar vectors, and directions in the space come to carry meaning (word2vec, 2013).

The transformer's first step is looking up these vectors, and each layer then refines them using context. Embeddings of whole passages let programs search by meaning rather than by exact words."
 :GROUP "learned" :PREREQS NIL :ERA 2013)
(:NODE :KIND "software" :ID "post-training" :TITLE "Post-training" :COMPRESSION
 "After next-token pretraining, further training on examples and human preference signals turns a text continuer into an assistant that follows instructions."
 :BODY
 "A pretrained model continues any text, including a question with another question. Post-training changes its behaviour with further training. Supervised fine-tuning on example conversations teaches the format. Reinforcement from human or model feedback (RLHF, 2022) rewards answers people prefer.

The architecture is the same and only the weights shift. This step is what makes a model usable as the engine inside a wrapper."
 :GROUP "learned" :PREREQS NIL :ERA 2022)
(:NODE :KIND "software" :ID "boolean-algebra" :TITLE "Boolean algebra" :COMPRESSION
 "Logic reduces to arithmetic on 0 and 1 (AND, OR, NOT), so reasoning can be done by calculation, and later by circuits."
 :BODY
 "Boolean algebra is why a pile of switches can do reasoning: true and false become 1 and 0, and AND, OR and NOT become operations you can calculate with and simplify like ordinary algebra.

Boole (*The Laws of Thought*, 1854) gave the rules. Any statement built from AND, OR and NOT can be rewritten, simplified and checked by symbol manipulation. Shannon's 1938 thesis showed that switching circuits obey the same algebra, so a logical expression can be turned directly into a circuit, and a circuit can be simplified with algebra."
 :GROUP "switches" :PREREQS NIL :ERA 1854)
(:NODE :KIND "hardware" :ID "relay-vacuum-tube" :TITLE "Relays and vacuum tubes" :COMPRESSION
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
(:NODE :KIND "software" :ID "symbolic-reasoning" :TITLE "Symbolic reasoning" :COMPRESSION
 "Represent facts as symbols and search through logical steps, and a program can prove theorems and plan."
 :BODY
 "This was the first serious bet on machine intelligence: if thinking is manipulating symbols, a program that manipulates symbols can think. It sets up everything the later eras reacted against.

Newell and Simon's Logic Theorist (1956) proved theorems by searching a tree of logical moves. McCarthy's Advice Taker (1958) proposed a program that holds facts as symbolic sentences and deduces what to do. Lisp was built for this work, because programs and symbol structures are the same kind of data (see Code as data).

The limit is that every fact and rule has to be written by a person, and search explodes combinatorially outside small, tidy domains."
 :GROUP "symbolic-ai" :PREREQS NIL :ERA 1956)
(:NODE :KIND "software" :ID "expert-systems" :TITLE "Expert systems" :COMPRESSION
 "Encode a specialist's knowledge as if-then rules and let an inference engine chain them to reach conclusions."
 :BODY
 "Expert systems were the commercial peak of symbolic AI. They showed that narrow expertise could be turned into a program without solving general intelligence.

A knowledge base holds rules such as \"if the infection is X and the patient is Y, then suspect Z\". An inference engine matches rules against known facts and fires them, chaining conclusions. MYCIN (1976) diagnosed infections. DEC's XCON (1980) configured computer orders and saved the company millions. Lisp machines were sold to run this kind of software.

The cost was the knowledge bottleneck. Experts had to be interviewed and their know-how turned into rules by hand. The rules were brittle at the edges, and each one added had to be checked against the others."
 :GROUP "symbolic-ai" :PREREQS NIL :ERA 1980)
(:NODE :KIND "software" :ID "ai-winters" :TITLE "The AI winters" :COMPRESSION
 "When promises outran what rules, data and hardware could deliver, funding collapsed, and the idea that waited was learning from data."
 :BODY
 "The winters show that an idea can be right and still fail because the machine under it is too small. They also explain why the learned era began when it did.

The first winter (mid-1970s) followed the Lighthill report and the limits of single-layer perceptrons that Minsky and Papert pointed out (1969). The second (1987 on) came when the Lisp-machine market collapsed and expert systems proved costly to maintain and brittle outside their narrow domains.

The lesson is that hand-written knowledge does not scale and that learning from data needed far more compute than existed. Backpropagation (1986) was available, but it took GPUs and large datasets (2012 on) to make it pay off."
 :GROUP "symbolic-ai" :PREREQS NIL :ERA 1987)
(:NODE :KIND "hardware" :ID "integrated-circuit" :TITLE "The integrated circuit" :COMPRESSION
 "Build many transistors and their wiring on one piece of silicon, and a circuit becomes a manufactured part instead of an assembly of parts."
 :BODY
 "Wiring individual transistors by hand caps how complex a machine can be, because every connection is a place to fail. The integrated circuit removes that cap.

Kilby (1958) and Noyce (1959) showed that transistors, resistors and the wires between them can all be made on one slab of silicon in the same steps. Complexity then costs the same per step however many transistors are on the chip, which is what makes Shrinking switches possible and later the microprocessor."
 :GROUP "switches" :PREREQS NIL :ERA 1958)
(:NODE :KIND "hardware" :ID "microprocessor" :TITLE "The microprocessor" :COMPRESSION
 "Put the whole CPU on a single chip, and a computer becomes a part you can buy for the price of a component."
 :BODY
 "Before 1971 a CPU was a board or a cabinet of chips. The Intel 4004 (1971) and then the 8080 and 6502 put registers, an adder and the fetch-decode-execute loop on one die.

The cost of a processor then follows the chip cost curve, so hobbyists and small firms can build machines around it. This is the step that makes The personal computer possible."
 :GROUP "surfaces" :PREREQS NIL :ERA 1971)
(:NODE :KIND "software" :ID "scaling-laws" :TITLE "Scaling laws" :COMPRESSION
 "Model error falls smoothly and predictably as parameters, data and compute grow, so making models bigger becomes an engineering plan."
 :BODY
 "Kaplan et al. (2020) measured that loss on next-token prediction follows power laws in model size, dataset size and compute across many orders of magnitude. Training runs can therefore be planned by extrapolating from small ones.

This explains why the field shifted toward larger runs on GPUs: the returns were forecastable before the money was spent. Later work (Hoffmann et al., 2022) refined the balance between model size and data."
 :GROUP "learned" :PREREQS NIL :ERA 2020)
(:NODE :KIND "software" :ID "reasoning-rl" :TITLE "Reasoning through reinforcement learning"
 :COMPRESSION
 "Train a model against outcomes that can be checked, and it learns to spend tokens working a problem out before it answers."
 :BODY
 "Post-training with human preferences teaches style and obedience. For math, code and puzzles the answer can be verified automatically, so a model can be rewarded for being right.

Reinforcement learning against that reward makes models produce long chains of intermediate steps, backtrack and check themselves (OpenAI o1, 2024; DeepSeek-R1, 2025). Capability then grows with compute spent at answer time as well as at training time."
 :GROUP "learned" :PREREQS NIL :ERA 2024)
(:NODE :KIND "software" :ID "universal-machine" :TITLE "The universal machine" :COMPRESSION
 "One fixed machine can read the description of any other machine from its tape and imitate it, so a single device can do every computation."
 :BODY
 "This is why general-purpose computers exist at all: you need not build a new machine per task, only supply a new description.

Turing encoded a machine's rule table as symbols on a tape. A universal machine reads that encoded table plus the input, then step by step does what the described machine would do. Program and data are the same kind of thing: symbols to be read.

Every stored-program computer is this idea in hardware: the fetch-decode-execute loop is the universal machine, and the program in RAM is the description it imitates. It also explains why interpreters, emulators and virtual machines are possible.

Source: Turing, 'On Computable Numbers' (1936), section 6."
 :GROUP "stored-program" :PREREQS NIL :ERA 1936)
(:NODE :KIND "hardware" :ID "crystal-oscillator" :TITLE "Crystal oscillator" :COMPRESSION
 "A quartz slice resonates at one sharp frequency, and an inverter looped through it keeps that vibration going as a steady square wave."
 :BODY
 "Every clock needs a beat that does not drift, and quartz supplies it: it is piezoelectric, so a voltage makes it flex and flexing makes a voltage, with a mechanical resonance fixed by its cut and size (typically 8–50 MHz, or 32,768 Hz in watches).

A Pierce oscillator wires one inverter with the crystal between its output and input, plus two small capacitors to ground and a large bias resistor across the inverter. The inverter amplifies noise; the crystal passes back only energy near its resonance, so the loop builds up and settles at that one frequency. A gate then squares the sine-like signal into 0s and 1s.

A bare ring of inverters can also oscillate, with its period set by gate delay, but it drifts with temperature and voltage, so it is used only where precision does not matter."
 :GROUP "switches" :PREREQS NIL :ERA 1923)
(:NODE :KIND "hardware" :ID "pll" :TITLE "Phase-locked loop" :COMPRESSION
 "A fast on-chip oscillator is divided down, compared with the slow crystal and steered until it runs at an exact multiple of it."
 :BODY
 "Crystals top out at tens of MHz, yet a CPU runs at GHz, so the clock must be multiplied up on the chip.

A voltage-controlled oscillator (VCO) runs fast. A divider cuts its output by N. A phase detector compares that with the crystal reference, and a loop filter turns the difference into a control voltage that speeds up or slows the VCO. When the divided VCO matches the crystal, the loop is locked and the VCO runs at N times the crystal (25 MHz × 30 = 750 MHz). Changing N is how a CPU changes its speed."
 :GROUP "switches" :PREREQS NIL :ERA 1932)
(:NODE :KIND "hardware" :ID "clock-tree" :TITLE "Clock tree and skew" :COMPRESSION
 "Branching buffers of equal path length deliver the clock edge to millions of flip-flops at nearly the same instant."
 :BODY
 "One oscillator output cannot drive millions of flip-flop clock pins directly, and wires of different length delay the edge by different amounts. If some flip-flops see the edge late (skew), they may copy a neighbour's already-changed output, and the state goes wrong.

Chips therefore distribute the clock through a tree of buffers, each stage splitting into several branches, laid out so every path to a leaf has about the same length and delay. Skew eats into the period, so keeping it small is part of what sets the maximum clock speed."
 :GROUP "switches" :PREREQS NIL :ERA 1980)
(:NODE :KIND "software" :ID "fortran-vs-lisp" :TITLE "Two lineages: Fortran and Lisp" :COMPRESSION
 "Fortran compressed numeric formulas into fast machine code, while Lisp compressed symbolic reasoning into recursion on lists, and the two split on whether a language mirrors the machine or the mathematics."
 :BODY
 "Almost every later language design choice is a position between two early answers to the question of what a language is for, so knowing the split makes the rest of this group easier to place.

**Fortran (Backus and colleagues, 1957)** was built for scientists computing formulas. Its bet was that a compiler could turn `Y = A*X + B` into machine code as good as a skilled programmer's assembly. Data is arrays of numbers laid out as the hardware likes them, and control is loops and jumps. Speed is the goal, so the language stays close to the machine. The line runs on through Algol and C.

**Lisp (McCarthy, 1958; published 1960)** was built for the AI problem of the day, which was manipulating symbols and not crunching numbers. Its ingredients follow from that: lists as the one data structure, recursion as the main way to repeat, conditional expressions, memory freed automatically (garbage collection), and programs written as the same lists they operate on, so an `eval` function can be written in the language itself (code as data). The language is built from mathematical function definitions rather than from the machine's operations, so a running system is easy to extend, but it needs runtime machinery that costs speed.

| | Fortran | Lisp |
|---|---|---|
| Built for | numeric formulas | symbolic reasoning, AI |
| Core data | arrays of numbers | lists of symbols |
| Repeat by | loops | recursion |
| Memory | laid out by the programmer | allocated and collected automatically |
| Program is | text a compiler translates | data the language can build and run |
| Strength | speed, close to hardware | flexibility, close to the mathematics |

The split is not permanent. Later mainstream languages such as Python and JavaScript took garbage collection, first-class functions and interactive evaluation from the Lisp side, while keeping Fortran-style loops and arrays. Types, parsing and the call stack all have to be settled differently depending on which lineage a language follows.

Primary sources: Backus et al., *The FORTRAN Automatic Coding System* (1957); McCarthy, *Recursive Functions of Symbolic Expressions and Their Computation by Machine, Part I* (CACM, 1960)."
 :GROUP "languages" :PREREQS NIL :ERA 1958)
(:NODE :KIND "software" :ID "pagerank-search" :TITLE "Search and PageRank" :COMPRESSION
 "Once the web is a graph of billions of linked pages, treat links as votes: a page is important if important pages link to it, computed by passing rank along links until it settles."
 :BODY
 "HTTP and the browser produced billions of linked pages, and finding the right one became the problem; the link graph itself carries the answer. PageRank (Brin and Page, 1998) ranks pages by structure rather than by their words.

The mechanism is a random surfer who follows a random outgoing link, and with probability about 0.15 jumps to a random page. The share of time spent on each page is its rank. Compute it by starting every page with equal rank and repeating `rank(p) = (1-d)/N + d * sum(rank(q)/outlinks(q))` over all pages q linking to p, with d about 0.85, until the values stop changing. This is repeated multiplication of a vector by a huge sparse matrix.

A search engine pairs this with a crawler (a browser-like program that fetches pages and follows links) and an inverted index (word to list of pages). Ranking combines text match with link rank. Later systems blend PageRank with many learned signals.

Primary sources: Brin and Page, 'The Anatomy of a Large-Scale Hypertextual Web Search Engine' (1998); Page, Brin, Motwani and Winograd, 'The PageRank Citation Ranking: Bringing Order to the Web' (1999)."
 :GROUP "networks" :PREREQS NIL :ERA 1998)
(:NODE :KIND "software" :ID "complexity-big-o" :TITLE "Complexity and Big-O" :COMPRESSION
 "Count the steps a procedure takes as the input grows; the growth rate, not the machine's speed, decides what the stored-program machine can usably do."
 :BODY
 "The universal machine can compute anything computable, but faster hardware only buys a constant factor, so what decides whether a program is usable at scale is how its step count grows with input size. Computability says what the machine can do at all; complexity says what it can do before you die waiting.

Count basic steps as a function of n and keep the dominant term: n, n log n, n squared, 2 to the n. Doubling the input doubles a linear program's work, quadruples a quadratic one's, and squares an exponential one's. A million items is trivial at n log n (about 20 million steps) and impossible at n squared on a slow machine. This is why a clever procedure can matter more than a faster clock: the same fetch-decode-execute loop runs both, and only the step count differs.

Source: Hartmanis and Stearns, \"On the Computational Complexity of Algorithms\" (1965)."
 :GROUP "stored-program" :PREREQS NIL :ERA 1965)
(:NODE :KIND "software" :ID "divide-and-conquer" :TITLE "Divide and conquer" :COMPRESSION
 "Split a problem in half, solve each half the same way, and combine; von Neumann wrote it as the first program for the stored-program machine, and the recursion turns n squared work into n log n."
 :BODY
 "The first program written for a stored-program machine was a sort: von Neumann's merge sort for the EDVAC in 1945, written to show what the design in his report could do. It also shows the pattern that makes many problems cheap: cut them into smaller copies of themselves, because halving only takes log n times, and a program in memory can call itself.

Merge sort splits a list, sorts each half recursively, then merges two sorted lists in one pass. There are log n levels of splitting and each level does n work, so n log n in total. Binary search is the same idea: halve the sorted range each step, so a million entries need about 20 looks. The recursion is free once a call stack exists, which is why the idea and the stack grew up together.

Source: von Neumann's merge sort (1945), described in Knuth, The Art of Computer Programming vol. 3."
 :GROUP "stored-program" :PREREQS NIL :ERA 1945)
(:NODE :KIND "software" :ID "hash-tables" :TITLE "Hash tables" :COMPRESSION
 "Compute an address from the key itself, so a name is looked up in one jump; invented for the assembler's symbol table, it is the dictionary under every language."
 :BODY
 "RAM finds any cell in one step given its address, but an assembler or compiler needs to find a name. A hash table gives names the same power by turning a key such as `loop_start` into an address, and it was invented at IBM in 1953 for exactly that: the symbol table of an assembler.

A hash function scrambles the key into a number, and that number modulo the table size picks the slot. Different keys sometimes land on the same slot, so each slot holds a short list or the table probes the next slot. With a good function and a table that is not too full, lookup, insert and delete take about one step, whatever the size. Every language's variable environment, every interpreter's dictionary, every cache and every database join rests on this.

Source: Luhn's internal IBM memo (1953); Knuth, TAOCP vol. 3, ch. 6.4."
 :GROUP "languages" :PREREQS NIL :ERA 1953)
(:NODE :KIND "software" :ID "btree-indexes" :TITLE "B-trees and indexes" :COMPRESSION
 "Keep keys in a wide, shallow, sorted tree whose nodes match disk blocks, so a database finds one row among billions in a few reads."
 :BODY
 "Databases promised to answer a query without scanning every row, and the B-tree is what makes the promise good. Disks are slow and read whole blocks, so the cost to minimise is the number of blocks read, not the number of comparisons. A B-tree makes each node a block holding hundreds of sorted keys, so the tree is only three or four levels deep even for billions of entries.

Search reads the root, picks the child whose range contains the key, and repeats. Inserts split full nodes and keep the tree balanced. This is the index behind every database table, and it is also how many file systems store directories, so the same structure serves both of the sharing group's stores of named data.

Source: Bayer and McCreight, \"Organization and Maintenance of Large Ordered Indexes\" (1970/1972)."
 :GROUP "sharing" :PREREQS NIL :ERA 1970)
(:NODE :KIND "software" :ID "shortest-paths-graphs" :TITLE "Graph algorithms and shortest paths"
 :COMPRESSION
 "Model connections as nodes and edges, and a systematic traversal finds the cheapest route; this is how routers decide where each packet goes next."
 :BODY
 "A network is a graph, and a packet that must find its own way needs someone to have computed the way. Dijkstra's algorithm, published fifteen years before IP, is what routers run on their map of links to fill the forwarding tables that packets consult.

Dijkstra's algorithm keeps a frontier of nodes ordered by distance so far. It always settles the nearest unsettled node and relaxes its neighbours, which gives shortest paths from one source in about E log V steps. Internet routing protocols such as OSPF run this on the network's link map; RIP uses the related Bellman-Ford method. Maps, dependency graphs and the web's link structure are graphs too, so the same traversal serves routing, reachability and, in PageRank, ranking.

Source: Dijkstra, \"A Note on Two Problems in Connexion with Graphs\" (1959)."
 :GROUP "networks" :PREREQS NIL :ERA 1959)
(:NODE :KIND "software" :ID "np-completeness" :TITLE "P vs NP" :COMPRESSION
 "Some problems can be checked quickly yet seem to have no fast way to solve them, and thousands of important ones are equally hard: the wall that symbolic search ran into."
 :BODY
 "Symbolic reasoning works by searching through logical steps, and the search space grows exponentially with the problem. Complexity theory explained in 1971 why no cleverness in the rules was going to fix that, and it marks where better algorithms stop paying off.

P is the set of problems solvable in polynomial time. NP is the set whose proposed answers can be checked in polynomial time. Cook showed that satisfiability, the core problem of logical reasoning, is NP-complete: a fast solver for it would give a fast solver for every problem in NP. Karp then showed that routing, scheduling, packing and planning problems are all equally hard. Whether P equals NP is still open. Practical programs live with it by using heuristics, approximations and, later, learned guesses about where to look. Public-key cryptography turns the wall into a wall for attackers, betting that certain related problems stay hard.

Sources: Cook, \"The Complexity of Theorem-Proving Procedures\" (1971); Karp, \"Reducibility Among Combinatorial Problems\" (1972)."
 :GROUP "symbolic-ai" :PREREQS NIL :ERA 1971)
(:NODE :KIND "software" :ID "packet-switching" :TITLE "Packet switching" :COMPRESSION
 "Cut a message into small blocks and let each hop store it and forward it toward its destination, so lines are shared and no path has to be reserved or survive."
 :BODY
 "The telephone network reserved a circuit for each call: a wire's worth of capacity held for the whole conversation, idle during every pause, and gone if any link on the path failed. Paul Baran (RAND, 1964) and Leonard Kleinrock (MIT, 1961) independently proposed the opposite, and every network since has been built on it.

The mechanism: the sender chops a message into blocks of a few hundred to a few thousand bytes, each carrying the destination address. A node receiving a block stores it briefly, picks whichever neighbour currently looks closest to the destination, and sends it on. No node knows the whole route; each makes one local decision per block. Blocks from thousands of conversations interleave on the same wire, so a line is busy whenever anyone has something to send, instead of being held idle by one caller.

Baran's argument was survivability: in a mesh with redundant links, a destroyed node merely changes which neighbour looks closest, and traffic flows around the hole. Kleinrock's was queuing theory: bursty computer traffic shares a line far better statistically than reserved circuits do. Both arguments turned out to be the same fact, that a network with no state in the middle is cheap and hard to kill.

The cost is that blocks can arrive out of order, duplicated, or not at all. Packet switching deliberately refuses to solve that; it is left to the endpoints, which is what TCP later does."
 :GROUP "networks" :PREREQS NIL :ERA 1964)
(:NODE :KIND "hardware" :ID "ethernet-lan" :TITLE "Ethernet and the local network" :COMPRESSION
 "Machines in one building share a single wire by sending framed bytes with hardware addresses and backing off on collision; an intranet is such local networks running IP without a gateway to the outside."
 :BODY
 "Before any machine can talk across the world it has to talk across the room, and the shape of that local link is the ground everything above it stands on. Robert Metcalfe's 1973 Xerox PARC memo described Ethernet: a single coaxial cable, every machine tapped into it, any machine free to transmit whenever the cable is quiet.

A transmission is a frame: a 48-bit destination address burned into the sender's network card, a 48-bit source address, a type field, the payload, and a checksum. Every card on the cable sees every frame and keeps only those addressed to it (or to all). If two machines start at once the signals collide; both detect it, stop, wait a random interval and retry, with the interval doubling on each repeat collision. No controller, no schedule, no reservation: order comes from randomness and retreat.

Modern Ethernet replaced the shared cable with a switch that learns which address lives on which port and forwards frames only there, so collisions vanish and speed scales; Wi-Fi is the same frame format over radio with the collision rule kept. But the abstraction the 1973 design fixed is unchanged: a link layer that delivers frames between hardware addresses on one local segment, and nothing more.

IP sits on top of this. An IP packet travelling to a machine in the same building is wrapped in one Ethernet frame; a packet going further is wrapped in a frame addressed to the router, which unwraps it and wraps it again for the next link. An intranet is simply a set of these local networks running IP among themselves, with no router announcing them to the rest of the world."
 :GROUP "networks" :PREREQS NIL :ERA 1973)
(:NODE :KIND "software" :ID "layering-end-to-end" :TITLE "Layering and the end-to-end principle"
 :COMPRESSION
 "Each protocol layer offers a simple service to the one above and knows nothing else, and anything that can only be done correctly at the endpoints is left to them, so the network itself stays dumb and growable."
 :BODY
 "The internet grew from a few dozen hosts to billions without anyone in the middle having to approve a new application, and the reason is a design discipline, not a technology. It was written down by Saltzer, Reed and Clark in 1981 (\"End-to-End Arguments in System Design\") and is the explanation for why Packets and IP, TCP, Sockets and HTTP are separate ideas instead of one.

Layering: each protocol is a program that takes the payload from the layer above, adds its own header, and hands the result to the layer below as opaque bytes. The link layer moves frames across one wire. IP moves packets across many wires to an address. TCP turns packets into a reliable stream. HTTP puts requests and responses in the stream. Each layer sees only the header it added and the service of the layer beneath; a router reads IP headers and never looks at TCP or HTTP, so a new application protocol needs no change to any router.

The end-to-end argument says where a function should go. Reliability, ordering, encryption, authentication: any of these implemented inside the network is still incomplete, because the endpoints cannot know the network did it right and must check anyway. So do it once, at the endpoints, and let the network do only what it alone can do, which is forwarding. The middle becomes cheap and generic; intelligence collects at the edges, in programs anyone can write.

The principle has a cost and a politics. Functions the network does not do (firewalls, address translation, traffic shaping) get bolted on later as 'middleboxes' that break the clean model, and the fight over whether carriers may look inside packets to treat them differently is the fight over whether the middle stays dumb."
 :GROUP "networks" :PREREQS NIL :ERA 1981)
(:NODE :KIND "software" :ID "routing-bgp" :TITLE "Routing between networks (BGP)" :COMPRESSION
 "Each independent network tells its neighbours which address blocks it can reach and through whom, so the internet's forwarding tables emerge from gossip among tens of thousands of networks that agree on nothing else."
 :BODY
 "Dijkstra's algorithm finds shortest paths when one party knows the whole graph, which is true inside one organisation's network and false for the internet, whose 75,000-odd networks are owned by rivals who will not share their maps. The Border Gateway Protocol (Lougheed and Rekhter, 1989) is how a route is nevertheless found across all of them.

The unit is the autonomous system: a network under one administration, with a number. Neighbouring systems open a TCP connection between their border routers and exchange announcements of the form 'I can reach address block 203.0.113.0/24, and the path to it goes through systems 64496, 64500, me'. A router receiving several announcements for the same block picks one, by policy first (which neighbour is a customer, which a paid provider) and path length second, installs it in its forwarding table, prepends its own number and passes the announcement on. Withdrawals propagate the same way when a link dies.

Nothing is global. No router knows the topology; each knows only paths its neighbours have offered. Yet the result converges, in seconds to minutes, to a table at every border router saying for each of about a million address blocks which neighbour to hand the packet to. That table is what Packets and IP rely on when they say each packet 'finds its own way'.

The design trusts every announcement, which is its weakness: a misconfigured or malicious network claiming a block it does not own can pull the world's traffic for that block into itself, and the cryptographic fixes (RPKI) are still being deployed decades later. The internet is a federation held together by this one protocol and the commercial agreements it encodes."
 :GROUP "networks" :PREREQS NIL :ERA 1989)
