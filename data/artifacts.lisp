(:ID "computers-the-whole-map" :MAP "computers" :NODE NIL :TYPE "flashcards" :TITLE
 "Computers: the whole map" :LANGUAGE NIL :CONTENT
 ((:NODE "transistor" :BACK
   "A small voltage at the **gate** lets or blocks current between the other two terminals — so one signal controls another, which is the whole basis for logic."
   :FRONT "What makes a transistor a *switch* a signal can control?")
  (:NODE "logic-gates" :BACK
   "Switches in **series = AND**, in **parallel = OR**, one that inverts = **NOT**. AND/OR/NOT compose into any Boolean function."
   :FRONT "How do you build every logic function from switches?")
  (:NODE "adder" :BACK
   "**XOR** → the sum bit, **AND** → the carry. Chain one such adder per bit (feeding carry forward) to add any width."
   :FRONT "Which gates give the sum and the carry when adding two bits?")
  (:NODE "clock" :BACK
   "A square wave tells every gate *when* to read its inputs, turning overlapping signal chaos into ordered discrete steps."
   :FRONT "What does the clock do, and why is it needed?")
  (:NODE "flip-flop" :BACK
   "Wired in a **loop**, each gate's output feeds the other's input, so the pair stays in one state until actively pushed — one bit of memory."
   :FRONT "How do two gates hold one bit?")
  (:NODE "ram" :BACK
   "A **decoder**: n address bits drive exactly one of 2ⁿ output lines high, enabling that one row of flip-flops onto the data lines to read or write."
   :FRONT "What turns an address *number* into one selected row of RAM?")
  (:NODE "fetch-decode-execute" :BACK
   "Read the word at the **PC**, decode which operation it names, execute it, advance the PC, repeat forever. This *is* what a CPU does."
   :FRONT "State the fetch-decode-execute loop.")
  (:NODE "registers-pc" :BACK
   "One of a handful of fast CPU registers; the **PC** holds the address of the next instruction to fetch."
   :FRONT "What is the program counter?")
  (:NODE "instruction-set" :BACK
   "The fixed menu of operations the hardware understands, each a **bit pattern** with fields naming the operation and its operands."
   :FRONT "What is an instruction set?")
  (:NODE "machine-code-assembly" :BACK
   "A **lookup table inside a loop**: it swaps mnemonic names for the matching machine-code bit patterns. Assembly is machine code with names."
   :FRONT "What is an assembler, mechanically?")
  (:NODE "reset-vector-bootstrap" :BACK
   "The hardware forces it to a fixed **reset vector** in ROM. That one known address is the only thing the machine knows on its own — bootstrapping starts there."
   :FRONT "Where does the PC point at power-on, and why does it matter?")
  (:NODE "code-and-data-alike" :BACK
   "Because **instructions are just numbers in the same RAM as data** — a store writes a byte that fetch later treats as an instruction."
   :FRONT "Why can a program read, write, and generate other programs?")
  (:NODE "firmware-uefi" :BACK
   "It's the program sitting at the reset vector: checks hardware, finds a disk, copies the next program (bootloader) into RAM, and jumps to it."
   :FRONT "What does the firmware (BIOS/UEFI) do?")
  (:NODE "bootloader" :BACK
   "Find the **kernel** on disk, load it into memory, and hand over the PC." :FRONT
   "What is the bootloader's single job?")
  (:NODE "kernel" :BACK
   "The one program running with full power over the hardware; it **lends that power, piece by piece**, to every other program."
   :FRONT "What is the kernel?")
  (:NODE "drivers" :BACK
   "Turns a generic request ('write these bytes') into the **exact register pokes** one particular device needs."
   :FRONT "What does a device driver do?")
  (:NODE "shell" :BACK
   "Reads the line, finds a program by that **name**, and asks the kernel to run it with the rest of the line as arguments."
   :FRONT "What does a shell do with a line you type?")
  (:NODE "editor" :BACK
   "It holds a file as text in memory and writes it back — it's the tool **every other program is written in**."
   :FRONT "Why is the editor special among programs?")
  (:NODE "lisp-image" :BACK
   "A running program whose **entire state, including its own compiler**, can be saved to disk and resumed."
   :FRONT "What is distinctive about a Lisp image?")
  (:NODE "processes-threads" :BACK
   "A **process** = a program plus its own private memory. A **thread** = one PC and stack running inside that process."
   :FRONT "Process vs thread?")
  (:NODE "scheduler" :BACK
   "On a **timer tick** the kernel stops the running program, saves its registers, restores another's, and jumps. Concurrency on few cores is time-slicing."
   :FRONT "How does the scheduler fake 'at the same time'?")
  (:NODE "virtual-memory" :BACK
   "**Virtual memory**: every address is translated through a **page table the kernel owns**, mapping private virtual addresses to scattered physical RAM."
   :FRONT "How does each program see its own private memory?")
  (:NODE "files" :BACK
   "A file = a **name mapped to a sequence of bytes** on disk. A directory = a file that lists other files."
   :FRONT "What is a file? A directory?")
  (:NODE "syscall-boundary" :BACK
   "A **system call**: a special instruction that raises privilege, passes a request number, runs kernel code, then drops privilege on return."
   :FRONT "How does a program safely ask the kernel for something?")
  (:NODE "os-as-referee" :BACK
   "To **share the hardware fairly** and keep programs from touching each other; everything else it offers is convenience."
   :FRONT "What is the kernel fundamentally *for*?")
  (:NODE "compiler-vs-interpreter" :BACK
   "A **compiler** translates the whole program to machine code once, ahead of time. An **interpreter** reads and performs it piece by piece while running."
   :FRONT "Compiler vs interpreter?")
  (:NODE "call-stack" :BACK
   "Each call **pushes** return address + locals, each return **pops** them. Nesting and **recursion** come for free from this LIFO discipline."
   :FRONT "What does the call stack make free?")
  (:NODE "garbage-collection" :BACK
   "It **walks from the roots** (stack, globals); anything no longer reachable is dead and reclaimed automatically."
   :FRONT "How does garbage collection decide what to free?")
  (:NODE "code-as-data" :BACK
   "When programs are written as the language's **own data structures**, a program can read, build, and rewrite programs (macros)."
   :FRONT "What does 'code as data' unlock?")
  (:NODE "image-and-repl" :BACK
   "**Read** a form, **evaluate** it inside the running program, **print** the result — the program grows while it runs."
   :FRONT "Describe the REPL loop.")
  (:NODE "types" :BACK
   "A **claim about what a value is**, checked before a run (**static**) or during it (**dynamic**) to catch wrong combinations."
   :FRONT "What is a type, and when is it checked?")
  (:NODE "packets-ip" :BACK
   "A message is cut into **addressed envelopes**, each finding its own way; the middle (routers) keeps **no per-connection state**."
   :FRONT "How do packets cross a network with no central memory?")
  (:NODE "tcp" :BACK
   "**Number** the packets, **acknowledge** each, **resend** the lost ones, **reorder** on arrival — yielding a reliable ordered stream."
   :FRONT "How does TCP make an unreliable network reliable?")
  (:NODE "sockets" :BACK
   "The kernel's **file-like handle** for a network connection: open, read, write, close." :FRONT
   "What is a socket?")
  (:NODE "http" :BACK
   "A **text request** naming a resource, a **text response** carrying it; **stateless**, one exchange at a time."
   :FRONT "Characterise HTTP in one line.")
  (:NODE "browser-as-renderer" :BACK
   "**Fetches** text over HTTP, **parses** it into a tree (the DOM), and **paints** that tree."
   :FRONT "What does a browser do, mechanically?")
  (:NODE "client-server" :BACK
   "One program **waits and answers** (server), many **ask** (clients). **Where the state lives** decides what each program really is."
   :FRONT "Client vs server — what decides which is which?")
  (:NODE "web-as-app-platform" :BACK
   "Sending the browser a **program along with the page**; the server becomes the thing that program talks to."
   :FRONT "What turned the web into an application platform?")
  (:NODE "neuron-weighted-sum" :BACK
   "**Multiply each input by a weight, sum, squash** the result — a tiny adjustable function."
   :FRONT "What is an artificial neuron?")
  (:NODE "gradient-training" :BACK
   "Measure the **error**, compute how each weight affected it (the gradient), **nudge each weight the opposite way**, repeat millions of times."
   :FRONT "How does gradient descent train weights?")
  (:NODE "transformer" :BACK
   "Each token **looks at every other token, weighs relevance (attention), and mixes in** what it finds; stacked many times, this reads."
   :FRONT "What does a transformer's core operation do?")
  (:NODE "next-token" :BACK
   "**Next-token prediction**: given the text so far, guess the next piece. Everything else emerges from doing that well."
   :FRONT "What is the single training objective behind LLMs?")
  (:NODE "model-as-loop-plus-weights" :BACK
   "Inference is a **fixed loop of the same arithmetic** over billions of **learned numbers**; behaviour lives in the weights, not hand-written code."
   :FRONT "In what sense are 'the weights the program'?")
  (:NODE "gpu-inference" :BACK
   "**Thousands of simple cores** do the same multiply-add in lockstep, and a model's arithmetic is exactly that shape."
   :FRONT "Why do GPUs fit model inference?")
  (:NODE "wrapper-as-app-layer" :BACK
   "A program that **assembles context, calls the model, reads the answer, and acts** — like a shell, it turns a request into action."
   :FRONT "What is an LLM 'wrapper', and why call it the new shell?"))
 :AT "2026-11-01T00:02:12" :VERSION 1)
(:ID "mosfet-as-a-switch" :MAP "computers" :NODE NIL :TYPE "svg" :TITLE "MOSFET as a switch"
 :LANGUAGE NIL :CONTENT
 "<svg viewBox=\"0 0 640 440\" xmlns=\"http://www.w3.org/2000/svg\" font-family=\"sans-serif\">
  <rect width=\"640\" height=\"440\" fill=\"#fbfbfd\"/>
  <text x=\"320\" y=\"34\" text-anchor=\"middle\" font-size=\"20\" font-weight=\"bold\" fill=\"#111\">N-channel MOSFET — one signal controls a current</text>

  <!-- Silicon body (p-type) -->
  <rect x=\"120\" y=\"230\" width=\"400\" height=\"150\" rx=\"6\" fill=\"#d9c3a5\" stroke=\"#8a7355\" stroke-width=\"2\"/>
  <text x=\"320\" y=\"368\" text-anchor=\"middle\" font-size=\"13\" fill=\"#6b5a40\">p-type silicon (body)</text>

  <!-- Source doped region -->
  <rect x=\"150\" y=\"230\" width=\"90\" height=\"70\" fill=\"#8fb7e0\" stroke=\"#4a79a8\" stroke-width=\"2\"/>
  <text x=\"195\" y=\"272\" text-anchor=\"middle\" font-size=\"13\" fill=\"#1d3a57\" font-weight=\"bold\">n+</text>
  <!-- Drain doped region -->
  <rect x=\"400\" y=\"230\" width=\"90\" height=\"70\" fill=\"#8fb7e0\" stroke=\"#4a79a8\" stroke-width=\"2\"/>
  <text x=\"445\" y=\"272\" text-anchor=\"middle\" font-size=\"13\" fill=\"#1d3a57\" font-weight=\"bold\">n+</text>

  <!-- Oxide insulator -->
  <rect x=\"240\" y=\"212\" width=\"160\" height=\"18\" fill=\"#e4e4ea\" stroke=\"#9a9aa6\" stroke-width=\"1.5\"/>
  <text x=\"320\" y=\"226\" text-anchor=\"middle\" font-size=\"11\" fill=\"#5a5a66\">thin oxide (insulator)</text>

  <!-- Gate metal -->
  <rect x=\"240\" y=\"188\" width=\"160\" height=\"24\" fill=\"#7a7a86\" stroke=\"#44444e\" stroke-width=\"2\"/>

  <!-- The channel (the controlled path) -->
  <rect x=\"240\" y=\"298\" width=\"160\" height=\"6\" fill=\"#f0a030\"/>
  <text x=\"320\" y=\"324\" text-anchor=\"middle\" font-size=\"12\" fill=\"#b06a00\">channel: forms only when gate is on</text>

  <!-- Terminal leads -->
  <!-- Source -->
  <line x1=\"195\" y1=\"230\" x2=\"195\" y2=\"120\" stroke=\"#333\" stroke-width=\"3\"/>
  <circle cx=\"195\" cy=\"120\" r=\"5\" fill=\"#333\"/>
  <text x=\"195\" y=\"108\" text-anchor=\"middle\" font-size=\"15\" font-weight=\"bold\" fill=\"#222\">SOURCE</text>
  <!-- Drain -->
  <line x1=\"445\" y1=\"230\" x2=\"445\" y2=\"120\" stroke=\"#333\" stroke-width=\"3\"/>
  <circle cx=\"445\" cy=\"120\" r=\"5\" fill=\"#333\"/>
  <text x=\"445\" y=\"108\" text-anchor=\"middle\" font-size=\"15\" font-weight=\"bold\" fill=\"#222\">DRAIN</text>
  <!-- Gate -->
  <line x1=\"320\" y1=\"188\" x2=\"320\" y2=\"120\" stroke=\"#b03030\" stroke-width=\"3\"/>
  <circle cx=\"320\" cy=\"120\" r=\"5\" fill=\"#b03030\"/>
  <text x=\"320\" y=\"108\" text-anchor=\"middle\" font-size=\"15\" font-weight=\"bold\" fill=\"#b03030\">GATE</text>

  <!-- Explanation box -->
  <rect x=\"120\" y=\"392\" width=\"400\" height=\"0\" fill=\"none\"/>
  <text x=\"320\" y=\"414\" text-anchor=\"middle\" font-size=\"13\" fill=\"#333\">A voltage on the GATE pulls electrons up to form the orange channel,</text>
  <text x=\"320\" y=\"432\" text-anchor=\"middle\" font-size=\"13\" fill=\"#333\">letting current flow SOURCE→DRAIN. No gate voltage → no channel → no current.</text>

  <!-- control arrow -->
  <path d=\"M 345 150 Q 400 160 420 190\" fill=\"none\" stroke=\"#b03030\" stroke-width=\"2\" stroke-dasharray=\"5 4\" marker-end=\"url(#arr)\"/>
  <defs>
    <marker id=\"arr\" markerWidth=\"10\" markerHeight=\"10\" refX=\"6\" refY=\"3\" orient=\"auto\">
      <path d=\"M0,0 L6,3 L0,6 Z\" fill=\"#b03030\"/>
    </marker>
  </defs>
  <text x=\"430\" y=\"168\" font-size=\"11\" fill=\"#b03030\">controls the path</text>
</svg>"
 :AT "2026-11-01T00:05:40" :VERSION 1)
