(:ID "2026-10-31T23:18:14#0" :MAP "computers" :NODE NIL :ROLE "you" :AT "2026-10-31T23:18:14" :TEXT
 "Quiz me across this field: five questions, answers hidden at the end." :CHANGES NIL)
(:ID "2026-10-31T23:19:01#1" :MAP "computers" :NODE NIL :ROLE "buddy" :AT "2026-10-31T23:19:01"
 :TEXT
 "Here's a quiz spanning the whole map. Write out your answers in full sentences before scrolling to the bottom.

## Questions

**1. (switches → stored-program)**
A flip-flop holds one bit. RAM is a grid of them. Explain how a single *number* (an address) gets you one specific row out of millions — what hardware sits between the address and the flip-flops, and what it does.

**2. (stored-program)**
Von Neumann's key move was putting code and data in the same memory. Name one thing this makes *possible* that would be impossible if instructions lived in a separate, unwritable memory. Be concrete about mechanism.

**3. (loaders)**
Trace the chain of programs from the instant you press the power button to the moment a shell prompt appears. Name each program and say what it hands to the next, and why nothing earlier can be skipped.

**4. (sharing)**
Your machine runs 300 processes on 8 cores. Two illusions are being maintained: that each process runs continuously, and that each has the whole memory to itself. Name the mechanism behind each illusion and the piece of hardware state it manipulates.

**5. (languages / learned)**
\"The weights are the program.\" Compare this to a traditional compiled program. In both cases, what is the fixed part and what is the varying part, and where does the behaviour actually *live*?

---
---
---

## Answers

**1.** A **decoder**. An address of *n* bits selects one of 2ⁿ rows: the decoder is a tree of gates that drives exactly one output line high for each input combination. That line enables one row of flip-flops onto the data lines, so you read or overwrite just that row. (*RAM as an addressed grid*, *Logic gates*.)

**2.** A program that **generates and runs new code** (a compiler writing machine code into RAM and jumping to it), or that **loads another program** off disk into RAM and executes it, or self-modifying code. Mechanism: because instructions are just numbers in writable RAM, a `store` can write a byte that `fetch` later reads as an instruction. With separate unwritable instruction memory, no running program could ever introduce new code. (*Code and data in one memory*.)

**3.** Power on → PC forced to the **reset vector** (fixed ROM address) → **Firmware (BIOS/UEFI)** runs there, checks hardware, finds a disk, copies the **bootloader** into RAM, jumps to it → bootloader finds the **kernel** on disk, loads it, hands over the PC → kernel initialises, loads **drivers**, starts the first process, which launches the **shell**. Nothing earlier can be skipped because each layer is too small to know where the next lives until the previous one puts it in memory — the reset vector is the only address the hardware knows on its own. (*Reset vector*, *Firmware*, *Bootloader*, *Kernel*, *Shell*.)

**4.** Continuous-running illusion: the **scheduler** — on a clock-timer tick the kernel saves the running process's **registers (including the PC)** and restores another's. Whole-memory illusion: **virtual memory** — every address a process emits is translated through a **page table** the kernel owns, mapping private virtual addresses to scattered physical RAM. (*The scheduler*, *Virtual memory*.)

**5.** Traditional program: fixed part = the data/input, varying part = hand-written instructions; behaviour lives in the *code*. Model: fixed part = the inference loop (same multiply-adds every time), varying part = billions of **weights** found by gradient descent; behaviour lives in the *numbers*. Both are a fixed machine running over data — the model just moves the \"program\" from instructions you wrote to numbers you found. (*A model is a loop plus weights*, *Compiler versus interpreter*, *Training by gradient descent*.)

No map changes — this was a quiz."
 :CHANGES NIL)
(:ID "2026-11-01T00:01:31#2" :MAP "computers" :NODE NIL :ROLE "you" :AT "2026-11-01T00:01:31" :TEXT
 "Create flashcards/" :CHANGES NIL :ARTIFACTS NIL :SOURCES NIL)
(:ID "2026-11-01T00:02:15#3" :MAP "computers" :NODE NIL :ROLE "buddy" :AT "2026-11-01T00:02:15"
 :TEXT
 "I'll build a deck covering the whole map — one card per idea, each testing the mechanism rather than the name.Made **Computers: the whole map** — 45 cards, one per idea, each cueing the mechanism (what the thing *does*) rather than just its name, so flipping forces you to reconstruct how it works. Flip, mark known, shuffle beside the chat."
 :CHANGES NIL :ARTIFACTS ("computers-the-whole-map") :SOURCES NIL)
(:ID "2026-11-01T00:05:20#4" :MAP "computers" :NODE NIL :ROLE "you" :AT "2026-11-01T00:05:20" :TEXT
 "Show me a diagram of a transistor." :CHANGES NIL :ARTIFACTS NIL :SOURCES NIL)
