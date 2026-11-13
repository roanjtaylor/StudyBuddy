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
(:ID "d-flip-flop-timing" :MAP "computers" :NODE NIL :TYPE "svg" :TITLE "D flip-flop timing"
 :LANGUAGE NIL :CONTENT
 "<svg viewBox=\"0 0 640 420\" xmlns=\"http://www.w3.org/2000/svg\" font-family=\"sans-serif\">
  <style>
    .title{font-size:18px;fill:#111;font-weight:bold}
    .lbl{font-size:15px;fill:#111}
    .sig{stroke:#2c3e50;stroke-width:2.5;fill:none}
    .d{stroke:#2980b9;stroke-width:2.5;fill:none}
    .q{stroke:#c0392b;stroke-width:2.5;fill:none}
    .edge{stroke:#27ae60;stroke-width:1.5;stroke-dasharray:4 4}
    .note{font-size:13px;fill:#555}
  </style>

  <text x=\"20\" y=\"28\" class=\"title\">D flip-flop: Q copies D only on the rising edge</text>

  <!-- clock -->
  <text x=\"20\" y=\"90\" class=\"lbl\">CLK</text>
  <path d=\"M70,110 L70,70 L130,70 L130,110 L190,110 L190,70 L250,70 L250,110 L310,110 L310,70 L370,70 L370,110 L430,110 L430,70 L490,70 L490,110 L550,110\"
        class=\"sig\"/>

  <!-- rising edge markers -->
  <line x1=\"70\" y1=\"60\" x2=\"70\" y2=\"340\" class=\"edge\"/>
  <line x1=\"190\" y1=\"60\" x2=\"190\" y2=\"340\" class=\"edge\"/>
  <line x1=\"310\" y1=\"60\" x2=\"310\" y2=\"340\" class=\"edge\"/>
  <line x1=\"430\" y1=\"60\" x2=\"430\" y2=\"340\" class=\"edge\"/>

  <!-- D input (arbitrary) -->
  <text x=\"20\" y=\"210\" class=\"lbl\">D</text>
  <path d=\"M70,230 L120,230 L120,190 L260,190 L260,230 L350,230 L350,190 L470,190 L470,230 L550,230\" class=\"d\"/>

  <!-- Q output: samples D at each green edge -->
  <text x=\"20\" y=\"320\" class=\"lbl\">Q</text>
  <!-- edge at 70: D=low -> Q low; edge 190: D high -> Q high; edge 310: D high -> Q high; edge 430: D low... wait D at 430 is low -->
  <path d=\"M70,340 L190,340 L190,300 L430,300 L430,340 L550,340\" class=\"q\"/>

  <text x=\"60\" y=\"380\" class=\"note\">At each green line (rising edge) Q grabs D's value and holds it until the next edge.</text>
  <text x=\"60\" y=\"400\" class=\"note\">Between edges, D can wobble all it likes — Q ignores it. That lockstep is why the clock matters.</text>
</svg>"
 :AT "2026-11-02T13:07:16" :VERSION 1)
(:ID "d-flip-flop-chip-and-innards" :MAP "computers" :NODE NIL :TYPE "svg" :TITLE
 "D flip-flop: chip and innards" :LANGUAGE NIL :CONTENT
 "<svg viewBox=\"0 0 860 520\" xmlns=\"http://www.w3.org/2000/svg\" font-family=\"sans-serif\">
  <rect width=\"860\" height=\"520\" fill=\"#0f1117\"/>
  <text x=\"430\" y=\"34\" fill=\"#e8e8f0\" font-size=\"22\" text-anchor=\"middle\" font-weight=\"bold\">A D flip-flop — the thing itself</text>

  <!-- LEFT: the chip -->
  <text x=\"210\" y=\"74\" fill=\"#9 aa\" font-size=\"15\" text-anchor=\"middle\" fill=\"#8891a8\">As a chip (7474-style package)</text>
  <!-- body -->
  <rect x=\"120\" y=\"100\" width=\"180\" height=\"300\" rx=\"8\" fill=\"#1c1f2b\" stroke=\"#3a4161\" stroke-width=\"2\"/>
  <!-- notch -->
  <path d=\"M190 100 a20 20 0 0 0 40 0\" fill=\"#0f1117\" stroke=\"#3a4161\" stroke-width=\"2\"/>
  <circle cx=\"145\" cy=\"130\" r=\"6\" fill=\"#0f1117\" stroke=\"#3a4161\"/>
  <!-- left pins -->
  <g fill=\"#c9a94a\">
    <rect x=\"90\" y=\"130\" width=\"30\" height=\"10\"/><rect x=\"90\" y=\"175\" width=\"30\" height=\"10\"/>
    <rect x=\"90\" y=\"220\" width=\"30\" height=\"10\"/><rect x=\"90\" y=\"265\" width=\"30\" height=\"10\"/>
    <rect x=\"90\" y=\"310\" width=\"30\" height=\"10\"/><rect x=\"90\" y=\"355\" width=\"30\" height=\"10\"/>
  </g>
  <!-- right pins -->
  <g fill=\"#c9a94a\">
    <rect x=\"300\" y=\"130\" width=\"30\" height=\"10\"/><rect x=\"300\" y=\"175\" width=\"30\" height=\"10\"/>
    <rect x=\"300\" y=\"220\" width=\"30\" height=\"10\"/><rect x=\"300\" y=\"265\" width=\"30\" height=\"10\"/>
    <rect x=\"300\" y=\"310\" width=\"30\" height=\"10\"/><rect x=\"300\" y=\"355\" width=\"30\" height=\"10\"/>
  </g>
  <!-- pin labels left -->
  <g fill=\"#e8e8f0\" font-size=\"13\">
    <text x=\"128\" y=\"139\">CLR</text>
    <text x=\"128\" y=\"184\">D</text>
    <text x=\"128\" y=\"229\">CLK</text>
    <text x=\"128\" y=\"274\">PRE</text>
    <text x=\"128\" y=\"319\">Q</text>
    <text x=\"128\" y=\"364\">GND</text>
  </g>
  <g fill=\"#e8e8f0\" font-size=\"13\" text-anchor=\"end\">
    <text x=\"292\" y=\"139\">Vcc</text>
    <text x=\"292\" y=\"184\">·</text>
    <text x=\"292\" y=\"229\">·</text>
    <text x=\"292\" y=\"274\">·</text>
    <text x=\"292\" y=\"319\">Q̄</text>
    <text x=\"292\" y=\"364\">·</text>
  </g>
  <text x=\"210\" y=\"430\" fill=\"#8891a8\" font-size=\"12\" text-anchor=\"middle\">D in, CLK in → Q out. Power + ground.</text>
  <text x=\"210\" y=\"448\" fill=\"#8891a8\" font-size=\"12\" text-anchor=\"middle\">The whole memory cell, pinned out.</text>

  <!-- arrow -->
  <path d=\"M345 250 L395 250\" stroke=\"#6b7bb8\" stroke-width=\"2\" marker-end=\"url(#a)\"/>
  <defs><marker id=\"a\" markerWidth=\"10\" markerHeight=\"10\" refX=\"8\" refY=\"3\" orient=\"auto\"><path d=\"M0 0 L8 3 L0 6 Z\" fill=\"#6b7bb8\"/></marker></defs>
  <text x=\"370\" y=\"240\" fill=\"#6b7bb8\" font-size=\"11\" text-anchor=\"middle\">open it</text>

  <!-- RIGHT: standard symbol -->
  <text x=\"640\" y=\"74\" fill=\"#8891a8\" font-size=\"15\" text-anchor=\"middle\">As the logic symbol</text>
  <rect x=\"540\" y=\"130\" width=\"200\" height=\"200\" rx=\"4\" fill=\"#1c1f2b\" stroke=\"#5a6aa0\" stroke-width=\"2\"/>
  <!-- D input -->
  <line x1=\"490\" y1=\"170\" x2=\"540\" y2=\"170\" stroke=\"#7fd1b9\" stroke-width=\"2\"/>
  <text x=\"482\" y=\"175\" fill=\"#7fd1b9\" font-size=\"16\" text-anchor=\"end\">D</text>
  <text x=\"555\" y=\"176\" fill=\"#e8e8f0\" font-size=\"16\">D</text>
  <!-- clock input with triangle (edge-trigger) -->
  <line x1=\"490\" y1=\"290\" x2=\"540\" y2=\"290\" stroke=\"#c9a94a\" stroke-width=\"2\"/>
  <text x=\"482\" y=\"295\" fill=\"#c9a94a\" font-size=\"16\" text-anchor=\"end\">CLK</text>
  <polyline points=\"540,278 558,290 540,302\" fill=\"none\" stroke=\"#e8e8f0\" stroke-width=\"2\"/>
  <!-- Q output -->
  <line x1=\"740\" y1=\"170\" x2=\"790\" y2=\"170\" stroke=\"#f2a6a6\" stroke-width=\"2\"/>
  <text x=\"724\" y=\"176\" fill=\"#e8e8f0\" font-size=\"16\" text-anchor=\"end\">Q</text>
  <text x=\"798\" y=\"175\" fill=\"#f2a6a6\" font-size=\"16\">Q</text>
  <!-- Qbar -->
  <line x1=\"740\" y1=\"290\" x2=\"790\" y2=\"290\" stroke=\"#9fb0e0\" stroke-width=\"2\"/>
  <text x=\"722\" y=\"296\" fill=\"#e8e8f0\" font-size=\"16\" text-anchor=\"end\">Q̄</text>
  <text x=\"798\" y=\"295\" fill=\"#9fb0e0\" font-size=\"16\">Q̄</text>

  <text x=\"640\" y=\"370\" fill=\"#8891a8\" font-size=\"12\" text-anchor=\"middle\">The small triangle on CLK means:</text>
  <text x=\"640\" y=\"388\" fill=\"#8891a8\" font-size=\"12\" text-anchor=\"middle\">\"only act on the rising edge.\"</text>

  <text x=\"640\" y=\"430\" fill=\"#7fd1b9\" font-size=\"13\" text-anchor=\"middle\">Inside this box lives the cross-wired loop</text>
  <text x=\"640\" y=\"450\" fill=\"#7fd1b9\" font-size=\"13\" text-anchor=\"middle\">(your SR-latch diagram) plus a clock gate.</text>

  <text x=\"430\" y=\"500\" fill=\"#c9a94a\" font-size=\"14\" text-anchor=\"middle\" font-style=\"italic\">One bit of memory. Thousands of these in a row = a register; millions in a grid = RAM.</text>
</svg>"
 :AT "2026-11-02T13:26:01" :VERSION 1)
(:ID "transistor-switch-three-states" :MAP "computers" :NODE "transistor" :TYPE "svg" :TITLE
 "Transistor switch: three states" :LANGUAGE NIL :CONTENT
 "<svg viewBox=\"0 0 900 420\" xmlns=\"http://www.w3.org/2000/svg\" font-family=\"sans-serif\">
  <style>
    .wire{stroke:#555;stroke-width:3;fill:none}
    .live{stroke:#e8491d;stroke-width:4;fill:none}
    .dead{stroke:#bbb;stroke-width:3;fill:none;stroke-dasharray:5 5}
    .lbl{font-size:13px;fill:#333}
    .title{font-size:16px;font-weight:bold;fill:#222}
    .note{font-size:12px;fill:#666}
    .flow{fill:#e8491d}
  </style>

  <!-- ===== PANEL 1: OFF (no supply) ===== -->
  <g transform=\"translate(20,0)\">
    <text x=\"130\" y=\"28\" text-anchor=\"middle\" class=\"title\">1 · No supply</text>

    <!-- collector top rail -->
    <line x1=\"130\" y1=\"60\" x2=\"130\" y2=\"140\" class=\"dead\"/>
    <text x=\"140\" y=\"55\" class=\"note\">+V off</text>
    <circle cx=\"130\" cy=\"58\" r=\"4\" fill=\"#bbb\"/>

    <!-- transistor body -->
    <line x1=\"90\" y1=\"150\" x2=\"90\" y2=\"230\" class=\"wire\"/>
    <line x1=\"90\" y1=\"170\" x2=\"130\" y2=\"140\" class=\"dead\"/>
    <line x1=\"90\" y1=\"210\" x2=\"130\" y2=\"240\" class=\"dead\"/>
    <!-- base -->
    <line x1=\"40\" y1=\"190\" x2=\"90\" y2=\"190\" class=\"dead\"/>
    <text x=\"10\" y=\"194\" class=\"lbl\">base</text>
    <circle cx=\"40\" cy=\"190\" r=\"4\" fill=\"#bbb\"/>
    <text x=\"10\" y=\"210\" class=\"note\">off</text>

    <!-- emitter down to ground -->
    <line x1=\"130\" y1=\"240\" x2=\"130\" y2=\"320\" class=\"dead\"/>
    <line x1=\"112\" y1=\"320\" x2=\"148\" y2=\"320\" class=\"wire\"/>
    <line x1=\"118\" y1=\"328\" x2=\"142\" y2=\"328\" class=\"wire\"/>
    <line x1=\"124\" y1=\"336\" x2=\"136\" y2=\"336\" class=\"wire\"/>

    <text x=\"130\" y=\"375\" text-anchor=\"middle\" class=\"note\">Nothing connected.</text>
    <text x=\"130\" y=\"392\" text-anchor=\"middle\" class=\"note\">No current anywhere.</text>
  </g>

  <!-- ===== PANEL 2: supply on, base off ===== -->
  <g transform=\"translate(320,0)\">
    <text x=\"130\" y=\"28\" text-anchor=\"middle\" class=\"title\">2 · +V on, base off</text>

    <line x1=\"130\" y1=\"60\" x2=\"130\" y2=\"140\" class=\"live\"/>
    <text x=\"140\" y=\"55\" class=\"note\" fill=\"#e8491d\">+V</text>
    <circle cx=\"130\" cy=\"58\" r=\"4\" class=\"flow\"/>

    <line x1=\"90\" y1=\"150\" x2=\"90\" y2=\"230\" class=\"wire\"/>
    <!-- collector arm live down to channel -->
    <line x1=\"90\" y1=\"170\" x2=\"130\" y2=\"140\" class=\"live\"/>
    <!-- emitter arm dead -->
    <line x1=\"90\" y1=\"210\" x2=\"130\" y2=\"240\" class=\"dead\"/>
    <line x1=\"40\" y1=\"190\" x2=\"90\" y2=\"190\" class=\"dead\"/>
    <text x=\"10\" y=\"194\" class=\"lbl\">base</text>
    <circle cx=\"40\" cy=\"190\" r=\"4\" fill=\"#bbb\"/>
    <text x=\"10\" y=\"210\" class=\"note\">0 V</text>

    <line x1=\"130\" y1=\"240\" x2=\"130\" y2=\"320\" class=\"dead\"/>
    <line x1=\"112\" y1=\"320\" x2=\"148\" y2=\"320\" class=\"wire\"/>
    <line x1=\"118\" y1=\"328\" x2=\"142\" y2=\"328\" class=\"wire\"/>
    <line x1=\"124\" y1=\"336\" x2=\"136\" y2=\"336\" class=\"wire\"/>

    <!-- block marker at channel -->
    <line x1=\"78\" y1=\"190\" x2=\"102\" y2=\"190\" stroke=\"#e8491d\" stroke-width=\"3\"/>
    <text x=\"108\" y=\"178\" class=\"note\" fill=\"#e8491d\">gap: no path</text>

    <text x=\"130\" y=\"375\" text-anchor=\"middle\" class=\"note\">Voltage present, but the</text>
    <text x=\"130\" y=\"392\" text-anchor=\"middle\" class=\"note\">channel is closed. 0 current.</text>
  </g>

  <!-- ===== PANEL 3: supply on, base on ===== -->
  <g transform=\"translate(620,0)\">
    <text x=\"130\" y=\"28\" text-anchor=\"middle\" class=\"title\">3 · +V on, base on</text>

    <line x1=\"130\" y1=\"60\" x2=\"130\" y2=\"140\" class=\"live\"/>
    <text x=\"140\" y=\"55\" class=\"note\" fill=\"#e8491d\">+V</text>
    <circle cx=\"130\" cy=\"58\" r=\"4\" class=\"flow\"/>

    <line x1=\"90\" y1=\"150\" x2=\"90\" y2=\"230\" class=\"live\"/>
    <line x1=\"90\" y1=\"170\" x2=\"130\" y2=\"140\" class=\"live\"/>
    <line x1=\"90\" y1=\"210\" x2=\"130\" y2=\"240\" class=\"live\"/>
    <!-- base driven -->
    <line x1=\"40\" y1=\"190\" x2=\"90\" y2=\"190\" class=\"live\"/>
    <text x=\"8\" y=\"194\" class=\"lbl\" fill=\"#e8491d\">base</text>
    <circle cx=\"40\" cy=\"190\" r=\"4\" class=\"flow\"/>
    <text x=\"10\" y=\"210\" class=\"note\" fill=\"#e8491d\">+ small V</text>

    <line x1=\"130\" y1=\"240\" x2=\"130\" y2=\"320\" class=\"live\"/>
    <line x1=\"112\" y1=\"320\" x2=\"148\" y2=\"320\" class=\"wire\"/>
    <line x1=\"118\" y1=\"328\" x2=\"142\" y2=\"328\" class=\"wire\"/>
    <line x1=\"124\" y1=\"336\" x2=\"136\" y2=\"336\" class=\"wire\"/>

    <!-- flow arrows -->
    <polygon points=\"130,110 125,100 135,100\" class=\"flow\"/>
    <polygon points=\"130,290 125,280 135,280\" class=\"flow\"/>

    <text x=\"130\" y=\"375\" text-anchor=\"middle\" class=\"note\" fill=\"#e8491d\">Base opens the channel.</text>
    <text x=\"130\" y=\"392\" text-anchor=\"middle\" class=\"note\">Current flows top → ground.</text>
  </g>
</svg>"
 :AT "2026-11-09T11:31:01" :VERSION 1)
(:ID "relay-line-across-america" :MAP "computers" :NODE NIL :TYPE "html" :TITLE
 "Relay line across America" :LANGUAGE NIL :CONTENT "<!DOCTYPE html>
<html><head><meta charset=\"utf-8\">
<style>
 body{margin:0;font-family:system-ui,sans-serif;background:#f6f7f9;color:#222}
 .wrap{max-width:1040px;margin:0 auto;padding:14px}
 h1{font-size:18px;margin:0 0 4px}
 p.sub{margin:0 0 10px;font-size:14px;color:#555}
 .ctl{display:flex;flex-wrap:wrap;gap:10px;align-items:center;margin-bottom:10px}
 input[type=text]{padding:8px 10px;font-size:15px;border:1px solid #bbb;border-radius:6px;width:160px;text-transform:uppercase}
 button{padding:8px 16px;font-size:15px;border:0;border-radius:6px;background:#1d3557;color:#fff;cursor:pointer}
 button.alt{background:#fff;color:#1d3557;border:1px solid #1d3557;user-select:none}
 button:active{transform:translateY(1px)}
 select{padding:7px;font-size:14px;border-radius:6px}
 #morse{font-family:monospace;font-size:16px;letter-spacing:2px;min-height:22px;margin-bottom:6px}
 svg{width:100%;height:auto;background:#fff;border:1px solid #ddd;border-radius:10px}
 .legend{display:grid;grid-template-columns:repeat(auto-fit,minmax(230px,1fr));gap:8px;font-size:13px;margin-top:10px;color:#444}
 .legend div{background:#fff;border:1px solid #e1e1e1;border-radius:8px;padding:8px}
</style></head><body><div class=\"wrap\">
<h1>A relay line across America</h1>
<p class=\"sub\">Each section of wire is weak. At every station the arriving current only energises an electromagnet, which closes a switch that connects a fresh local battery to the next section. A switch controls a switch.</p>
<div class=\"ctl\">
 <input id=\"msg\" type=\"text\" value=\"SOS\" maxlength=\"12\">
 <button id=\"send\">Send</button>
 <button id=\"key\" class=\"alt\">Hold to tap the key</button>
 <label>Speed <select id=\"spd\"><option value=\"1100\">Slow</option><option value=\"700\" selected>Normal</option><option value=\"350\">Fast</option></select></label>
</div>
<div id=\"morse\">&nbsp;</div>
<svg id=\"svg\" viewBox=\"0 0 1000 560\" xmlns=\"http://www.w3.org/2000/svg\">
 <defs><filter id=\"glow\" x=\"-50%\" y=\"-50%\" width=\"200%\" height=\"200%\"><feGaussianBlur stdDeviation=\"3.5\" result=\"b\"/><feMerge><feMergeNode in=\"b\"/><feMergeNode in=\"SourceGraphic\"/></feMerge></filter></defs>
 <polygon points=\"60,70 250,85 400,80 560,85 700,80 760,95 800,110 850,90 900,100 930,70 960,90 950,140 920,170 900,200 880,230 860,290 840,340 850,380 870,420 880,470 850,500 820,440 790,400 740,400 660,420 600,440 560,460 520,490 500,520 470,500 440,450 380,430 330,420 290,380 220,380 150,350 100,300 70,240 50,170 45,110\" fill=\"#eef3ea\" stroke=\"#9fb28f\" stroke-width=\"2\" stroke-linejoin=\"round\"/>
 <g id=\"tracks\"></g><g id=\"lit\" filter=\"url(#glow)\"></g><g id=\"stations\"></g>
</svg>
<div class=\"legend\">
 <div><b>Colour = one section of wire.</b> Each has its own battery at its sending end, so the signal is renewed, not just carried.</div>
 <div><b>Coil → arm.</b> Current arriving pulls the arm shut (it takes the colour of the line it now feeds). When the current stops, the arm springs open.</div>
 <div><b>Same pattern copied.</b> Every dot and dash is repeated exactly, one hop later. The last station's arm lights the sounder.</div>
</div>
</div>
<script>
const NS=\"http://www.w3.org/2000/svg\";
const st=[{n:\"San Francisco\",x:80,y:225},{n:\"Salt Lake City\",x:265,y:225},{n:\"Denver\",x:415,y:270},{n:\"Omaha\",x:555,y:215},{n:\"Chicago\",x:695,y:190},{n:\"New York\",x:870,y:185}];
const col=[\"#e63946\",\"#f4a261\",\"#2a9d8f\",\"#4361ee\",\"#b5179e\"];
const $=id=>document.getElementById(id);
function el(tag,attrs,parent){const e=document.createElementNS(NS,tag);for(const k in attrs)e.setAttribute(k,attrs[k]);if(parent)parent.appendChild(e);return e}
const tracks=$(\"tracks\"),lit=$(\"lit\"),sg=$(\"stations\");
for(let i=0;i<5;i++){const a=st[i],b=st[i+1];
 el(\"line\",{x1:a.x,y1:a.y,x2:b.x,y2:b.y,stroke:col[i],\"stroke-width\":4,opacity:.28,\"stroke-linecap\":\"round\"},tracks);
 el(\"line\",{x1:a.x,y1:a.y,x2:b.x,y2:b.y,stroke:\"#fff\",\"stroke-width\":1.5,\"stroke-dasharray\":\"2 14\",opacity:.9},tracks);
 // line label
 el(\"text\",{x:(a.x+b.x)/2,y:(a.y+b.y)/2-14,\"text-anchor\":\"middle\",\"font-size\":13,fill:col[i],\"font-weight\":700},tracks).textContent=\"Line \"+(i+1);
}
const S=st.map((s,i)=>{
 const g=el(\"g\",{transform:`translate(${s.x},${s.y})`},sg);
 const node=el(\"circle\",{r:10,fill:\"#fff\",stroke:\"#333\",\"stroke-width\":2.5},g);
 // card
 el(\"rect\",{x:-46,y:20,width:92,height:58,rx:8,fill:\"#fff\",stroke:\"#bbb\"},g);
 // battery
 const bat1=el(\"line\",{x1:-36,x2:-36,y1:32,y2:50,stroke:\"#999\",\"stroke-width\":3},g);
 const bat2=el(\"line\",{x1:-30,x2:-30,y1:37,y2:45,stroke:\"#999\",\"stroke-width\":3},g);
 el(\"text\",{x:-33,y:68,\"text-anchor\":\"middle\",\"font-size\":12,fill:\"#666\"},g).textContent=\"battery\";
 // wire battery to arm pivot
 el(\"polyline\",{points:\"-36,41 -36,41\",fill:\"none\"},g);
 // arm
 const arm=el(\"line\",{x1:-12,y1:46,x2:10,y2:34,stroke:\"#999\",\"stroke-width\":3.5,\"stroke-linecap\":\"round\"},g);
 el(\"circle\",{cx:-12,cy:46,r:2.5,fill:\"#555\"},g);
 el(\"circle\",{cx:12,cy:46,r:2.5,fill:\"#555\"},g);
 // coil
 const coil=el(\"circle\",{cx:30,cy:40,r:9,fill:\"#fff\",stroke:\"#999\",\"stroke-width\":3},g);
 el(\"text\",{x:30,y:68,\"text-anchor\":\"middle\",\"font-size\":12,fill:\"#666\"},g).textContent=i==0?\"key\":\"coil\";
 el(\"text\",{x:0,y:-18,\"text-anchor\":\"middle\",\"font-size\":14,\"font-weight\":700,fill:\"#222\"},g).textContent=s.n;
 return {node,bat1,bat2,arm,coil};
});
const toneLabel=el(\"text\",{x:870,y:122,\"text-anchor\":\"middle\",\"font-size\":14,\"font-weight\":700,fill:\"#b5179e\",opacity:0},sg);
toneLabel.textContent=\"CLICK\";

const M={A:\".-\",B:\"-...\",C:\"-.-.\",D:\"-..\",E:\".\",F:\"..-.\",G:\"--.\",H:\"....\",I:\"..\",J:\".---\",K:\"-.-\",L:\".-..\",M:\"--\",N:\"-.\",O:\"---\",P:\".--.\",Q:\"--.-\",R:\".-.\",S:\"...\",T:\"-\",U:\"..-\",V:\"...-\",W:\".--\",X:\"-..-\",Y:\"-.--\",Z:\"--..\",0:\"-----\",1:\".----\",2:\"..---\",3:\"...--\",4:\"....-\",5:\".....\",6:\"-....\",7:\"--...\",8:\"---..\",9:\"----.\"};
let iv=[],D=700,U=140,manual=null;
function send(){
 D=+$(\"spd\").value;U=D/5;
 const txt=$(\"msg\").value.toUpperCase();let cur=performance.now()+100,out=[];
 for(const w of txt.split(\" \")){
  for(const ch of w){const code=M[ch];if(!code)continue;out.push(code);
   for(const sy of code){const len=sy==\".\"?1:3;iv.push({a:cur,b:cur+len*U});cur+=(len+1)*U}
   cur+=2*U}
  cur+=4*U;out.push(\"/\");}
 $(\"morse\").textContent=out.join(\"  \");
}
$(\"send\").onclick=send;
const key=$(\"key\");
function kd(e){e.preventDefault();if(manual)return;D=+$(\"spd\").value;manual={a:performance.now(),b:Infinity};iv.push(manual)}
function ku(){if(manual){manual.b=performance.now();manual=null}}
key.addEventListener(\"mousedown\",kd);window.addEventListener(\"mouseup\",ku);
key.addEventListener(\"touchstart\",kd,{passive:false});window.addEventListener(\"touchend\",ku);

function cl(v){return Math.max(0,Math.min(1,v))}
function frame(){
 const t=performance.now();
 while(iv.length&&iv[0].b!==Infinity&&t>iv[0].b+6*D+200)iv.shift();
 lit.innerHTML=\"\";
 const closed=[false,false,false,false,false,false];
 for(const v of iv){
  for(let s=0;s<6;s++){if(t>=v.a+s*D&&t<v.b+s*D)closed[s]=true}
  for(let s=0;s<5;s++){
   const f=cl((t-(v.a+s*D))/D),tl=cl((t-(v.b+s*D))/D);
   if(t>=v.a+s*D&&f>tl){const a=st[s],b=st[s+1];
    el(\"line\",{x1:a.x+(b.x-a.x)*tl,y1:a.y+(b.y-a.y)*tl,x2:a.x+(b.x-a.x)*f,y2:a.y+(b.y-a.y)*f,stroke:col[s],\"stroke-width\":8,\"stroke-linecap\":\"round\"},lit);}
  }
 }
 for(let s=0;s<6;s++){
  const o=S[s],on=closed[s],c=s<5?col[s]:\"#b5179e\";
  o.arm.setAttribute(\"x2\",on?12:10);o.arm.setAttribute(\"y2\",on?46:34);
  o.arm.setAttribute(\"stroke\",on?c:\"#999\");
  o.bat1.setAttribute(\"stroke\",on?c:\"#999\");o.bat2.setAttribute(\"stroke\",on?c:\"#999\");
  o.coil.setAttribute(\"stroke\",on?(s>0?col[s-1]:\"#333\"):\"#999\");
  o.coil.setAttribute(\"fill\",on?(s>0?col[s-1]+\"55\":\"#ddd\"):\"#fff\");
  o.node.setAttribute(\"fill\",on?c:\"#fff\");
 }
 toneLabel.setAttribute(\"opacity\",closed[5]?1:0);
 requestAnimationFrame(frame);
}
frame();
</script></body></html>"
 :AT "2026-11-10T17:58:26" :VERSION 1)
(:PINNED T :ID "relay-and-triode-tube" :MAP "computers" :NODE "relay-vacuum-tube" :TYPE "html"
 :TITLE "Relay, triode tube and relay line" :LANGUAGE NIL :CONTENT
 "<!DOCTYPE html><html><head><meta charset=\"utf-8\"><style>
body{font-family:system-ui,sans-serif;margin:0;padding:12px;background:#fafaf7;color:#222}
h2{font-size:16px;margin:4px 0 8px}
.wrap{display:flex;flex-wrap:wrap;gap:12px}
.card{flex:1 1 380px;background:#fff;border:1px solid #ddd;border-radius:10px;padding:10px}
.card.full{flex:1 1 100%}
button{font-size:14px;padding:8px 14px;border-radius:8px;border:1px solid #888;background:#eee;cursor:pointer}
button.on{background:#2e7d32;color:#fff;border-color:#2e7d32}
button.bad{background:#c62828;color:#fff;border-color:#c62828}
select{font-size:14px;padding:7px;border-radius:8px}
p.n{font-size:13px;margin:6px 0 0;min-height:54px}
svg{width:100%;height:auto}
text{font-family:system-ui,sans-serif;font-size:12px;fill:#222}
.flow{stroke-dasharray:6 6;animation:d .6s linear infinite}
@keyframes d{to{stroke-dashoffset:-12}}
.hide{display:none}
input[type=range]{width:200px;vertical-align:middle}
.ctl{display:flex;flex-wrap:wrap;gap:10px;align-items:center;margin-top:6px}
code{font-size:15px;background:#f1f1ec;padding:2px 6px;border-radius:4px;letter-spacing:2px}
.row{font-size:13px;margin:6px 0 0}
</style></head><body>
<div class=\"wrap\">
<div class=\"card\"><h2>Relay (1830s–1940s): electromagnet moves a contact</h2>
<svg viewBox=\"0 0 400 310\">
<text x=\"200\" y=\"40\" text-anchor=\"middle\" style=\"font-weight:bold\">Load circuit (larger flow)</text>
<path d=\"M60 150 V70 H350 V106 M350 134 V190 H285 V164\" fill=\"none\" stroke=\"#999\" stroke-width=\"2\"/>
<path id=\"lc\" d=\"M60 150 V70 H350 V106 M350 134 V190 H285 V164\" fill=\"none\" stroke=\"#1565c0\" stroke-width=\"3\" class=\"flow hide\"/>
<circle id=\"lamp\" cx=\"350\" cy=\"120\" r=\"14\" fill=\"#ddd\" stroke=\"#555\" stroke-width=\"2\"/>
<text x=\"328\" y=\"124\" text-anchor=\"end\">lamp</text>
<rect x=\"270\" y=\"154\" width=\"30\" height=\"10\" fill=\"#b0bec5\" stroke=\"#555\"/>
<text x=\"262\" y=\"182\" text-anchor=\"end\">contact</text>
<rect x=\"172\" y=\"165\" width=\"16\" height=\"90\" fill=\"#777\"/>
<rect x=\"155\" y=\"185\" width=\"50\" height=\"50\" fill=\"none\" stroke=\"#555\"/>
<g stroke=\"#b87333\" stroke-width=\"3\"><path d=\"M155 193H205M155 203H205M155 213H205M155 223H205\"/></g>
<text x=\"214\" y=\"204\">coil</text>
<text x=\"214\" y=\"250\">iron core</text>
<path d=\"M155 210 H60 V275 H300 V210 H205\" fill=\"none\" stroke=\"#999\" stroke-width=\"2\"/>
<path id=\"rc\" d=\"M155 210 H60 V275 H300 V210 H205\" fill=\"none\" stroke=\"#e65100\" stroke-width=\"3\" class=\"flow hide\"/>
<circle cx=\"60\" cy=\"245\" r=\"5\" fill=\"#333\"/>
<text x=\"70\" y=\"249\">input</text>
<text x=\"180\" y=\"298\" text-anchor=\"middle\" style=\"font-weight:bold\">Control circuit (small signal)</text>
<g id=\"arm\" style=\"transition:transform .25s;transform-origin:60px 150px\">
<rect x=\"60\" y=\"146\" width=\"240\" height=\"8\" fill=\"#455a64\"/>
</g>
<circle cx=\"60\" cy=\"150\" r=\"5\" fill=\"#222\"/>
<text x=\"70\" y=\"172\">pivot</text>
<text x=\"130\" y=\"122\">armature</text>
</svg>
<button id=\"rb\">Press: current in coil OFF</button>
<p class=\"n\" id=\"rn\"></p></div>

<div class=\"card\"><h2>Triode tube (1906): grid voltage controls a current</h2>
<svg viewBox=\"0 0 400 300\">
<ellipse cx=\"200\" cy=\"130\" rx=\"95\" ry=\"115\" fill=\"#e3f2fd\" stroke=\"#555\" stroke-width=\"2\"/>
<rect x=\"150\" y=\"45\" width=\"100\" height=\"8\" fill=\"#546e7a\"/><text x=\"262\" y=\"53\">plate (anode, +)</text>
<path d=\"M150 112 h100\" stroke=\"#2e7d32\" stroke-width=\"2\" stroke-dasharray=\"6 4\"/><text x=\"262\" y=\"116\">grid</text>
<path d=\"M165 190 L175 175 L185 190 L195 175 L205 190 L215 175 L225 190 L235 175\" fill=\"none\" stroke=\"#555\" stroke-width=\"3\" id=\"fil\"/>
<text x=\"262\" y=\"186\">heated cathode</text>
<text x=\"262\" y=\"200\">(filament)</text>
<g id=\"els\"></g>
<path d=\"M200 45 V10 H60 V270 H165 \" fill=\"none\" stroke=\"#999\" stroke-width=\"2\"/>
<path d=\"M150 112 H30 V240\" fill=\"none\" stroke=\"#999\" stroke-width=\"2\"/>
<path d=\"M165 190 V270 M235 175 V270\" stroke=\"#999\" stroke-width=\"2\" fill=\"none\"/>
<text x=\"68\" y=\"30\" fill=\"#1565c0\">B+ supply, load</text>
<text x=\"8\" y=\"262\">grid</text><text x=\"8\" y=\"276\">input</text>
<circle id=\"heat\" cx=\"200\" cy=\"182\" r=\"30\" fill=\"#ff9800\" opacity=\"0\"/>
<text x=\"168\" y=\"290\">heater power</text>
</svg>
<div><button id=\"hb\">Heater: OFF</button>
Grid voltage: <input type=\"range\" id=\"gv\" min=\"-5\" max=\"5\" value=\"0\" step=\"1\"> <span id=\"gl\">0 V</span></div>
<p class=\"n\" id=\"tn\"></p></div>

<div class=\"card full\"><h2>Relay chain coast to coast (telegraph, 1861): the signal hops city to city</h2>
<svg id=\"us\" viewBox=\"0 0 960 540\"></svg>
<div class=\"ctl\">
 <select id=\"msg\"><option>SOS</option><option>HI</option><option>OK</option><option>NY SF</option></select>
 <button id=\"send\">Send message</button>
 <button id=\"hold\">Hold to key</button>
 <label>Dot length <input type=\"range\" id=\"spd\" min=\"200\" max=\"500\" value=\"320\"></label>
 <button id=\"mode\" class=\"on\">Relays: ON (click to remove them)</button>
</div>
<p class=\"row\">Keyed: <code id=\"sent\">&nbsp;</code> Received at sounder: <code id=\"recv\">&nbsp;</code></p>
<p class=\"n\" id=\"un\"></p></div>
</div>
<script>
let coil=false,heat=false;
const $=id=>document.getElementById(id);
function relay(){
 $('rb').textContent='Coil current: '+(coil?'ON':'OFF')+' (click)';$('rb').className=coil?'on':'';
 $('arm').style.transform=coil?'rotate(0deg)':'rotate(-6deg)';
 $('rc').classList.toggle('hide',!coil);
 $('lc').classList.toggle('hide',!coil);
 $('lamp').setAttribute('fill',coil?'#ffeb3b':'#ddd');
 $('rn').textContent=coil?'Small current magnetises the iron core. It pulls the armature down until it touches the contact; the load circuit closes and the lamp lights.':'No coil current: a spring holds the armature up, so there is a gap at the contact, the load circuit is broken and the lamp is dark.';
}
$('rb').onclick=()=>{coil=!coil;relay()};
relay();
const els=[];const g=$('els');
for(let i=0;i<14;i++){const c=document.createElementNS('http://www.w3.org/2000/svg','circle');c.setAttribute('r',3.5);c.setAttribute('fill','#1565c0');g.appendChild(c);els.push({c,x:170+Math.random()*60,y:180-Math.random()*130,p:Math.random()})}
function rate(){const v=+$('gv').value;return !heat?0:Math.max(0,Math.min(1,(v+3)/5))}
function upd(){
 const v=+$('gv').value;$('gl').textContent=(v>0?'+':'')+v+' V';
 $('hb').textContent='Heater: '+(heat?'ON':'OFF');$('hb').className=heat?'on':'';
 $('heat').setAttribute('opacity',heat?.35:0);$('fil').setAttribute('stroke',heat?'#ff5722':'#555');
 const r=rate();
 $('tn').textContent=!heat?'Cold cathode: no electrons boil off, so no current flows whatever the grid does.':
  r==0?'Grid strongly negative: it repels electrons back to the cathode. Tube is OFF (switch open).':
  r<1?'Grid partly negative: some electrons get through to the plate. A small grid change gives a large plate-current change (amplification).':
  'Grid positive or near zero: electrons stream to the positive plate. Tube is ON (switch closed). Only the grid voltage changed, with almost no grid current.';
}
$('hb').onclick=()=>{heat=!heat;upd()};$('gv').oninput=upd;upd();
function tick(){const r=rate();
 els.forEach(e=>{
  if(r==0){e.c.setAttribute('opacity',0);return}
  e.p+=0.012+0.01*r;
  if(e.p>1)e.p=0;
  const x=e.x, y=185-e.p*(185-55);
  e.c.setAttribute('cx',x);e.c.setAttribute('cy',y);
  const pass=(e.idx===undefined?(e.idx=Math.random()):e.idx)<r;
  e.c.setAttribute('opacity',(pass||e.p<0.38)?1:0);
  if(!pass&&e.p>=0.38){e.p=0}
 });requestAnimationFrame(tick)}
tick();
</script>
<script>
// ===== Relay chain over a map of the USA =====
const N=5,TH=0.25,HOP=220;
const cities=[
 {n:'New York',lon:-74,lat:40.7,dx:14,dy:-14,a:'start'},
 {n:'Chicago',lon:-87.6,lat:41.9,dx:0,dy:-18,a:'middle'},
 {n:'Omaha',lon:-96,lat:41.3,dx:0,dy:-18,a:'middle'},
 {n:'Salt Lake City',lon:-111.9,lat:40.8,dx:0,dy:-18,a:'middle'},
 {n:'San Francisco',lon:-122.4,lat:37.8,dx:-4,dy:30,a:'start'}];
const P=(lon,lat)=>[40+(lon+125)*14.6, 25+(49.6-lat)*19.2];
cities.forEach(c=>{[c.x,c.y]=P(c.lon,c.lat)});
const outline=[[-124.7,48.4],[-123,48.3],[-122.8,49],[-95.2,49],[-94.6,48.7],[-89.6,48],[-84.5,46.5],[-82.4,43.5],[-83.1,42],[-79,42.8],[-76.5,43.6],[-75,45],[-71.5,45],[-70,47.4],[-67.8,47.1],[-67,44.8],[-70.2,43.6],[-70.8,42.5],[-70,41.8],[-71.5,41.3],[-74,40.6],[-74,39.5],[-75.5,38.3],[-75.9,37],[-75.5,35.3],[-77.5,34.5],[-79.5,33],[-81,31.8],[-81.3,30],[-80,27],[-80.4,25.2],[-81.2,25.2],[-82.7,27.5],[-82.8,29.2],[-84,30],[-85.3,29.7],[-87.5,30.3],[-89.5,30.2],[-89.4,29],[-91,29.2],[-93.8,29.7],[-97.2,27.8],[-97.2,25.9],[-99.5,27.5],[-101.5,29.8],[-103,29],[-104.5,29.7],[-106.5,31.8],[-108.2,31.8],[-108.2,31.3],[-111,31.3],[-114.8,32.5],[-117.1,32.5],[-118.5,34],[-120.6,34.6],[-121.9,36.6],[-122.5,37.8],[-123.8,39.5],[-124.4,40.4],[-124.2,42],[-124.5,43],[-124,46.2],[-124.1,47]];
const mapPath='M'+outline.map(p=>P(p[0],p[1]).map(v=>v.toFixed(1)).join(' ')).join(' L')+' Z';
let s='<defs>';
for(let i=0;i<N-1;i++){const a=cities[i],b=cities[i+1];
 s+=`<linearGradient id=\"gr${i}\" gradientUnits=\"userSpaceOnUse\" x1=\"${a.x}\" y1=\"${a.y}\" x2=\"${b.x}\" y2=\"${b.y}\"><stop id=\"ga${i}\" offset=\"0\" stop-color=\"#e65100\" stop-opacity=\"1\"/><stop id=\"gb${i}\" offset=\"1\" stop-color=\"#e65100\" stop-opacity=\".5\"/></linearGradient>`}
s+='</defs>';
s+=`<rect width=\"960\" height=\"540\" fill=\"#e8f1f8\" rx=\"8\"/>
<path d=\"${mapPath}\" fill=\"#f1efe4\" stroke=\"#8d9aa5\" stroke-width=\"2\" stroke-linejoin=\"round\"/>`;
// wire underlay + lit segments
for(let i=0;i<N-1;i++){const a=cities[i],b=cities[i+1];
 s+=`<line x1=\"${a.x}\" y1=\"${a.y}\" x2=\"${b.x}\" y2=\"${b.y}\" stroke=\"#b0b0a8\" stroke-width=\"3\"/>
 <line id=\"seg${i}\" x1=\"${a.x}\" y1=\"${a.y}\" x2=\"${b.x}\" y2=\"${b.y}\" stroke=\"url(#gr${i})\" stroke-width=\"6\" class=\"flow hide\"/>
 <text x=\"${(a.x+b.x)/2}\" y=\"${(a.y+b.y)/2+(i==3?-14:20)}\" text-anchor=\"middle\" style=\"fill:#666;font-size:12px\">stretch ${i+1}</text>`;}
for(let i=0;i<N;i++){const c=cities[i];
 s+=`<circle id=\"ring${i}\" cx=\"${c.x}\" cy=\"${c.y}\" r=\"26\" fill=\"#66bb6a\" opacity=\"0\"/>
 <circle id=\"cn${i}\" cx=\"${c.x}\" cy=\"${c.y}\" r=\"11\" fill=\"#fff\" stroke=\"#333\" stroke-width=\"3\"/>
 <text x=\"${c.x+c.dx}\" y=\"${c.y+c.dy}\" text-anchor=\"${c.a}\" style=\"font-weight:bold;font-size:14px\">${cities[i].n}</text>
 <text x=\"${c.x+c.dx}\" y=\"${c.y+c.dy+15}\" text-anchor=\"${c.a}\" style=\"fill:#666\">relay ${i+1}${i==0?' + key':i==N-1?' + sounder':''}</text>
 <text id=\"str${i}\" x=\"${c.x}\" y=\"${c.y+(i==N-1?-22:38)}\" text-anchor=\"middle\" style=\"font-weight:bold\"></text>`;}
s+=`<g transform=\"translate(560,420)\"><rect width=\"380\" height=\"105\" rx=\"8\" fill=\"#fff\" stroke=\"#ccc\"/>
<circle cx=\"20\" cy=\"22\" r=\"8\" fill=\"#ffe0b2\" stroke=\"#333\" stroke-width=\"2\"/><text x=\"36\" y=\"26\">coil energised: relay closed</text>
<circle cx=\"20\" cy=\"46\" r=\"10\" fill=\"#66bb6a\" opacity=\".5\"/><text x=\"36\" y=\"50\">local battery fires a fresh signal onward</text>
<line x1=\"10\" y1=\"70\" x2=\"30\" y2=\"70\" stroke=\"#e65100\" stroke-width=\"5\"/><text x=\"36\" y=\"74\">line current (fades with distance)</text>
<text x=\"12\" y=\"95\" style=\"fill:#666\">Distances and percentages are illustrative.</text></g>`;
$('us').innerHTML=s;

let relays=true,state=Array(N).fill(false),keyOn=false,busy=false,timers=[];
const arrival=j=>j==0?1:(relays?0.6:Math.pow(0.6,j));
const startS=i=>relays?1:Math.pow(0.6,i);
function reachMax(){if(relays)return N-1;let r=0;for(let j=1;j<N;j++){if(arrival(j)>=TH)r=j;else break}return r}
function paint(){
 const rm=reachMax();
 for(let i=0;i<N;i++){
  const on=state[i];
  $('cn'+i).setAttribute('fill',on?(i==N-1?'#ffeb3b':'#ffb74d'):'#fff');
  $('ring'+i).setAttribute('opacity',on&&relays&&i>0?.45:(on&&i==0?.0:0));
  if(i<N-1){
   $('seg'+i).classList.toggle('hide',!on);
   $('ga'+i).setAttribute('stop-opacity',startS(i));
   $('gb'+i).setAttribute('stop-opacity',Math.max(arrival(i+1),.12));
  }
  const a=arrival(i),ok=i<=rm;
  const t=$('str'+i);
  t.textContent=i==0?'':Math.round(a*100)+'% arrives'+(ok?'':' – too weak');
  t.style.fill=ok?'#2e7d32':'#c62828';
  $('cn'+i).setAttribute('stroke',ok?'#333':'#c62828');
 }
 $('un').textContent=relays?
  'Each coil receives only a weakened current (about 60% of what was sent) – still above the minimum, so the relay closes. It closes a different circuit powered by that city\\'s own battery, which launches a fresh full-strength signal on the next stretch. The relay is a switch controlled by a switch: the message is re-created, not amplified, at every hop.':
  'No relays: a single battery has to push current through every stretch. It weakens with distance (here ×0.6 per stretch), so Salt Lake City gets about 22%, below the minimum, and the signal dies before California. Local batteries are unused.';
}
const morse={A:'.-',B:'-...',C:'-.-.',D:'-..',E:'.',F:'..-.',G:'--.',H:'....',I:'..',J:'.---',K:'-.-',L:'.-..',M:'--',N:'-.',O:'---',P:'.--.',Q:'--.-',R:'.-.',S:'...',T:'-',U:'..-',V:'...-',W:'.--',X:'-..-',Y:'-.--',Z:'--..'};
const rev={};for(const k in morse)rev[morse[k]]=k;
const unit=()=>+$('spd').value;
function mkDec(el){return {t0:0,t1:0,s:'',el,
 on(){const now=performance.now();if(this.t1&&this.s){const g=now-this.t1;if(g>5*unit())this.s+=' / ';else if(g>2*unit())this.s+=' ';}this.t0=now;},
 off(){const d=performance.now()-this.t0;this.s+=d<2*unit()?'.':'-';this.t1=performance.now();this.show()},
 show(){const txt=this.s.split(' ').map(w=>w==='/'?' ':(rev[w]||'')).join('');$(this.el).textContent=(this.s+'  →  '+txt)},
 reset(){this.s='';this.t0=this.t1=0;$(this.el).innerHTML='&nbsp;'}};}
const sentD=mkDec('sent'),recvD=mkDec('recv');
function setKey(on){
 if(on===keyOn)return;keyOn=on;on?sentD.on():sentD.off();
 for(let i=0;i<N;i++){timers.push(setTimeout(()=>{
  if(i>reachMax())return;
  state[i]=on;
  if(i==N-1){on?recvD.on():recvD.off()}
  paint();
 },i*HOP))}
}
function sendMsg(){
 if(busy)return;busy=true;sentD.reset();recvD.reset();
 const seq=[];const words=$('msg').value.split(' ');
 words.forEach((w,wi)=>{[...w].forEach((ch,ci)=>{[...morse[ch]].forEach((e,ei,arr)=>{seq.push([true,e=='.'?1:3]);seq.push([false,ei<arr.length-1?1:(ci<w.length-1?3:(wi<words.length-1?7:1))])})})});
 let t=0;
 seq.forEach(([on,u])=>{const at=t;timers.push(setTimeout(()=>setKey(on),at));t+=u*unit()});
 timers.push(setTimeout(()=>{setKey(false);busy=false},t+N*HOP+150));
}
$('send').onclick=sendMsg;
const hold=$('hold');
const down=e=>{if(!busy){e.preventDefault();setKey(true)}},up=()=>{if(!busy)setKey(false)};
hold.addEventListener('pointerdown',down);hold.addEventListener('pointerup',up);hold.addEventListener('pointerleave',up);
$('mode').onclick=()=>{
 timers.forEach(clearTimeout);timers=[];busy=false;keyOn=false;state.fill(false);
 relays=!relays;sentD.reset();recvD.reset();
 $('mode').textContent=relays?'Relays: ON (click to remove them)':'Relays: OFF (click to restore them)';
 $('mode').className=relays?'on':'bad';paint();
};
paint();
</script></body></html>
"
 :AT "2026-11-10T18:06:38" :VERSION 4)
(:ID "primitive-flip-flops-three-stages" :MAP "computers" :NODE "flip-flop" :TYPE "svg" :TITLE
 "Primitive flip-flops, three stages" :LANGUAGE NIL :CONTENT
 "<svg viewBox=\"0 0 900 400\" xmlns=\"http://www.w3.org/2000/svg\" font-family=\"sans-serif\" font-size=\"14\">
<rect width=\"900\" height=\"400\" fill=\"#fff\"/>
<g stroke=\"#222\" stroke-width=\"2\" fill=\"none\">
<!-- Panel 1 -->
<rect x=\"90\" y=\"130\" width=\"80\" height=\"60\" rx=\"10\" fill=\"#eef\"/>
<path d=\"M20 145 H90\"/><path d=\"M60 175 H90\"/>
<path d=\"M170 160 H270\"/>
<path d=\"M220 160 V240 H60 V175\" stroke=\"#d33\"/>
<!-- Panel 2 -->
<path d=\"M335 70 H565\"/>
<rect x=\"350\" y=\"90\" width=\"20\" height=\"35\"/><rect x=\"530\" y=\"90\" width=\"20\" height=\"35\"/>
<path d=\"M360 70 V90\"/><path d=\"M540 70 V90\"/>
<path d=\"M360 125 V170\"/><path d=\"M540 125 V170\"/>
<circle cx=\"360\" cy=\"200\" r=\"30\" fill=\"#efe\"/><circle cx=\"540\" cy=\"200\" r=\"30\" fill=\"#efe\"/>
<path d=\"M360 230 V280\"/><path d=\"M540 230 V280\"/>
<path d=\"M340 280 H380\"/><path d=\"M520 280 H560\"/>
<path d=\"M360 145 H435 V215 H510\" stroke=\"#d33\"/>
<path d=\"M540 145 H465 V185 H390\" stroke=\"#36c\"/>
<!-- Panel 3 -->
<rect x=\"660\" y=\"110\" width=\"80\" height=\"50\" rx=\"10\" fill=\"#eef\"/>
<rect x=\"660\" y=\"230\" width=\"80\" height=\"50\" rx=\"10\" fill=\"#eef\"/>
<path d=\"M610 125 H660\"/><path d=\"M610 265 H660\"/>
<path d=\"M740 135 H800\"/><path d=\"M740 255 H800\"/>
<path d=\"M760 135 V180 H640 V245 H660\" stroke=\"#d33\"/>
<path d=\"M770 255 V200 H630 V150 H660\" stroke=\"#36c\"/>
</g>
<g fill=\"#222\">
<text x=\"20\" y=\"30\" font-size=\"16\" font-weight=\"bold\">1. One gate, fed back</text>
<text x=\"20\" y=\"52\">Relay holding circuit / OR latch</text>
<text x=\"112\" y=\"165\">OR</text>
<text x=\"20\" y=\"138\">SET</text><text x=\"275\" y=\"165\">Q</text>
<text x=\"20\" y=\"280\">Set it and it stays 1 forever.</text>
<text x=\"20\" y=\"300\">No way to clear it: needs a reset.</text>

<text x=\"320\" y=\"30\" font-size=\"16\" font-weight=\"bold\">2. Eccles–Jordan, 1918</text>
<text x=\"320\" y=\"52\">Two cross-coupled triodes</text>
<text x=\"545\" y=\"65\">+V</text>
<text x=\"335\" y=\"148\">A</text><text x=\"552\" y=\"148\">B</text>
<text x=\"348\" y=\"205\">T1</text><text x=\"528\" y=\"205\">T2</text>
<text x=\"320\" y=\"320\">One tube conducts, pulling its plate low,</text>
<text x=\"320\" y=\"340\">which cuts off the other. Two stable states.</text>

<text x=\"600\" y=\"30\" font-size=\"16\" font-weight=\"bold\">3. SR latch, NOR gates</text>
<text x=\"600\" y=\"52\">Same loop in logic form</text>
<text x=\"683\" y=\"140\">NOR</text><text x=\"683\" y=\"260\">NOR</text>
<text x=\"590\" y=\"130\">R</text><text x=\"590\" y=\"270\">S</text>
<text x=\"805\" y=\"140\">Q</text><text x=\"805\" y=\"260\">Q̄</text>
<text x=\"600\" y=\"320\">S=1 sets Q=1; R=1 clears it.</text>
<text x=\"600\" y=\"340\">S=R=0: holds. Avoid S=R=1.</text>
</g>
<text x=\"20\" y=\"385\" fill=\"#555\">Red and blue wires are the two feedback paths; each stage's output forces the other's input.</text>
</svg>"
 :AT "2026-11-10T18:19:10" :VERSION 1)
(:ID "sr-latch-three-hardwares" :MAP "computers" :NODE NIL :TYPE "html" :TITLE
 "SR latch: three hardwares" :LANGUAGE NIL :CONTENT "<!DOCTYPE html>
<html><head><meta charset=\"utf-8\"><style>
body{font-family:system-ui,sans-serif;margin:0;padding:14px;background:#fff;color:#222}
h2{margin:0 0 4px;font-size:18px}
.row{display:flex;flex-wrap:wrap;gap:18px;align-items:center;margin:10px 0}
.grp{display:flex;gap:0;border:1px solid #adb5bd;border-radius:8px;overflow:hidden}
.grp button{border:0;background:#f1f3f5;padding:8px 14px;font-size:14px;cursor:pointer}
.grp button.on{background:#228be6;color:#fff}
.inp{display:flex;align-items:center;gap:8px}
.inp button{width:84px;padding:10px 0;font-size:15px;border-radius:8px;border:2px solid #868e96;background:#fff;cursor:pointer;font-weight:bold}
.inp button.on{background:#2f9e44;border-color:#2f9e44;color:#fff}
#status{font-size:16px;padding:8px 12px;background:#f8f9fa;border-left:4px solid #228be6;margin:8px 0}
#note{font-size:14px;color:#444;line-height:1.45;margin:6px 0}
svg{width:100%;max-width:820px;height:auto;border:1px solid #dee2e6;border-radius:8px}
.small{font-size:13px;color:#666}
</style></head><body>
<h2>SR latch: same loop, different switches</h2>
<div class=\"small\">Two NOR gates, each output feeding the other's input. Click S and R, then switch the hardware underneath: the behaviour does not change.</div>
<div class=\"row\">
 <div class=\"inp\"><span><b>Inputs</b></span><button id=\"bS\" onclick=\"tog('S')\">S = 0</button><button id=\"bR\" onclick=\"tog('R')\">R = 0</button></div>
 <div class=\"grp\" id=\"hw\"></div>
</div>
<div id=\"status\"></div>
<svg id=\"svg\" viewBox=\"0 0 780 490\"></svg>
<div id=\"note\"></div>
<div class=\"small\">Green = high (1), grey = low (0). Crossing wires without a dot are not connected. The tube version omits the voltage level-shifting divider a real tube circuit needs between stages.</div>
<script>
const HI='#2f9e44',LO='#868e96',INK='#222';
let S=0,R=0,Q=0,Qb=1,hw='transistor';
const HW={logic:'Logic symbols',transistor:'Transistors',relay:'Relays',tube:'Vacuum tubes'};
const NOTES={
logic:'Abstract view: a NOR gate outputs 1 only when both inputs are 0. Everything below is a way of building that one box.',
transistor:'NOR from MOSFETs: a pull-up resistor tries to hold the output high; either transistor, when its gate goes high, conducts and pulls the output to ground. Parallel switches = OR, inverted by the resistor = NOR. Switching time: nanoseconds or less.',
relay:'NOR from relays: power reaches the output through two normally-closed contacts in series. Either coil energised opens its contact and cuts the power; a resistor then pulls the output to ground. Series contacts, inverted = NOR. Switching time: milliseconds (you can hear it click).',
tube:'NOR from triodes: both tubes share one plate resistor to +V. A positive grid lets current flow from plate to cathode, dragging the plate (the output) low; either tube can do it. Parallel switches, inverted = NOR. Switching time: microseconds, and the filaments glow.'};
function nor(a,b){return (a||b)?0:1}
function settle(){
 for(let i=0;i<10;i++){
  const nq=nor(R,Qb), nqb=nor(S,Q);
  const ch=[];
  if(nq!==Q)ch.push('q'); if(nqb!==Qb)ch.push('b');
  if(!ch.length)return;
  const pick=ch[Math.floor(Math.random()*ch.length)];
  if(pick==='q')Q=nq; else Qb=nqb;
 }
}
function tog(n){
 if(n==='S')S^=1; else R^=1;
 const wasBoth=(Q===0&&Qb===0);
 settle(); render(wasBoth);
}
let raced=false;
function render(wasBoth){
 raced=!!wasBoth&&Q!==Qb&&!S&&!R;
 bS.textContent='S = '+S;bS.className=S?'on':'';
 bR.textContent='R = '+R;bR.className=R?'on':'';
 document.querySelectorAll('#hw button').forEach(b=>b.className=b.dataset.k===hw?'on':'');
 let t;
 if(S&&R)t='<b>Forbidden:</b> S=R=1 forces both outputs to 0, so Q and Q̄ are no longer opposites.';
 else if(S)t='S=1: Set. Q̄ is forced low, so Q is high. <b>Q = '+Q+'</b>';
 else if(R)t='R=1: Reset. Q is forced low, so Q̄ is high. <b>Q = '+Q+'</b>';
 else t='S=R=0: <b>Hold</b>. The loop keeps whatever it had. <b>Q = '+Q+'</b>'+(raced?' (released from S=R=1: a race, so the winner was random)':'');
 status.innerHTML=t;
 note.textContent=NOTES[hw];
 svg.innerHTML=draw();
}
const w=(d,s,extra='')=>`<path d=\"${d}\" fill=\"none\" stroke=\"${s?HI:LO}\" stroke-width=\"3\" ${extra}/>`;
const k=(d,extra='')=>`<path d=\"${d}\" fill=\"none\" stroke=\"${INK}\" stroke-width=\"2\" ${extra}/>`;
const tx=(x,y,s,sz=13,fill=INK,anc='start')=>`<text x=\"${x}\" y=\"${y}\" font-size=\"${sz}\" fill=\"${fill}\" text-anchor=\"${anc}\">${s}</text>`;
function res(x,y1,y2){const n=6,h=(y2-y1-16)/n;let d=`M${x} ${y1} v8`;for(let i=0;i<n;i++)d+=` l${i%2?-7:7} ${h/2*0+h}`;d+=` L${x} ${y2-8} V${y2}`;return k(d)}
function gnd(x,y){return k(`M${x} ${y}v6M${x-9} ${y+6}h18M${x-6} ${y+10}h12M${x-3} ${y+14}h6`)}
const dot=(x,y,s)=>`<circle cx=\"${x}\" cy=\"${y}\" r=\"4\" fill=\"${s?HI:LO}\"/>`;
function gate(y,a,b,o,name){
 let s=`<rect x=\"130\" y=\"${y}\" width=\"430\" height=\"200\" rx=\"10\" fill=\"#f8f9fa\" stroke=\"#ced4da\" stroke-dasharray=\"5 4\"/>`;
 s+=tx(140,y+16,name,12,'#666');
 const A=y+50,B=y+130,O=y+100;
 // leads
 s+=w(`M130 ${A}H${hw==='logic'?250:300}`,a)+w(`M130 ${B}H${hw==='logic'?250:300}`,b);
 if(hw==='logic'){
  s+=`<path d=\"M250 ${y+30} H320 Q400 ${y+30} 430 ${y+100} Q400 ${y+170} 320 ${y+170} H250 Q285 ${y+100} 250 ${y+30}Z\" fill=\"#e7f5ff\" stroke=\"${INK}\" stroke-width=\"2\"/>`;
  s+=`<circle cx=\"438\" cy=\"${O}\" r=\"8\" fill=\"#fff\" stroke=\"${INK}\" stroke-width=\"2\"/>`;
  s+=tx(335,O+5,'NOR',15,INK,'middle');
  s+=w(`M250 ${A}H265`,a)+w(`M250 ${B}H265`,b)+w(`M446 ${O}H560`,o);
 } else if(hw==='transistor'){
  s+=tx(445,y+14,'+V',12);s+=k(`M470 ${y+20}V${y+26}`)+res(470,y+26,O)+w(`M470 ${O-8}V${O}`,o);
  s+=w(`M320 ${O}H470`,o)+w(`M470 ${O}H560`,o)+dot(320,O,o)+dot(400,O,o)+dot(470,O,o);
  // T1 gets B, T2 gets A
  const T=(x,gy,on,sig)=>`<rect x=\"${x}\" y=\"${y+110}\" width=\"40\" height=\"40\" rx=\"4\" fill=\"${on?'#ffec99':'#fff'}\" stroke=\"${INK}\" stroke-width=\"2\"/>`+
    k(`M${x} ${gy}h8`)+k(`M${x+8} ${y+116}v28`)+k(`M${x+14} ${y+116}v28`)+tx(x+20,y+134,'',1)+
    k(`M${x+20} ${y+110}V${O}`)+k(`M${x+20} ${y+150}V${y+170}`)+tx(x+27,y+142,on?'ON':'off',10,on?'#e67700':'#666');
  s+=w(`M300 ${B}h0`,b)+T(300,B,b)+w(`M360 ${A}`,a);
  s+=w(`M130 ${A}H360V${y+120}H380`,a)+T(380,y+120,a);
  s+=k(`M320 ${y+170}H400`)+k(`M360 ${y+170}V${y+174}`)+gnd(360,y+174);
  s+=tx(300,y+106,'',1)+tx(300,y+192,'MOSFETs in parallel',11,'#666');
 } else if(hw==='relay'){
  s+=tx(455,y+14,'+V',12);s+=k(`M450 ${y+18}V${y+24}`);
  const C=(cy1,cy2,on)=>{ // contact between cy1..cy2
   let r=k(`M450 ${cy1}V${cy1+4}`)+k(`M450 ${cy2-4}V${cy2}`)+`<circle cx=\"450\" cy=\"${cy1+4}\" r=\"3\" fill=\"${INK}\"/><circle cx=\"450\" cy=\"${cy2-4}\" r=\"3\" fill=\"${INK}\"/>`;
   r+= on? k(`M450 ${cy1+4}L463 ${cy2-10}`) : k(`M450 ${cy1+4}V${cy2-4}`);
   return r};
  s+=C(y+24,y+56,a)+C(y+62,y+94,b);
  s+=w(`M450 ${y+56}V${y+62}`,!a)+w(`M450 ${y+94}V${O}`,o);
  s+=w(`M450 ${y+24}V${y+24}`,1);
  s+=w(`M320 0`,0);
  // pull-down
  s+=w(`M450 ${O}H560`,o)+w(`M450 ${O}V${O+4}`,o)+res(450,O+4,y+168)+gnd(450,y+168);
  // coils
  const coil=(cy,sig)=>`<rect x=\"300\" y=\"${cy-14}\" width=\"50\" height=\"28\" rx=\"4\" fill=\"${sig?'#ffec99':'#fff'}\" stroke=\"${INK}\" stroke-width=\"2\"/>`+
    k(`M308 ${cy-6}q4 -4 8 0t8 0t8 0t8 0`)+k(`M308 ${cy+6}q4 -4 8 0t8 0t8 0t8 0`)+k(`M325 ${cy+14}v8`)+gnd(325,cy+22)+tx(358,cy-18,'coil',11,'#666');
  s+=coil(A,a)+coil(B,b);
  s+=k(`M350 ${A}L440 ${y+40}`,'stroke-dasharray=\"4 3\" stroke=\"#e8590c\"')+k(`M350 ${B}L440 ${y+77}`,'stroke-dasharray=\"4 3\" stroke=\"#e8590c\"');
  s+=tx(360,y+192,'normally-closed contacts in series',11,'#666');
 } else { // tube
  s+=tx(445,y+14,'+V',12);s+=k(`M470 ${y+20}V${y+26}`)+res(470,y+26,O);
  s+=w(`M320 ${O}H560`,o)+dot(410,O,o)+dot(470,O,o)+dot(320,O,o);
  const V=(cx,gy,on)=>{const cy=y+130;
   let r=`<circle cx=\"${cx}\" cy=\"${cy}\" r=\"26\" fill=\"${on?'#ffd8a8':'#fff'}\" stroke=\"${INK}\" stroke-width=\"2\"/>`;
   r+=k(`M${cx} ${O}V${cy-16}`)+k(`M${cx-10} ${cy-16}h20`)+k(`M${cx-10} ${cy}h20`,'stroke-dasharray=\"4 3\"')+k(`M${cx-26} ${gy}H${cx-10}`)+k(`M${cx-8} ${cy+14}q4 4 8 0t8 0`)+k(`M${cx} ${cy+16}V${y+172}`);
   r+=on? `<path d=\"M${cx} ${cy-14}V${cy+14}\" stroke=\"#e8590c\" stroke-width=\"3\" stroke-dasharray=\"3 3\"/>`:'';
   return r+tx(cx+30,cy-12,on?'flows':'cut off',10,on?'#e67700':'#666')};
  s+=w(`M130 ${B}H294`,b)+V(320,B,b);
  s+=w(`M130 ${A}H365V${y+130}H384`,a)+V(410,y+130,a);
  s+=k(`M320 ${y+172}H410`)+gnd(365,y+172);
  s+=tx(300,y+196,'triodes sharing one plate resistor',11,'#666');
 }
 return s;
}
function draw(){
 const yt=20,yb=270;
 let s='';
 s+=gate(yt,R,Qb,Q,'Gate 1: inputs R, Q̄ → output Q');
 s+=gate(yb,S,Q,Qb,'Gate 2: inputs S, Q → output Q̄');
 // input leads and labels
 s+=w('M44 70H130',R)+w('M44 320H130',S);
 s+=`<circle cx=\"26\" cy=\"70\" r=\"16\" fill=\"${R?HI:'#fff'}\" stroke=\"${INK}\" stroke-width=\"2\"/>`+tx(26,75,'R',14,R?'#fff':INK,'middle');
 s+=`<circle cx=\"26\" cy=\"320\" r=\"16\" fill=\"${S?HI:'#fff'}\" stroke=\"${INK}\" stroke-width=\"2\"/>`+tx(26,325,'S',14,S?'#fff':INK,'middle');
 // feedback
 s+=w('M560 120H700',Q)+w('M600 120V235H90V400H130',Q)+dot(600,120,Q);
 s+=w('M560 370H700',Qb)+w('M640 370V255H60V150H130',Qb)+dot(640,370,Qb);
 s+=`<circle cx=\"722\" cy=\"120\" r=\"18\" fill=\"${Q?HI:'#fff'}\" stroke=\"${INK}\" stroke-width=\"2\"/>`+tx(722,125,'Q',15,Q?'#fff':INK,'middle');
 s+=`<circle cx=\"722\" cy=\"370\" r=\"18\" fill=\"${Qb?HI:'#fff'}\" stroke=\"${INK}\" stroke-width=\"2\"/>`+tx(722,375,'Q̄',15,Qb?'#fff':INK,'middle');
 s+=tx(722,152,'Q='+Q,12,INK,'middle')+tx(722,402,'Q̄='+Qb,12,INK,'middle');
 s+=tx(420,247,'feedback: Q → gate 2',11,'#666','middle');
 return s;
}
const g=document.getElementById('hw');
Object.keys(HW).forEach(kk=>{const b=document.createElement('button');b.textContent=HW[kk];b.dataset.k=kk;b.onclick=()=>{hw=kk;render()};g.appendChild(b)});
const bS=document.getElementById('bS'),bR=document.getElementById('bR'),status=document.getElementById('status'),note=document.getElementById('note'),svg=document.getElementById('svg');
render();
</script></body></html>
"
 :AT "2026-11-10T18:28:33" :VERSION 1)
(:PINNED T :ID "flip-flops-with-live-sr-latch" :MAP "computers" :NODE "flip-flop" :TYPE "html"
 :TITLE "Flip-flops with live SR latch" :LANGUAGE NIL :CONTENT
 "<!DOCTYPE html><html><head><meta charset=\"utf-8\"><style>
body{font-family:sans-serif;margin:0;padding:12px;background:#fff;color:#222}
h2{font-size:17px;margin:18px 0 6px}
.row{display:flex;flex-wrap:wrap;gap:10px;align-items:center;margin:8px 0}
button{font-size:14px;padding:8px 14px;border:2px solid #222;background:#f4f4f4;border-radius:8px;cursor:pointer}
button.on{background:#d33;color:#fff;border-color:#d33}
button.pw{background:#2a2;color:#fff;border-color:#2a2}
button.pwoff{background:#444;color:#fff;border-color:#444}
button.hw.sel{background:#36c;color:#fff;border-color:#36c}
.out{font-size:16px;padding:8px 12px;background:#eef;border-radius:8px}
.note{color:#555;font-size:13px;margin-top:6px}
.pnote{color:#7a4a00;font-size:13px;margin-top:6px;background:#fff6e5;padding:8px;border-radius:8px}
#view{max-width:760px}
svg{width:100%;height:auto}
</style></head><body>
<svg viewBox=\"0 0 900 400\" xmlns=\"http://www.w3.org/2000/svg\" font-family=\"sans-serif\" font-size=\"14\">
<rect width=\"900\" height=\"400\" fill=\"#fff\"/>
<g stroke=\"#222\" stroke-width=\"2\" fill=\"none\">
<rect x=\"90\" y=\"130\" width=\"80\" height=\"60\" rx=\"10\" fill=\"#eef\"/>
<path d=\"M20 145 H90\"/><path d=\"M60 175 H90\"/>
<path d=\"M170 160 H270\"/>
<path d=\"M220 160 V240 H60 V175\" stroke=\"#d33\"/>
<path d=\"M335 70 H565\"/>
<rect x=\"350\" y=\"90\" width=\"20\" height=\"35\"/><rect x=\"530\" y=\"90\" width=\"20\" height=\"35\"/>
<path d=\"M360 70 V90\"/><path d=\"M540 70 V90\"/>
<path d=\"M360 125 V170\"/><path d=\"M540 125 V170\"/>
<circle cx=\"360\" cy=\"200\" r=\"30\" fill=\"#efe\"/><circle cx=\"540\" cy=\"200\" r=\"30\" fill=\"#efe\"/>
<path d=\"M360 230 V280\"/><path d=\"M540 230 V280\"/>
<path d=\"M340 280 H380\"/><path d=\"M520 280 H560\"/>
<path d=\"M360 145 H435 V215 H510\" stroke=\"#d33\"/>
<path d=\"M540 145 H465 V185 H390\" stroke=\"#36c\"/>
<rect x=\"660\" y=\"110\" width=\"80\" height=\"50\" rx=\"10\" fill=\"#eef\"/>
<rect x=\"660\" y=\"230\" width=\"80\" height=\"50\" rx=\"10\" fill=\"#eef\"/>
<path d=\"M610 125 H660\"/><path d=\"M610 265 H660\"/>
<path d=\"M740 135 H800\"/><path d=\"M740 255 H800\"/>
<path d=\"M760 135 V180 H640 V245 H660\" stroke=\"#d33\"/>
<path d=\"M770 255 V200 H630 V150 H660\" stroke=\"#36c\"/>
</g>
<!-- power legs -->
<g fill=\"none\" stroke-width=\"3\">
<path d=\"M130 112 V130\" stroke=\"#e08a00\"/><path d=\"M130 190 V204\" stroke=\"#666\"/>
<path d=\"M700 94 V110\" stroke=\"#e08a00\"/><path d=\"M700 160 V172\" stroke=\"#666\"/>
<path d=\"M700 214 V230\" stroke=\"#e08a00\"/><path d=\"M700 280 V294\" stroke=\"#666\"/>
</g>
<g font-size=\"12\">
<text x=\"136\" y=\"122\" fill=\"#e08a00\">Vcc</text><text x=\"136\" y=\"204\" fill=\"#666\">GND</text>
<text x=\"706\" y=\"104\" fill=\"#e08a00\">Vcc</text><text x=\"706\" y=\"170\" fill=\"#666\">GND</text>
<text x=\"706\" y=\"224\" fill=\"#e08a00\">Vcc</text><text x=\"706\" y=\"292\" fill=\"#666\">GND</text>
</g>
<g fill=\"#222\">
<text x=\"20\" y=\"30\" font-size=\"16\" font-weight=\"bold\">1. One gate, fed back</text>
<text x=\"20\" y=\"52\">Relay holding circuit / OR latch</text>
<text x=\"112\" y=\"165\">OR</text>
<text x=\"20\" y=\"138\">SET</text><text x=\"275\" y=\"165\">Q</text>
<text x=\"20\" y=\"280\">Set it and it stays 1 forever.</text>
<text x=\"20\" y=\"300\">No way to clear it: needs a reset.</text>
<text x=\"320\" y=\"30\" font-size=\"16\" font-weight=\"bold\">2. Eccles–Jordan, 1918</text>
<text x=\"320\" y=\"52\">Two cross-coupled triodes</text>
<text x=\"545\" y=\"65\">+V</text><text x=\"570\" y=\"300\" font-size=\"12\">(0 V / ground rail below)</text>
<text x=\"335\" y=\"148\">A</text><text x=\"552\" y=\"148\">B</text>
<text x=\"348\" y=\"205\">T1</text><text x=\"528\" y=\"205\">T2</text>
<text x=\"320\" y=\"320\">One tube conducts, pulling its plate low,</text>
<text x=\"320\" y=\"340\">which cuts off the other. Two stable states.</text>
<text x=\"600\" y=\"30\" font-size=\"16\" font-weight=\"bold\">3. SR latch, NOR gates</text>
<text x=\"600\" y=\"52\">Same loop in logic form</text>
<text x=\"683\" y=\"140\">NOR</text><text x=\"683\" y=\"260\">NOR</text>
<text x=\"590\" y=\"130\">R</text><text x=\"590\" y=\"270\">S</text>
<text x=\"805\" y=\"140\">Q</text><text x=\"805\" y=\"260\">Q̄</text>
<text x=\"600\" y=\"320\">S=1 sets Q=1; R=1 clears it.</text>
<text x=\"600\" y=\"340\">S=R=0: holds. Avoid S=R=1.</text>
</g>
<text x=\"20\" y=\"375\" fill=\"#555\">Red and blue wires are the two feedback paths; each stage's output forces the other's input.</text>
<text x=\"20\" y=\"392\" fill=\"#e08a00\">Orange = power (Vcc / +V), grey = ground. Every gate needs these as well as its input legs: the gate's output is power being steered.</text>
</svg>

<h2>Try it: an SR latch built from two NOR gates</h2>
<div class=\"row\">
  <button id=\"bP\" class=\"pw\">Power: ON</button>
  <button id=\"bS\">S = 0</button><button id=\"bR\">R = 0</button>
  <span class=\"out\" id=\"state\"></span>
</div>
<div class=\"row\">
  <b>Gate hardware:</b>
  <button class=\"hw\" data-m=\"logic\">Logic symbol</button>
  <button class=\"hw\" data-m=\"relay\">Relay</button>
  <button class=\"hw\" data-m=\"tube\">Vacuum tube</button>
  <button class=\"hw\" data-m=\"cmos\">Transistor (CMOS)</button>
</div>
<div id=\"view\"></div>
<div class=\"note\" id=\"note\"></div>
<div class=\"pnote\" id=\"pnote\"></div>

<script>
let S=0,R=0,Q=0,Qb=1,mode='logic';
let P=1,lv=1,lost=false,raf=null;
const D=3000; // animation length (ms), slowed down from real time
const nor=(a,b)=>(a||b)?0:1;
function col(v){
  if(lost) return '#ccc';
  if(!v) return lv<1?'#bbb':'#888';
  const f=Math.max(0,Math.min(1,lv));
  const mix=(a,b)=>Math.round(b+(a-b)*f);
  return `rgb(${mix(221,190)},${mix(51,190)},${mix(51,190)})`;
}
function pc(){return lost?'#ccc':(lv<1?`rgb(${Math.round(190+(224-190)*lv)},${Math.round(190-(190-138)*lv)},${Math.round(190-190*lv)})`:'#e08a00')}
function settle(){
  for(let i=0;i<8;i++){
    const nq=nor(R,Qb); const nqb=nor(S,nq);
    if(nq===Q&&nqb===Qb)break; Q=nq;Qb=nqb;
  }
}
function T(x,y,s,o={}){return `<text x=\"${x}\" y=\"${y}\" font-size=\"${o.sz||14}\" fill=\"${o.fill||'#222'}\" text-anchor=\"${o.a||'start'}\">${s}</text>`}
function L(d,c='#222',w=2,extra=''){return `<path d=\"${d}\" stroke=\"${c}\" stroke-width=\"${w}\" fill=\"none\" ${extra}/>`}
function dot(x,y,c='#222'){return `<circle cx=\"${x}\" cy=\"${y}\" r=\"4\" fill=\"${c}\"/>`}
function gnd(x,y){return L(`M${x} ${y} V${y+6}`)+L(`M${x-12} ${y+6} H${x+12}`)+L(`M${x-8} ${y+12} H${x+8}`)+L(`M${x-4} ${y+18} H${x+4}`)}

function logicView(){
  let s=`<svg viewBox=\"0 0 520 250\">`;
  s+=L(`M20 45 H240`,col(R))+T(20,38,'R');
  s+=L(`M20 175 H240`,col(S))+T(20,168,'S');
  s+=L(`M320 55 H480`,col(Q))+T(485,60,'Q='+Q);
  s+=L(`M320 165 H480`,col(Qb))+T(485,170,'Q̄='+Qb);
  s+=L(`M360 55 V125 H200 V150 H240`,col(Q));
  s+=L(`M400 165 V105 H215 V65 H240`,col(Qb));
  for(const y of [30,140]){
    s+=L(`M280 ${y-18} V${y}`,pc(),3)+T(286,y-6,'Vcc',{sz:12,fill:pc()});
    s+=L(`M280 ${y+50} V${y+62}`,lost?'#ccc':'#666',3)+T(286,y+70,'GND',{sz:12,fill:'#666'});
    s+=`<rect x=\"240\" y=\"${y}\" width=\"80\" height=\"50\" rx=\"10\" fill=\"#eef\" stroke=\"#222\" stroke-width=\"2\"/>`+T(280,y+30,'NOR',{a:'middle'});
  }
  return s+`</svg>`;
}

function relayG(a,b,out){
  let s=T(420,10,'+V',{a:'middle',sz:12,fill:pc()})+L('M420 14 V20',pc(),3);
  const ct=(y,open)=> open
    ? L(`M420 ${y} V${y+14}`)+L(`M420 ${y+14} L434 ${y+32}`,'#222',3)+L(`M414 ${y+38} H426`)+L(`M420 ${y+38} V${y+50}`)
    : L(`M420 ${y} V${y+50}`);
  s+=ct(20,a)+L('M420 70 V110')+ct(110,b)+L('M420 160 V175');
  for(const [y,v] of [[50,a],[150,b]]){
    s+=L(`M180 ${y} H400`,'#888',1.5,'stroke-dasharray=\"4 4\"');
    s+=L(`M60 ${y} H100`,col(v));
    s+=`<rect x=\"100\" y=\"${y-20}\" width=\"80\" height=\"40\" rx=\"6\" fill=\"${v?'#fdd':'#f4f4f4'}\" stroke=\"#222\" stroke-width=\"2\"/>`+T(140,y+4,'coil',{a:'middle',sz:12});
  }
  s+=`<rect x=\"408\" y=\"175\" width=\"24\" height=\"30\" fill=\"#fff\" stroke=\"#222\" stroke-width=\"2\"/>`+L('M420 205 V220')+gnd(420,220);
  s+=T(440,194,'R',{sz:12})+T(442,70,'contacts (NC)',{sz:11,fill:'#555'});
  s+=L('M420 175 H540 V100 H560',col(out))+dot(420,175,col(out));
  return s;
}
function tubeG(a,b,out){
  let s=T(335,10,'+V',{a:'middle',sz:12,fill:pc()})+L('M335 14 V22',pc(),3);
  s+=`<rect x=\"323\" y=\"22\" width=\"24\" height=\"32\" fill=\"#fff\" stroke=\"#222\" stroke-width=\"2\"/>`+T(355,42,'R',{sz:12});
  s+=L('M335 54 V70')+L('M250 70 H420',col(out))+dot(335,70,col(out));
  s+=L('M420 70 H540 V100 H560',col(out));
  s+=L('M250 215 H420')+gnd(335,215)+dot(335,215);
  s+=L('M60 50 H180 V110 H236',col(a));
  s+=L('M60 150 H244 a6 6 0 0 1 12 0 H406',col(b));
  [[250,110,a],[420,150,b]].forEach(([x,cy,v])=>{
    s+=L(`M${x} 70 V${cy-28}`,col(out))+L(`M${x} ${cy+28} V215`);
    s+=`<circle cx=\"${x}\" cy=\"${cy}\" r=\"28\" fill=\"${(v&&!lost&&lv>0.3)?'#ffd9a0':'#f4f4f4'}\" stroke=\"#222\" stroke-width=\"2\"/>`;
    s+=L(`M${x-12} ${cy-16} H${x+12}`)+L(`M${x-14} ${cy} H${x+14}`,'#222',1.5,'stroke-dasharray=\"4 3\"')+L(`M${x-12} ${cy+16} H${x+12}`);
  });
  s+=T(262,98,'plate',{sz:11,fill:'#555'})+T(432,138,'plate',{sz:11,fill:'#555'});
  return s;
}
function cmosG(a,b,out){
  let s=T(335,8,'+V',{a:'middle',sz:12,fill:pc()})+L('M335 12 V15',pc(),3);
  const tr=(x,y,kind,on)=>{const o=on&&!lost&&lv>0.5;return `<rect x=\"${x}\" y=\"${y}\" width=\"70\" height=\"34\" rx=\"6\" fill=\"${o?'#cfc':'#f4f4f4'}\" stroke=\"#222\" stroke-width=\"2\"/>`+T(x+35,y+15,kind,{a:'middle',sz:12})+T(x+35,y+29,o?'ON':'off',{a:'middle',sz:11,fill:o?'#070':'#888'})};
  s+=tr(300,15,'PMOS',!a)+L('M335 49 V70')+tr(300,70,'PMOS',!b)+L('M335 104 V125');
  s+=L('M265 125 H475',col(out))+dot(335,125,col(out));
  s+=L('M265 125 V165')+tr(230,165,'NMOS',a)+L('M265 199 V208')+gnd(265,208);
  s+=L('M475 125 V165')+tr(440,165,'NMOS',b)+L('M475 199 V208')+gnd(475,208);
  s+=L('M475 125 H540 V100 H560',col(out));
  s+=L('M60 50 H120 V32 H300',col(a))+L('M120 32 V182 H230',col(a))+dot(120,50,col(a));
  s+=L('M60 150 H114 a6 6 0 0 1 12 0 H200 V87 H300',col(b));
  s+=L('M200 150 H259 a6 6 0 0 1 12 0 H400 V182 H440',col(b))+dot(200,150,col(b));
  return s;
}
function gateG(oy,title,fn,a,b,out,l1,l2){
  return `<g transform=\"translate(0 ${oy})\">`+T(70,-4,title,{sz:13})+fn(a,b,out)+
    T(64,44,l1,{sz:12,fill:col(a)})+T(64,144,l2,{sz:12,fill:col(b)})+`</g>`;
}
function hwView(){
  const fn=mode==='relay'?relayG:mode==='tube'?tubeG:cmosG;
  let s=`<svg viewBox=\"0 0 760 600\">`;
  s+=L('M10 80 H60',col(R))+T(10,72,'R',{fill:col(R)});
  s+=L('M10 480 H60',col(S))+T(10,472,'S',{fill:col(S)});
  s+=gateG(30,'Gate 1: Q = NOR(R, Q̄)',fn,R,Qb,Q,'R','Q̄');
  s+=gateG(330,'Gate 2: Q̄ = NOR(S, Q)',fn,Q,S,Qb,'Q','S');
  s+=L('M560 130 H690 V295 H40 V380 H60',col(Q));
  s+=L('M560 430 H720 V315 H46 a6 6 0 0 0 -12 0 H20 V180 H60',col(Qb));
  s+=dot(600,130,col(Q))+dot(600,430,col(Qb));
  s+=T(610,122,'Q = '+Q,{fill:col(Q),sz:15})+T(610,422,'Q̄ = '+Qb,{fill:col(Qb),sz:15});
  s+=T(750,20,'supply: '+(P?'ON':'OFF'),{a:'end',sz:13,fill:P?'#e08a00':'#888'});
  return s+`</svg>`;
}
const notes={
 logic:'Logic view: Q = NOR(R, Q̄) and Q̄ = NOR(S, Q). Click S and R to change inputs. The Vcc and GND legs are drawn on each gate; the logic symbol normally hides them.',
 relay:'Relay NOR: each input energises a coil that opens a normally-closed contact. The contacts are in series from +V, so any energised coil breaks the path and OUT drops to 0. The outputs cross over to feed the other gate\\'s coil.',
 tube:'Tube NOR: two triodes share one plate resistor. A high grid on either tube lets current flow and pulls the plate low (inverting), so OUT is 1 only when both grids are low. The outputs cross over to drive the other gate\\'s grid.',
 cmos:'CMOS NOR: two PMOS in series pull OUT up only if both inputs are low; two NMOS in parallel pull OUT down if either input is high. The outputs cross over to drive the other gate\\'s inputs.'
};
const pnotes={
 logic:'Power off: a stored 1 is not a current circling the loop. It is a voltage that a gate is actively holding up from the supply. With no supply nothing holds it up, so it drains away. Animation is slowed down; in a real chip it is gone in about a nanosecond to a microsecond.',
 relay:'Power off: the coil current stops, the magnetic field collapses and the spring opens or closes the contacts within about 5–20 ms. The loop is gone in one relay-release time, not slowly.',
 tube:'Power off: with +V gone, no plate current can flow, so no tube can hold its plate low or high. The stored voltages (on the plate resistors and coupling capacitors) discharge in milliseconds, though the supply\\'s own capacitors can stretch that. The glowing filament cooling is irrelevant: it is slower than the loop dying.',
 cmos:'Power off: as Vcc falls the PMOS and NMOS stop conducting, so the output nodes float. Their tiny capacitance leaks away in about a nanosecond to a microsecond. This is why SRAM forgets the moment power drops.'
};
function frame(t0){
  return function f(now){
    lv=Math.max(0,1-(now-t0)/D);
    if(!lost&&lv<0.5){lost=true;Q=0;Qb=0;}
    render();
    if(lv>0&&P===0) raf=requestAnimationFrame(f);
  };
}
function setPower(p){
  if(raf)cancelAnimationFrame(raf);
  P=p;
  if(!p){raf=requestAnimationFrame(t=>frame(t)(t));}
  else{
    lv=1;
    if(lost){
      lost=false;
      Q=0;Qb=0;
      if(!S&&!R){Q=Math.random()<.5?1:0;Qb=1-Q;} // symmetric: a tiny imbalance picks a winner
    }
  }
  render();
}
function render(){
  if(P) settle();
  const bP=document.getElementById('bP');
  bP.textContent='Power: '+(P?'ON':'OFF');bP.className=P?'pw':'pwoff';
  document.getElementById('bS').textContent='S = '+S;document.getElementById('bS').className=S?'on':'';
  document.getElementById('bR').textContent='R = '+R;document.getElementById('bR').className=R?'on':'';
  let msg;
  if(!P){
    msg=lost?'Power off: the stored bit is gone. All wires at 0 V.':'Power off: voltages sagging ('+Math.round(lv*100)+'%). Bit still readable above 50%.';
  } else {
    msg = S&&R ? 'S=R=1: forbidden, both outputs forced to 0. Release one at a time.' :
            (Q===1&&Qb===0)?'Q = 1 (set)' : (Q===0&&Qb===1)?'Q = 0 (reset)' : 'Q = Q̄ = '+Q+' (invalid)';
    if(!S&&!R&&Q!==Qb) msg+=' – holding';
  }
  document.getElementById('state').textContent=msg;
  document.querySelectorAll('.hw').forEach(b=>b.classList.toggle('sel',b.dataset.m===mode));
  document.getElementById('note').textContent=notes[mode];
  document.getElementById('pnote').textContent=pnotes[mode];
  document.getElementById('view').innerHTML = mode==='logic'? logicView() : hwView();
}
document.getElementById('bP').onclick=()=>setPower(P?0:1);
document.getElementById('bS').onclick=()=>{S^=1;render()};
document.getElementById('bR').onclick=()=>{R^=1;render()};
document.querySelectorAll('.hw').forEach(b=>b.onclick=()=>{mode=b.dataset.m;render()});
render();
</script></body></html>
"
 :AT "2026-11-10T19:08:04" :VERSION 3)
(:PINNED T :ID "sr-latch-from-two-nor-gates" :MAP "computers" :NODE "flip-flop" :TYPE "svg" :TITLE
 "SR latch from two NOR gates" :LANGUAGE NIL :CONTENT
 "<svg viewBox=\"0 0 640 420\" xmlns=\"http://www.w3.org/2000/svg\" font-family=\"sans-serif\">
  <style>
    .lbl{font-size:16px;fill:#111}
    .pin{font-size:14px;fill:#333}
    .wire{stroke:#111;stroke-width:2;fill:none}
    .fb{stroke:#c0392b;stroke-width:2;fill:none;stroke-dasharray:5 4}
    .pwr{stroke:#e08a00;stroke-width:3;fill:none}
    .gnd{stroke:#666;stroke-width:3;fill:none}
    .gate{fill:#eef3fb;stroke:#2c3e50;stroke-width:2}
    .title{font-size:18px;fill:#111;font-weight:bold}
    .note{font-size:13px;fill:#555}
    .hdr{font-size:13px;fill:#111;font-weight:bold}
  </style>

  <text x=\"20\" y=\"28\" class=\"title\">SR latch: two NOR gates in a loop</text>

  <!-- power legs (drawn first so gates sit on top) -->
  <path d=\"M225,48 V78\" class=\"pwr\"/><text x=\"233\" y=\"58\" font-size=\"12\" fill=\"#e08a00\">Vcc</text>
  <path d=\"M225,135 V152\" class=\"gnd\"/><text x=\"233\" y=\"152\" font-size=\"12\" fill=\"#666\">GND</text>
  <path d=\"M250,208 V238\" class=\"pwr\"/><text x=\"258\" y=\"222\" font-size=\"12\" fill=\"#e08a00\">Vcc</text>
  <path d=\"M225,295 V322\" class=\"gnd\"/><text x=\"233\" y=\"334\" font-size=\"12\" fill=\"#666\">GND</text>

  <!-- NOR gate 1 (top) -->
  <g>
    <path d=\"M200,70 q30,0 55,35 q-25,35 -55,35 q15,-35 0,-70 z\" class=\"gate\"/>
    <circle cx=\"258\" cy=\"105\" r=\"5\" class=\"gate\"/>
    <text x=\"215\" y=\"110\" class=\"pin\">NOR</text>
  </g>
  <!-- NOR gate 2 (bottom) -->
  <g>
    <path d=\"M200,230 q30,0 55,35 q-25,35 -55,35 q15,-35 0,-70 z\" class=\"gate\"/>
    <circle cx=\"258\" cy=\"265\" r=\"5\" class=\"gate\"/>
    <text x=\"215\" y=\"270\" class=\"pin\">NOR</text>
  </g>

  <line x1=\"90\" y1=\"85\" x2=\"200\" y2=\"85\" class=\"wire\"/>
  <text x=\"70\" y=\"90\" class=\"lbl\">R</text>
  <line x1=\"90\" y1=\"285\" x2=\"200\" y2=\"285\" class=\"wire\"/>
  <text x=\"70\" y=\"290\" class=\"lbl\">S</text>

  <line x1=\"263\" y1=\"105\" x2=\"430\" y2=\"105\" class=\"wire\"/>
  <text x=\"440\" y=\"110\" class=\"lbl\">Q</text>
  <line x1=\"263\" y1=\"265\" x2=\"430\" y2=\"265\" class=\"wire\"/>
  <text x=\"440\" y=\"270\" class=\"lbl\">Q&#772;</text>

  <path d=\"M330,105 L330,160 L180,160 L180,250 L200,250\" class=\"fb\"/>
  <path d=\"M360,265 L360,200 L160,200 L160,120 L200,120\" class=\"fb\"/>

  <text x=\"300\" y=\"150\" class=\"note\">red = feedback: each output steers the other gate</text>

  <text x=\"330\" y=\"345\" class=\"note\">Orange = Vcc, grey = GND.</text>
  <text x=\"330\" y=\"362\" class=\"note\">Both gates need power; the outputs</text>
  <text x=\"330\" y=\"378\" class=\"note\">are supply voltage steered by inputs.</text>

  <text x=\"20\" y=\"345\" class=\"hdr\">S  R   →   Q</text>
  <text x=\"20\" y=\"368\" class=\"note\">0  0   hold previous Q   ← this is the memory</text>
  <text x=\"20\" y=\"388\" class=\"note\">1  0   Q = 1   (set)</text>
  <text x=\"20\" y=\"408\" class=\"note\">0  1   Q = 0   (reset)</text>
  <text x=\"330\" y=\"408\" class=\"note\">1  1   not allowed</text>
</svg>"
 :AT "2026-11-10T19:08:10" :VERSION 2)
(:ID "4-bit-ripple-adder" :MAP "computers" :NODE "adder" :TYPE "html" :TITLE "4-bit ripple adder"
 :LANGUAGE NIL :CONTENT "<!DOCTYPE html><html><head><meta charset=\"utf-8\"><style>
body{font-family:system-ui,sans-serif;margin:16px;color:#222;max-width:680px}
.row{display:flex;gap:8px;justify-content:center;margin:6px 0}
.col{width:140px;border:2px solid #888;border-radius:8px;padding:8px;font-size:14px;line-height:1.5}
.col h4{margin:0 0 4px;text-align:center}
.col .lbl{font-size:11px;text-transform:uppercase;color:#777;margin-top:6px;letter-spacing:.05em}
button{font-size:20px;width:44px;height:44px;border-radius:8px;border:2px solid #444;cursor:pointer}
.on{background:#2a9d4a;color:#fff}.off{background:#eee}
.bit{display:inline-block;width:30px;height:30px;line-height:30px;border-radius:50%;font-weight:bold;color:#fff;text-align:center}
.b1{background:#2a9d4a}.b0{background:#999}
.carry{color:#c0392b;font-weight:bold}
h3{margin:4px 0}
</style></head><body>
<h3>Add two 4-bit numbers</h3>
<p style=\"font-size:14px\">Click bits to flip them. Each column adds its two bits plus the carry from the column on its right.</p>
<div>A: <span id=\"A\"></span> = <b id=\"an\"></b></div><div>B: <span id=\"B\"></span> = <b id=\"bn\"></b></div>
<div class=\"row\" id=\"cols\"></div>
<div id=\"out\" style=\"text-align:center;font-size:18px;margin-top:10px\"></div>
<script>
let A=[0,1,1,0],B=[0,0,1,1]; // index 0 = leftmost (bit3)
function mk(id,arr){const s=document.getElementById(id);s.innerHTML='';arr.forEach((v,i)=>{const b=document.createElement('button');b.textContent=v;b.className=v?'on':'off';b.onclick=()=>{arr[i]^=1;draw()};s.appendChild(b)})}
function draw(){mk('A',A);mk('B',B);
const val=a=>parseInt(a.join(''),2);an.textContent=val(A);bn.textContent=val(B);
let c=0,sums=[],html=[];
for(let i=3;i>=0;i--){const a=A[i],b=B[i],x=a^b,s=x^c,co=(a&b)|(c&x);
const first=i===3;
html[i]=`<div class=\"col\"><h4>Bit ${3-i}</h4>
<div class=\"lbl\">Inputs</div>A = ${a}<br>B = ${b}${first?'':`<br>Carry in = <span class=\"carry\">${c}</span>`}
<div class=\"lbl\">Outputs</div><b>Sum = ${s}</b><br>Carry out = <span class=\"carry\">${co}</span></div>`;
sums[i]=s;c=co}
cols.innerHTML=html.join('');
const r=(c<<4)+val(sums);
out.innerHTML=`Result: <span class=\"bit b${c}\">${c}</span> `+sums.map(s=>`<span class=\"bit b${s}\">${s}</span>`).join(' ')+` = <b>${r}</b> &nbsp;(${val(A)} + ${val(B)} = ${val(A)+val(B)})`}
draw();
</script></body></html>
"
 :AT "2026-11-13T17:01:25" :VERSION 2)
(:PINNED T :ID "and-or-not-from-transistors" :MAP "computers" :NODE "logic-gates" :TYPE "html"
 :TITLE "AND, OR, NOT from transistors" :LANGUAGE NIL :CONTENT
 "<!DOCTYPE html><html><head><meta charset=\"utf-8\"><style>
body{font-family:system-ui,sans-serif;margin:12px;background:#fafafa;color:#222}
h2{font-size:16px;margin:0 0 4px}p.s{margin:0 0 12px;font-size:13px;color:#555}
.row{display:flex;flex-wrap:wrap;gap:12px}
.card{background:#fff;border:1px solid #ddd;border-radius:10px;padding:10px;flex:1;min-width:230px;max-width:300px}
.card h3{margin:0 0 4px;font-size:15px}
button{font-size:14px;padding:6px 12px;margin:2px;border-radius:6px;border:1px solid #888;background:#eee;cursor:pointer}
button.on{background:#2f9e44;color:#fff;border-color:#2f9e44}
.r{font-size:13px;margin-top:4px;min-height:34px}
</style></head><body>
<h2>Transistors as switches</h2>
<p class=\"s\">Each box is an NMOS transistor: input 1 = closed (green), 0 = open (grey). Orange wire = connected to supply (1). Click the buttons or the transistors.</p>
<div class=\"row\">
<div class=\"card\"><h3>AND: switches in series</h3><svg id=\"s0\" viewBox=\"0 0 240 270\"></svg><div id=\"b0\"></div><div class=\"r\" id=\"r0\"></div></div>
<div class=\"card\"><h3>OR: switches in parallel</h3><svg id=\"s1\" viewBox=\"0 0 240 270\"></svg><div id=\"b1\"></div><div class=\"r\" id=\"r1\"></div></div>
<div class=\"card\"><h3>NOT: switch to ground</h3><svg id=\"s2\" viewBox=\"0 0 240 270\"></svg><div id=\"b2\"></div><div class=\"r\" id=\"r2\"></div></div>
</div>
<script>
const S=[[0,0],[0,0],[0]], N=['A','B'];
const ln=(x1,y1,x2,y2,l)=>`<line x1=\"${x1}\" y1=\"${y1}\" x2=\"${x2}\" y2=\"${y2}\" stroke=\"${l?'#e8590c':'#adb5bd'}\" stroke-width=\"5\" stroke-linecap=\"round\"/>`;
const tr=(c,x,y,i,on)=>`<g onclick=\"t(${c},${i})\" style=\"cursor:pointer\"><rect x=\"${x-24}\" y=\"${y}\" width=\"48\" height=\"36\" rx=\"6\" fill=\"${on?'#2f9e44':'#dee2e6'}\" stroke=\"#495057\" stroke-width=\"2\"/><text x=\"${x}\" y=\"${y+23}\" text-anchor=\"middle\" font-size=\"14\" fill=\"${on?'#fff':'#333'}\">${N[i]} ${on?'on':'off'}</text></g>`;
const lamp=(x,y,on)=>`<circle cx=\"${x}\" cy=\"${y}\" r=\"16\" fill=\"${on?'#ffd43b':'#f1f3f5'}\" stroke=\"#495057\" stroke-width=\"2\"/><text x=\"${x}\" y=\"${y+5}\" text-anchor=\"middle\" font-size=\"13\">out</text>`;
const tx=(x,y,s)=>`<text x=\"${x}\" y=\"${y}\" text-anchor=\"middle\" font-size=\"12\" fill=\"#555\">${s}</text>`;
function draw(){
 let [a,b]=S[0],o,h;
 o=a&b;
 h=tx(120,12,'VCC (1)')+ln(120,18,120,40,1)+tr(0,120,40,0,a)+ln(120,76,120,108,a)+tr(0,120,108,1,b)+ln(120,144,120,190,o)+lamp(120,206,o)+ln(120,222,120,243,0)+tx(120,260,'GND (0)');
 s0.innerHTML=h; r0.textContent=`A=${a} B=${b} → out ${o}: current reaches the lamp only if both are closed.`;
 [a,b]=S[1];o=a|b;
 h=tx(120,12,'VCC (1)')+ln(120,18,120,30,1)+ln(60,30,180,30,1)+ln(60,30,60,46,1)+ln(180,30,180,46,1)+tr(1,60,46,0,a)+tr(1,180,46,1,b)+ln(60,82,60,130,a)+ln(180,82,180,130,b)+ln(60,130,180,130,o)+ln(120,130,120,190,o)+lamp(120,206,o)+ln(120,222,120,243,0)+tx(120,260,'GND (0)');
 s1.innerHTML=h; r1.textContent=`A=${a} B=${b} → out ${o}: either closed switch gives a path.`;
 a=S[2][0];o=a?0:1;
 h=tx(100,12,'VCC (1)')+ln(100,18,100,40,1)+`<rect x=\"86\" y=\"40\" width=\"28\" height=\"36\" fill=\"#fff\" stroke=\"#495057\" stroke-width=\"2\"/>`+tx(100,63,'R')+ln(100,76,100,108,o)+ln(100,93,190,93,o)+ln(190,93,190,190,o)+tr(2,100,108,0,a)+ln(100,144,100,243,0)+tx(100,260,'GND (0)')+lamp(190,206,o)+ln(190,222,190,243,0)+tx(190,260,'GND');
 s2.innerHTML=h; r2.textContent=`A=${a} → out ${o}: closed switch pulls the output to ground (0); open lets the resistor pull it up (1).`;
 for(let c=0;c<3;c++){document.getElementById('b'+c).innerHTML=S[c].map((v,i)=>`<button class=\"${v?'on':''}\" onclick=\"t(${c},${i})\">${N[i]} = ${v}</button>`).join('')}
}
function t(c,i){S[c][i]^=1;draw()}
draw();
</script></body></html>"
 :AT "2026-11-13T18:56:50" :VERSION 1)
(:PINNED T :ID "gates-are-voltages-with-delay" :MAP "computers" :NODE "logic-gates" :TYPE "html"
 :TITLE "Gates are voltages, with delay" :LANGUAGE NIL :CONTENT
 "<!DOCTYPE html><html><head><meta charset=\"utf-8\"><style>
body{font-family:system-ui,sans-serif;margin:12px;background:#fafafa;color:#222;max-width:760px}
h2{font-size:16px;margin:14px 0 4px}p{font-size:13px;color:#444;margin:4px 0 8px;line-height:1.45}
.box{background:#fff;border:1px solid #ddd;border-radius:10px;padding:10px;margin-bottom:12px}
canvas{width:100%;display:block}
label{font-size:13px;display:block;margin:6px 0 2px}input[type=range]{width:100%}
.st{display:flex;gap:6px;margin-top:6px}.st div{flex:1;text-align:center;font-size:12px;border:1px solid #ccc;border-radius:8px;padding:6px;background:#f8f9fa}
.bar{height:60px;border:2px solid #495057;border-radius:4px;position:relative;background:#f1f3f5;margin:4px auto;width:34px;overflow:hidden}
.fill{position:absolute;bottom:0;left:0;right:0;background:#e8590c}
.th{position:absolute;left:0;right:0;border-top:2px dashed #1971c2}
b.b0{color:#1971c2}b.b1{color:#e8590c}b.bx{color:#c92a2a}
</style></head><body>
<h2>1. A gate reads a voltage, not a number</h2>
<p>Supply = 1.0 V. Drag the input voltage. Each stage is an inverter (NOT) whose output is a voltage too. Below 0.35 V reads as 0, above 0.65 V as 1, in between is undefined. Try 0.78 V: the input is sloppy, yet by stage 2 it's a clean level again. That restoring is why digital survives noise.</p>
<div class=\"box\">
<label>Input voltage: <b id=\"vl\"></b></label><input id=\"vin\" type=\"range\" min=\"0\" max=\"1\" step=\"0.01\" value=\"0.78\">
<canvas id=\"c1\" width=\"700\" height=\"250\"></canvas>
<div class=\"st\" id=\"stg\"></div>
</div>

<h2>2. Why a gate takes time</h2>
<p>Your guess is close, but the delay is not the material \"priming\". Electrons in the silicon respond almost instantly. The delay is <b>charging</b>: the next transistor's gate is a tiny capacitor (like a bucket) and the wire has capacitance too. A transistor passes only limited current, so the bucket fills gradually (an RC curve). The next transistor switches only when the bucket passes its threshold (dashed line, 0.5 V). Each stage waits for the one before it.</p>
<div class=\"box\">
<canvas id=\"c2\" width=\"700\" height=\"260\"></canvas>
<label>Load per stage (RC time constant): <b id=\"tl\"></b> ps</label><input id=\"tau\" type=\"range\" min=\"5\" max=\"60\" value=\"20\">
<label>Clock half-period (time before input flips again): <b id=\"pl\"></b> ps</label><input id=\"per\" type=\"range\" min=\"20\" max=\"300\" value=\"150\">
<div class=\"st\" id=\"bk\"></div>
<p id=\"msg\" style=\"margin-top:8px\"></p>
</div>
<script>
// ---------- part 1
const sig=x=>1/(1+Math.exp((x-0.5)*18));
const rd=v=>v<0.35?0:v>0.65?1:'?';
function p1(){
 const v0=+vin.value;vl.textContent=v0.toFixed(2)+' V';
 const vs=[v0];for(let i=0;i<4;i++)vs.push(sig(vs[i]));
 const c=c1.getContext('2d'),W=700,H=250;c.clearRect(0,0,W,H);
 // transfer curve
 const x0=30,y0=10,w=300,h=210;c.strokeStyle='#999';c.strokeRect(x0,y0,w,h);
 c.fillStyle='rgba(25,113,194,.12)';c.fillRect(x0,y0,0.35*w,h);c.fillStyle='rgba(232,89,12,.12)';c.fillRect(x0+0.65*w,y0,0.35*w,h);
 c.fillStyle='rgba(201,42,42,.08)';c.fillRect(x0+0.35*w,y0,0.3*w,h);
 c.strokeStyle='#222';c.lineWidth=2;c.beginPath();for(let i=0;i<=100;i++){const x=i/100,y=sig(x);i?c.lineTo(x0+x*w,y0+h-y*h):c.moveTo(x0+x*w,y0+h-y*h)}c.stroke();
 c.fillStyle='#e8590c';c.beginPath();c.arc(x0+v0*w,y0+h-vs[1]*h,6,0,7);c.fill();
 c.fillStyle='#333';c.font='12px system-ui';c.fillText('Inverter: output V vs input V',x0+60,y0+14);c.fillText('input V →',x0+w/2-25,y0+h+16);
 c.fillText('0',x0+40,y0+h-6);c.fillText('?',x0+w/2-3,y0+h-6);c.fillText('1',x0+w-40,y0+h-6);
 // voltage bars
 const bx=380;c.fillText('Voltage along the chain',bx,24);
 vs.forEach((v,i)=>{const y=40+i*40,bw=300*v;c.fillStyle='#e9ecef';c.fillRect(bx,y,300,22);c.fillStyle=rd(v)===1?'#e8590c':rd(v)===0?'#1971c2':'#c92a2a';c.fillRect(bx,y,bw,22);
  c.fillStyle='#222';c.fillText((i?'after NOT '+i:'input')+': '+v.toFixed(2)+' V → '+(rd(v)==='?'?'undefined':rd(v)),bx+4,y+15);});
 stg.innerHTML=vs.map((v,i)=>{const r=rd(v);return `<div>${i?'stage '+i:'input'}<br><b class=\"${r===0?'b0':r===1?'b1':'bx'}\">${r==='?'?'undefined':'logic '+r}</b></div>`}).join('');
}
vin.oninput=p1;p1();
// ---------- part 2
const N=4,TH=0.5,WIN=420;let t=0,v=[0,1,0,1],inp=0,nextFlip=40;const hist=[];let cross=[null,null,null,null,null],dly=[null,null,null,null],last=null;
const col=['#2b8a3e','#1971c2','#e8590c','#9c36b5','#c92a2a'];
tau.oninput=()=>tl.textContent=tau.value;per.oninput=()=>pl.textContent=per.value;tau.oninput();per.oninput();
bk.innerHTML=[0,1,2,3].map(i=>`<div>gate cap of<br>NOT ${i+1}<div class=\"bar\"><div class=\"fill\" id=\"f${i}\"></div><div class=\"th\" style=\"bottom:50%\"></div></div><span id=\"s${i}\"></span><br><span id=\"d${i}\"></span></div>`).join('');
function step(dt){
 t+=dt;if(t>=nextFlip){inp^=1;nextFlip=t+ +per.value;cross[0]=t;}
 let prev=inp;
 const tt=+tau.value;
 for(let i=0;i<N;i++){const tg=(i?v[i-1]:inp)<TH?1:0;const o=v[i];v[i]+=(tg-v[i])*(1-Math.exp(-dt/tt));
  if((o-TH)*(v[i]-TH)<0&&i<N){cross[i+1]=t;const ref=cross[i];if(ref!=null)dly[i]=t-ref;}}
 hist.push([t,inp,...v]);while(hist[0][0]<t-WIN)hist.shift();
}
let lt=performance.now();
function loop(n){const real=Math.min(0.05,(n-lt)/1000);lt=n;const sim=real*60; // 60 ps per second
 for(let k=0;k<sim/0.5;k++)step(0.5);draw();requestAnimationFrame(loop)}
function draw(){
 const c=c2.getContext('2d'),W=700,H=260,L=40,T=10,w=650,h=210;c.clearRect(0,0,W,H);
 c.strokeStyle='#bbb';c.strokeRect(L,T,w,h);c.setLineDash([5,4]);c.strokeStyle='#1971c2';c.beginPath();c.moveTo(L,T+h/2);c.lineTo(L+w,T+h/2);c.stroke();c.setLineDash([]);
 c.fillStyle='#1971c2';c.font='11px system-ui';c.fillText('threshold',L+4,T+h/2-3);c.fillStyle='#555';c.fillText('1 V',8,T+12);c.fillText('0 V',8,T+h);c.fillText('time → (ps)',L+w-70,T+h+16);
 for(let s=0;s<5;s++){c.strokeStyle=col[s];c.lineWidth=2;c.beginPath();hist.forEach((p,i)=>{const x=L+(p[0]-(t-WIN))/WIN*w,y=T+h-(p[1+s])*h*0.92-h*0.04;i?c.lineTo(x,y):c.moveTo(x,y)});c.stroke();
  c.fillStyle=col[s];c.fillText(s?'NOT '+s+' out':'input',L+6+s*90,T+h+16);}
 const tot=dly.reduce((a,b)=>a+(b||0),0);
 for(let i=0;i<N;i++){document.getElementById('f'+i).style.height=(v[i]*100)+'%';document.getElementById('s'+i).innerHTML=(i?v[i-1]:inp)>0&&0;
  const on=(i?v[i-1]:inp)>TH;// this gate's input high => its pull-down transistor is on
  document.getElementById('s'+i).textContent='Pull-down: '+(on?'ON':'off');
  document.getElementById('d'+i).textContent=dly[i]!=null?'delay ≈ '+dly[i].toFixed(0)+' ps':'';}
 const need=tot, half=+per.value;
 msg.innerHTML=`Total chain delay ≈ <b>${tot.toFixed(0)} ps</b>. `+(tot>half?'<b class=\"bx\">The input flips before the last stage has finished, so the output is wrong or glitchy. In a chip, this is why clock speed is limited by delay.</b>':'The output settles before the next input change, so this speed is safe. Shrink the half-period or raise the load to break it.');
}
requestAnimationFrame(loop);
</script></body></html>"
 :AT "2026-11-13T19:08:08" :VERSION 1)
(:PINNED T :ID "baby-computer-a-clocked-counter" :MAP "computers" :NODE "clock" :TYPE "html" :TITLE
 "Baby computer: a clocked counter" :LANGUAGE NIL :CONTENT
 "<!DOCTYPE html><html><head><meta charset=\"utf-8\"><style>
body{font-family:system-ui,sans-serif;margin:0;padding:14px;background:#fafafa;color:#222}
h2{margin:0 0 4px;font-size:18px}p{margin:4px 0 10px;font-size:13px;color:#555}
.row{display:flex;flex-wrap:wrap;gap:12px;align-items:center;margin:8px 0;font-size:13px}
button{padding:6px 12px;border:1px solid #888;border-radius:6px;background:#fff;cursor:pointer;font-size:13px}
button:hover{background:#eef}
svg,canvas{background:#fff;border:1px solid #ddd;border-radius:8px;width:100%;display:block}
#status{font-size:14px;font-weight:600;padding:6px 10px;border-radius:6px;margin-top:8px}
.ok{background:#e3f5e6;color:#1d6b2c}.bad{background:#fde5e0;color:#a3260f}
label{display:flex;align-items:center;gap:6px}
</style></head><body>
<h2>A 3-bit counter: the smallest computer that does something</h2>
<p>Three flip-flops hold a number. Gates compute \"number + 1\". On each clock rising edge, the flip-flops copy the gates' answer. Between edges, the gates are free to wobble.</p>
<div class=\"row\">
<button id=\"run\">Pause</button><button id=\"step\">Step 1 tick</button><button id=\"reset\">Reset</button>
<label>Clock period <input type=\"range\" id=\"per\" min=\"2\" max=\"16\" step=\"0.5\" value=\"10\"><b id=\"perv\"></b></label>
<label>Gate delay <input type=\"range\" id=\"gd\" min=\"0.5\" max=\"4\" step=\"0.25\" value=\"1.5\"><b id=\"gdv\"></b></label>
<label>Slow-mo <input type=\"range\" id=\"spd\" min=\"1\" max=\"10\" value=\"3\"></label>
</div>
<svg id=\"c\" viewBox=\"0 0 660 270\"></svg>
<canvas id=\"w\" width=\"660\" height=\"190\" style=\"margin-top:8px\"></canvas>
<div id=\"status\" class=\"ok\"></div>
<p>Try it: drag the clock period down until it is shorter than the slowest path (the carry into bit 2: AND then XOR = 2 gate delays, plus setup). The flip-flops then look too early, copy a half-finished answer, and the count goes wrong. That is why a CPU has a maximum clock speed.</p>
<script>
const NS=\"http://www.w3.org/2000/svg\",svg=document.getElementById('c');
function el(t,a,txt){const e=document.createElementNS(NS,t);for(const k in a)e.setAttribute(k,a[k]);if(txt)e.textContent=txt;svg.appendChild(e);return e}
const X=[470,290,110]; // bit0 right? put bit2 left, bit0 right
const bitX=i=>X[i], gates=[\"NOT Q0\",\"Q1 XOR Q0\",\"Q2 XOR (Q1 AND Q0)\"];
el('text',{x:10,y:20,'font-size':13,fill:'#555'},'combinational logic (gates): computes Q + 1');
el('text',{x:10,y:150,'font-size':13,fill:'#555'},'register (flip-flops): remembers Q');
const gb=[],dw=[],ff=[],qt=[],dt=[];
for(let i=0;i<3;i++){const x=bitX(i);
 gb[i]=el('rect',{x:x-70,y:35,width:140,height:44,rx:8,fill:'#eef3ff',stroke:'#46f'});
 el('text',{x:x,y:62,'text-anchor':'middle','font-size':12},gates[i]);
 dw[i]=el('line',{x1:x,y1:79,x2:x,y2:150,'stroke-width':4,stroke:'#3a3'});
 dt[i]=el('text',{x:x+8,y:118,'font-size':13,'font-weight':600},'D'+i);
 ff[i]=el('rect',{x:x-45,y:150,width:90,height:60,rx:8,fill:'#fff',stroke:'#333','stroke-width':2});
 el('text',{x:x-38,y:172,'font-size':12},'D');el('text',{x:x+28,y:172,'font-size':12},'Q'+i);
 el('path',{d:`M${x-45},190 l12,6 l-12,6`,fill:'none',stroke:'#333'});
 qt[i]=el('text',{x:x,y:198,'text-anchor':'middle','font-size':26,'font-weight':700},'0');
 el('line',{x1:x,y1:210,x2:x,y2:236,stroke:'#999'});}
el('text',{x:490,y:20,'font-size':12,fill:'#555'},'');
const clkLine=el('line',{x1:20,y1:196,x2:640,y2:196,stroke:'#ccc','stroke-width':0});
const clkBox=el('rect',{x:560,y:100,width:90,height:30,rx:6,fill:'#ddd',stroke:'#333'});
el('text',{x:605,y:120,'text-anchor':'middle','font-size':13},'CLOCK');
const clkW=el('path',{d:'M560,115 L540,115 L540,235 L10,235',fill:'none',stroke:'#888','stroke-width':2});
for(let i=0;i<3;i++)el('path',{d:`M${bitX(i)-45},196 L${bitX(i)-60},196 L${bitX(i)-60},235`,fill:'none',stroke:'#888','stroke-width':2});
const cnt=el('text',{x:330,y:262,'text-anchor':'middle','font-size':15,'font-weight':700},'');
const P=()=>+per.value,G=()=>+gd.value,delays=()=>[G(),G(),2*G()],SETUP=0.5;
const f=q=>(q+1)&7,bit=(q,i)=>(q>>i)&1;
let t=0,Q=0,Qprev=7,tc=-100,running=true,stepping=false,lastEdge=-1,msg='',bad=false,hist=[],wrong=false,expected=0;
per.oninput=gd.oninput=()=>{perv.textContent=P()+' ns';gdv.textContent=G()+' ns'};per.oninput();
run.onclick=()=>{running=!running;stepping=false;run.textContent=running?'Pause':'Run'};
step.onclick=()=>{running=true;stepping=true;run.textContent='Pause'};
reset.onclick=()=>{t=0;Q=0;Qprev=7;tc=-100;lastEdge=-1;hist=[];expected=0;bad=false;msg=''};
function Dshown(i){return (t-tc>=delays()[i])?bit(f(Q),i):bit(f(Qprev),i)}
function tick(dt){ if(!running)return;
 t+=dt;const e=Math.floor(t/P());
 if(e>lastEdge){lastEdge=e; if(e>0){ // rising edge at e*P
   const d=[0,1,2].map(i=>(e*P()-tc>=delays()[i]+SETUP)?bit(f(Q),i):bit(f(Qprev),i));
   const nq=d[0]|d[1]<<1|d[2]<<2, want=f(Q); Qprev=Q;Q=nq;tc=e*P();
   expected=(expected+1)&7; bad=(nq!==expected); msg=bad?`Edge ${e}: gates had not settled. Flip-flops captured ${nq}, should be ${expected}.`:`Edge ${e}: captured ${nq}. Correct.`;
   if(bad)expected=nq;
   if(stepping){running=false;stepping=false;run.textContent='Run'}}}
}
function clk(){return (t%P())<P()/2?1:0}
function draw(){
 const s=[0,1,2].map(i=>(t-tc>=delays()[i]+SETUP));
 for(let i=0;i<3;i++){const ok=s[i];dw[i].setAttribute('stroke',ok?'#3a3':'#e90');dw[i].setAttribute('stroke-dasharray',ok?'':'6 4');
  gb[i].setAttribute('fill',ok?'#eef3ff':'#fff1d6');dt[i].textContent='D'+i+'='+Dshown(i)+(ok?'':' ?');
  qt[i].textContent=bit(Q,i);qt[i].setAttribute('fill',bit(Q,i)?'#c20':'#333');
  ff[i].setAttribute('fill',bit(Q,i)?'#ffe9e4':'#fff')}
 const c=clk();clkBox.setAttribute('fill',c?'#ffd84a':'#ddd');clkW.setAttribute('stroke',c?'#e90':'#888');
 cnt.textContent='Stored number = '+Q+'   (binary '+[2,1,0].map(i=>bit(Q,i)).join('')+')';
 const S=document.getElementById('status');S.className=bad?'bad':'ok';S.textContent=msg||('Safe period needs to be above about '+(2*G()+SETUP)+' ns. Press Run or Step.');
 hist.push({t,c,q:[0,1,2].map(i=>bit(Q,i)),d:[0,1,2].map(Dshown)});
 while(hist.length&&hist[0].t<t-40)hist.shift();
 const cv=document.getElementById('w'),x=cv.getContext('2d');x.clearRect(0,0,660,190);x.font='12px sans-serif';
 const names=['clock','Q0','Q1','Q2'],W=560,ox=60;
 x.fillStyle='#555';x.fillText('last 40 ns',ox,12);
 for(let r=0;r<4;r++){const y0=40+r*38;x.fillStyle='#222';x.fillText(names[r],8,y0-6);
  x.strokeStyle=r?'#c20':'#e90';x.lineWidth=2;x.beginPath();
  hist.forEach((h,k)=>{const px=ox+W-(t-h.t)/40*W,v=r?h.q[r-1]:h.c,py=y0-(v?20:0);if(!k)x.moveTo(px,py);else{x.lineTo(px,k&&((r?hist[k-1].q[r-1]:hist[k-1].c)!==v)?y0-((r?hist[k-1].q[r-1]:hist[k-1].c)?20:0):py);x.lineTo(px,py)}});x.stroke();}
 // edge markers
 x.strokeStyle='#bbb';x.setLineDash([3,4]);x.lineWidth=1;
 for(let e=Math.floor((t-40)/P());e*P()<=t;e++){if(e<0)continue;const px=ox+W-(t-e*P())/40*W;if(px<ox)continue;x.beginPath();x.moveTo(px,22);x.lineTo(px,175);x.stroke()}
 x.setLineDash([]);x.fillStyle='#777';x.fillText('dashed = rising edges: the only moments Q is allowed to change',ox,186);
}
let last=performance.now();
(function loop(n){const dt=(n-last)/1000;last=n;tick(dt*(+spd.value)*1.0);draw();requestAnimationFrame(loop)})(last);
</script></body></html>"
 :AT "2026-11-13T19:20:33" :VERSION 1)
(:PINNED T :ID "clock-circuit-crystal-to-flip-flops" :MAP "computers" :NODE "clock" :TYPE "svg"
 :TITLE "Clock circuit: crystal to flip-flops" :LANGUAGE NIL :CONTENT
 "<svg xmlns=\"http://www.w3.org/2000/svg\" viewBox=\"0 0 900 825\" font-family=\"system-ui,sans-serif\">
<defs><marker id=\"a\" viewBox=\"0 0 10 10\" refX=\"9\" refY=\"5\" markerWidth=\"7\" markerHeight=\"7\" orient=\"auto\"><path d=\"M0,0 L10,5 L0,10z\" fill=\"#333\"/></marker></defs>
<rect width=\"900\" height=\"825\" fill=\"#fff\"/>
<text x=\"450\" y=\"26\" text-anchor=\"middle\" font-size=\"18\" font-weight=\"700\">Where the clock comes from: four stages</text>

<!-- ===== Stages 1-2 ===== -->
<text x=\"20\" y=\"56\" font-size=\"14\" font-weight=\"700\" fill=\"#1a4fd0\">1–2. Pierce oscillator (crystal + inverter), then a squaring gate</text>
<g stroke=\"#333\" stroke-width=\"2\" fill=\"none\">
 <!-- input/output of inverter -->
 <line x1=\"220\" y1=\"190\" x2=\"300\" y2=\"190\"/>
 <line x1=\"384\" y1=\"190\" x2=\"560\" y2=\"190\"/>
 <!-- Rf feedback -->
 <polyline points=\"220,190 220,110 290,110\"/>
 <polyline points=\"370,110 450,110 450,190\"/>
 <!-- crystal branch -->
 <polyline points=\"220,190 220,290 310,290\"/>
 <polyline points=\"370,290 450,290 450,190\"/>
 <!-- C1 -->
 <polyline points=\"220,240 170,240 170,252\"/>
 <line x1=\"170\" y1=\"262\" x2=\"170\" y2=\"300\"/>
 <!-- C2 -->
 <polyline points=\"450,240 500,240 500,252\"/>
 <line x1=\"500\" y1=\"262\" x2=\"500\" y2=\"300\"/>
 <!-- gate out to PLL -->
 <polyline points=\"610,190 820,190 820,235\" marker-end=\"url(#a)\"/>
</g>
<g stroke=\"#333\" stroke-width=\"3\">
 <line x1=\"155\" y1=\"252\" x2=\"185\" y2=\"252\"/><line x1=\"155\" y1=\"262\" x2=\"185\" y2=\"262\"/>
 <line x1=\"485\" y1=\"252\" x2=\"515\" y2=\"252\"/><line x1=\"485\" y1=\"262\" x2=\"515\" y2=\"262\"/>
 <line x1=\"310\" y1=\"275\" x2=\"310\" y2=\"305\"/><line x1=\"370\" y1=\"275\" x2=\"370\" y2=\"305\"/>
</g>
<!-- grounds -->
<g stroke=\"#333\" stroke-width=\"2\">
 <line x1=\"160\" y1=\"300\" x2=\"180\" y2=\"300\"/><line x1=\"164\" y1=\"305\" x2=\"176\" y2=\"305\"/><line x1=\"168\" y1=\"310\" x2=\"172\" y2=\"310\"/>
 <line x1=\"490\" y1=\"300\" x2=\"510\" y2=\"300\"/><line x1=\"494\" y1=\"305\" x2=\"506\" y2=\"305\"/><line x1=\"498\" y1=\"310\" x2=\"502\" y2=\"310\"/>
</g>
<!-- junction dots -->
<g fill=\"#333\"><circle cx=\"220\" cy=\"190\" r=\"4\"/><circle cx=\"450\" cy=\"190\" r=\"4\"/><circle cx=\"220\" cy=\"240\" r=\"4\"/><circle cx=\"450\" cy=\"240\" r=\"4\"/></g>
<!-- Rf -->
<rect x=\"290\" y=\"100\" width=\"80\" height=\"20\" fill=\"#fff\" stroke=\"#333\" stroke-width=\"2\"/>
<text x=\"330\" y=\"90\" text-anchor=\"middle\" font-size=\"12\">Rf (bias, about 1 MΩ)</text>
<!-- inverter -->
<polygon points=\"300,150 300,230 370,190\" fill=\"#eef3ff\" stroke=\"#1a4fd0\" stroke-width=\"2.5\"/>
<circle cx=\"377\" cy=\"190\" r=\"7\" fill=\"#fff\" stroke=\"#1a4fd0\" stroke-width=\"2.5\"/>
<text x=\"318\" y=\"195\" font-size=\"12\" fill=\"#1a4fd0\">INV</text>
<!-- crystal body -->
<rect x=\"322\" y=\"277\" width=\"36\" height=\"26\" fill=\"#ffe9a8\" stroke=\"#b07a00\" stroke-width=\"2\"/>
<text x=\"340\" y=\"328\" text-anchor=\"middle\" font-size=\"12\" fill=\"#b07a00\" font-weight=\"700\">quartz crystal</text>
<text x=\"340\" y=\"344\" text-anchor=\"middle\" font-size=\"12\" fill=\"#b07a00\">sets the frequency</text>
<text x=\"145\" y=\"262\" text-anchor=\"end\" font-size=\"12\">C1</text>
<text x=\"525\" y=\"262\" font-size=\"12\">C2</text>
<!-- squaring gate -->
<polygon points=\"560,160 560,220 610,190\" fill=\"#eef3ff\" stroke=\"#1a4fd0\" stroke-width=\"2.5\"/>
<text x=\"585\" y=\"244\" text-anchor=\"middle\" font-size=\"12\" fill=\"#1a4fd0\">squaring gate</text>
<!-- waveforms -->
<path d=\"M470,170 q10,-20 20,0 t20,0 t20,0 t20,0\" fill=\"none\" stroke=\"#c20\" stroke-width=\"2\"/>
<text x=\"510\" y=\"140\" text-anchor=\"middle\" font-size=\"12\" fill=\"#c20\">sine-like</text>
<path d=\"M650,170 h10 v-20 h20 v20 h20 v-20 h20 v20 h10\" fill=\"none\" stroke=\"#2a8a3a\" stroke-width=\"2\"/>
<text x=\"710\" y=\"140\" text-anchor=\"middle\" font-size=\"12\" fill=\"#2a8a3a\">square: 0s and 1s (e.g. 25 MHz)</text>
<text x=\"820\" y=\"256\" text-anchor=\"middle\" font-size=\"12\" fill=\"#555\">to PLL</text>
<!-- notes -->
<g font-size=\"12\" fill=\"#555\">
 <text x=\"580\" y=\"285\">Loop: the inverter amplifies noise;</text>
 <text x=\"580\" y=\"301\">the crystal passes back only energy</text>
 <text x=\"580\" y=\"317\">at its resonance, so the loop settles</text>
 <text x=\"580\" y=\"333\">at that one frequency.</text>
</g>

<line x1=\"20\" y1=\"368\" x2=\"880\" y2=\"368\" stroke=\"#ddd\"/>

<!-- ===== Stage 3 ===== -->
<g transform=\"translate(0,10)\">
<text x=\"20\" y=\"381\" font-size=\"14\" font-weight=\"700\" fill=\"#1a4fd0\">3. PLL: multiply the crystal up</text>
<g stroke=\"#1a4fd0\" stroke-width=\"2\" fill=\"#eef3ff\">
 <rect x=\"30\" y=\"430\" width=\"100\" height=\"60\" rx=\"8\"/>
 <rect x=\"170\" y=\"430\" width=\"110\" height=\"60\" rx=\"8\"/>
 <rect x=\"360\" y=\"430\" width=\"120\" height=\"60\" rx=\"8\"/>
 <rect x=\"560\" y=\"430\" width=\"110\" height=\"60\" rx=\"8\"/>
 <rect x=\"560\" y=\"520\" width=\"110\" height=\"50\" rx=\"8\"/>
</g>
<g font-size=\"13\" text-anchor=\"middle\">
 <text x=\"80\" y=\"456\">Crystal</text><text x=\"80\" y=\"474\">25 MHz</text>
 <text x=\"225\" y=\"456\">Phase</text><text x=\"225\" y=\"474\">detector</text>
 <text x=\"420\" y=\"456\">Loop filter</text><text x=\"420\" y=\"474\">(charge pump)</text>
 <text x=\"615\" y=\"456\">VCO</text><text x=\"615\" y=\"474\">fast oscillator</text>
 <text x=\"615\" y=\"542\">÷ N</text><text x=\"615\" y=\"560\">(N = 30)</text>
</g>
<g stroke=\"#333\" stroke-width=\"2\" fill=\"none\">
 <line x1=\"130\" y1=\"460\" x2=\"170\" y2=\"460\" marker-end=\"url(#a)\"/>
 <line x1=\"280\" y1=\"460\" x2=\"360\" y2=\"460\" marker-end=\"url(#a)\"/>
 <line x1=\"480\" y1=\"460\" x2=\"560\" y2=\"460\" marker-end=\"url(#a)\"/>
 <line x1=\"670\" y1=\"460\" x2=\"740\" y2=\"460\"/>
 <polyline points=\"710,460 710,545 670,545\" marker-end=\"url(#a)\"/>
 <polyline points=\"560,545 225,545 225,490\" marker-end=\"url(#a)\"/>
</g>
<circle cx=\"710\" cy=\"460\" r=\"4\" fill=\"#333\"/>
<g font-size=\"12\" fill=\"#555\" text-anchor=\"middle\">
 <text x=\"320\" y=\"452\">error</text>
 <text x=\"520\" y=\"438\">control</text><text x=\"520\" y=\"452\">voltage</text>
 <text x=\"390\" y=\"537\">VCO ÷ N = 25 MHz? If not, steer the VCO</text>
</g>
<text x=\"750\" y=\"455\" font-size=\"14\" font-weight=\"700\" fill=\"#2a8a3a\">750 MHz</text>
<text x=\"750\" y=\"474\" font-size=\"12\" fill=\"#555\">then × or ÷ to</text>
<text x=\"750\" y=\"490\" font-size=\"12\" fill=\"#555\">the CPU speed</text>
</g>

<line x1=\"20\" y1=\"595\" x2=\"880\" y2=\"595\" stroke=\"#ddd\"/>

<!-- ===== Stage 4 ===== -->
<g transform=\"translate(0,12)\">
<text x=\"20\" y=\"606\" font-size=\"14\" font-weight=\"700\" fill=\"#1a4fd0\">4. Clock tree</text>
<g stroke=\"#333\" stroke-width=\"2\" fill=\"none\">
 <line x1=\"30\" y1=\"710\" x2=\"90\" y2=\"710\"/>
 <line x1=\"120\" y1=\"710\" x2=\"170\" y2=\"710\"/>
 <line x1=\"170\" y1=\"665\" x2=\"170\" y2=\"755\"/>
 <line x1=\"170\" y1=\"665\" x2=\"210\" y2=\"665\"/>
 <line x1=\"170\" y1=\"755\" x2=\"210\" y2=\"755\"/>
 <line x1=\"240\" y1=\"665\" x2=\"290\" y2=\"665\"/>
 <line x1=\"240\" y1=\"755\" x2=\"290\" y2=\"755\"/>
 <line x1=\"290\" y1=\"640\" x2=\"290\" y2=\"690\"/>
 <line x1=\"290\" y1=\"730\" x2=\"290\" y2=\"780\"/>
 <line x1=\"290\" y1=\"640\" x2=\"340\" y2=\"640\" marker-end=\"url(#a)\"/>
 <line x1=\"290\" y1=\"690\" x2=\"340\" y2=\"690\" marker-end=\"url(#a)\"/>
 <line x1=\"290\" y1=\"730\" x2=\"340\" y2=\"730\" marker-end=\"url(#a)\"/>
 <line x1=\"290\" y1=\"780\" x2=\"340\" y2=\"780\" marker-end=\"url(#a)\"/>
</g>
<g fill=\"#eef3ff\" stroke=\"#1a4fd0\" stroke-width=\"2\">
 <polygon points=\"90,695 90,725 120,710\"/>
 <polygon points=\"210,650 210,680 240,665\"/>
 <polygon points=\"210,740 210,770 240,755\"/>
</g>
<g fill=\"#fff\" stroke=\"#333\" stroke-width=\"2\">
 <rect x=\"340\" y=\"628\" width=\"50\" height=\"24\"/><rect x=\"340\" y=\"678\" width=\"50\" height=\"24\"/>
 <rect x=\"340\" y=\"718\" width=\"50\" height=\"24\"/><rect x=\"340\" y=\"768\" width=\"50\" height=\"24\"/>
</g>
<g font-size=\"12\" text-anchor=\"middle\"><text x=\"365\" y=\"644\">FF</text><text x=\"365\" y=\"694\">FF</text><text x=\"365\" y=\"734\">FF</text><text x=\"365\" y=\"784\">FF</text></g>
<text x=\"30\" y=\"696\" font-size=\"12\" fill=\"#555\">PLL clock</text>
<g font-size=\"12\" fill=\"#555\">
 <text x=\"420\" y=\"690\">Buffers (triangles) split the clock again and again.</text>
 <text x=\"420\" y=\"710\">Every branch has the same length, so millions of</text>
 <text x=\"420\" y=\"730\">flip-flop clock pins see the rising edge at nearly</text>
 <text x=\"420\" y=\"750\">the same instant: small skew.</text>
</g>
</g>
</svg>"
 :AT "2026-11-13T19:32:31" :VERSION 2)
(:PINNED T :ID "ram-grid-and-one-cell" :MAP "computers" :NODE "ram" :TYPE "svg" :TITLE
 "RAM: grid and one cell" :LANGUAGE NIL :CONTENT
 "<svg xmlns=\"http://www.w3.org/2000/svg\" viewBox=\"0 0 1000 1010\" font-family=\"system-ui, sans-serif\">
<rect width=\"1000\" height=\"1010\" fill=\"#fafafa\"/>
<text x=\"20\" y=\"30\" font-size=\"18\" font-weight=\"700\" fill=\"#222\">A. The grid: address → decoder → one word line → one row of cells</text>
<text x=\"20\" y=\"50\" font-size=\"13\" fill=\"#555\">Tiny 4-word × 4-bit RAM. Address 10 (=2) is applied, so row 2 is selected.</text>

<!-- address pins -->
<text x=\"22\" y=\"150\" font-size=\"13\" fill=\"#222\">A1 = 1</text>
<text x=\"22\" y=\"230\" font-size=\"13\" fill=\"#222\">A0 = 0</text>
<line x1=\"70\" y1=\"145\" x2=\"110\" y2=\"145\" stroke=\"#d4a017\" stroke-width=\"4\"/>
<line x1=\"70\" y1=\"225\" x2=\"110\" y2=\"225\" stroke=\"#d4a017\" stroke-width=\"4\"/>
<!-- decoder -->
<rect x=\"110\" y=\"95\" width=\"120\" height=\"270\" rx=\"6\" fill=\"#dfe6ee\" stroke=\"#556\" stroke-width=\"2\"/>
<text x=\"170\" y=\"120\" font-size=\"14\" font-weight=\"700\" text-anchor=\"middle\" fill=\"#223\">DECODER</text>
<text x=\"170\" y=\"138\" font-size=\"12\" text-anchor=\"middle\" fill=\"#445\">AND gates only</text>
<text x=\"170\" y=\"190\" font-size=\"12\" text-anchor=\"middle\" fill=\"#445\">row0 = ¬A1·¬A0</text>
<text x=\"170\" y=\"236\" font-size=\"12\" text-anchor=\"middle\" fill=\"#445\">row1 = ¬A1·A0</text>
<text x=\"170\" y=\"282\" font-size=\"12\" text-anchor=\"middle\" fill=\"#a33\" font-weight=\"700\">row2 = A1·¬A0 ✓</text>
<text x=\"170\" y=\"328\" font-size=\"12\" text-anchor=\"middle\" fill=\"#445\">row3 = A1·A0</text>

<!-- word lines -->
<g stroke-width=\"5\">
<line x1=\"230\" y1=\"180\" x2=\"600\" y2=\"180\" stroke=\"#8a7a50\" opacity=\".55\"/>
<line x1=\"230\" y1=\"226\" x2=\"600\" y2=\"226\" stroke=\"#8a7a50\" opacity=\".55\"/>
<line x1=\"230\" y1=\"272\" x2=\"600\" y2=\"272\" stroke=\"#ffc400\"/>
<line x1=\"230\" y1=\"318\" x2=\"600\" y2=\"318\" stroke=\"#8a7a50\" opacity=\".55\"/>
</g>
<text x=\"610\" y=\"277\" font-size=\"12\" fill=\"#a33\" font-weight=\"700\">word line 2 = HIGH</text>
<text x=\"610\" y=\"185\" font-size=\"12\" fill=\"#666\">word line 0 (low)</text>
<!-- bit lines -->
<g stroke=\"#b87333\" stroke-width=\"5\">
<line x1=\"285\" y1=\"150\" x2=\"285\" y2=\"400\"/><line x1=\"375\" y1=\"150\" x2=\"375\" y2=\"400\"/>
<line x1=\"465\" y1=\"150\" x2=\"465\" y2=\"400\"/><line x1=\"555\" y1=\"150\" x2=\"555\" y2=\"400\"/>
</g>
<text x=\"420\" y=\"145\" font-size=\"12\" text-anchor=\"middle\" fill=\"#8a4f1c\">bit lines (vertical, a different metal layer)</text>
<!-- cells -->
<g font-size=\"14\" font-weight=\"700\" text-anchor=\"middle\">
<!-- row 0 -->
<rect x=\"250\" y=\"164\" width=\"70\" height=\"32\" rx=\"4\" fill=\"#3f8f5a\"/><text x=\"285\" y=\"186\" fill=\"#fff\">0</text>
<rect x=\"340\" y=\"164\" width=\"70\" height=\"32\" rx=\"4\" fill=\"#3f8f5a\"/><text x=\"375\" y=\"186\" fill=\"#fff\">1</text>
<rect x=\"430\" y=\"164\" width=\"70\" height=\"32\" rx=\"4\" fill=\"#3f8f5a\"/><text x=\"465\" y=\"186\" fill=\"#fff\">1</text>
<rect x=\"520\" y=\"164\" width=\"70\" height=\"32\" rx=\"4\" fill=\"#3f8f5a\"/><text x=\"555\" y=\"186\" fill=\"#fff\">0</text>
<!-- row 1 -->
<rect x=\"250\" y=\"210\" width=\"70\" height=\"32\" rx=\"4\" fill=\"#3f8f5a\"/><text x=\"285\" y=\"232\" fill=\"#fff\">1</text>
<rect x=\"340\" y=\"210\" width=\"70\" height=\"32\" rx=\"4\" fill=\"#3f8f5a\"/><text x=\"375\" y=\"232\" fill=\"#fff\">0</text>
<rect x=\"430\" y=\"210\" width=\"70\" height=\"32\" rx=\"4\" fill=\"#3f8f5a\"/><text x=\"465\" y=\"232\" fill=\"#fff\">0</text>
<rect x=\"520\" y=\"210\" width=\"70\" height=\"32\" rx=\"4\" fill=\"#3f8f5a\"/><text x=\"555\" y=\"232\" fill=\"#fff\">1</text>
<!-- row 2 selected -->
<rect x=\"250\" y=\"256\" width=\"70\" height=\"32\" rx=\"4\" fill=\"#2e7d4a\" stroke=\"#ffc400\" stroke-width=\"4\"/><text x=\"285\" y=\"278\" fill=\"#fff\">1</text>
<rect x=\"340\" y=\"256\" width=\"70\" height=\"32\" rx=\"4\" fill=\"#2e7d4a\" stroke=\"#ffc400\" stroke-width=\"4\"/><text x=\"375\" y=\"278\" fill=\"#fff\">0</text>
<rect x=\"430\" y=\"256\" width=\"70\" height=\"32\" rx=\"4\" fill=\"#2e7d4a\" stroke=\"#ffc400\" stroke-width=\"4\"/><text x=\"465\" y=\"278\" fill=\"#fff\">1</text>
<rect x=\"520\" y=\"256\" width=\"70\" height=\"32\" rx=\"4\" fill=\"#2e7d4a\" stroke=\"#ffc400\" stroke-width=\"4\"/><text x=\"555\" y=\"278\" fill=\"#fff\">1</text>
<!-- row 3 -->
<rect x=\"250\" y=\"302\" width=\"70\" height=\"32\" rx=\"4\" fill=\"#3f8f5a\"/><text x=\"285\" y=\"324\" fill=\"#fff\">0</text>
<rect x=\"340\" y=\"302\" width=\"70\" height=\"32\" rx=\"4\" fill=\"#3f8f5a\"/><text x=\"375\" y=\"324\" fill=\"#fff\">0</text>
<rect x=\"430\" y=\"302\" width=\"70\" height=\"32\" rx=\"4\" fill=\"#3f8f5a\"/><text x=\"465\" y=\"324\" fill=\"#fff\">0</text>
<rect x=\"520\" y=\"302\" width=\"70\" height=\"32\" rx=\"4\" fill=\"#3f8f5a\"/><text x=\"555\" y=\"324\" fill=\"#fff\">1</text>
</g>
<!-- IO -->
<rect x=\"250\" y=\"400\" width=\"340\" height=\"40\" rx=\"6\" fill=\"#dfe6ee\" stroke=\"#556\" stroke-width=\"2\"/>
<text x=\"420\" y=\"425\" font-size=\"13\" text-anchor=\"middle\" fill=\"#223\">sense amps / write drivers → data pins: 1 0 1 1</text>
<text x=\"20\" y=\"470\" font-size=\"13\" fill=\"#555\">Only the selected row's access transistors conduct, so only that row's 4 cells talk to the bit lines. Everything else is disconnected.</text>

<text x=\"20\" y=\"515\" font-size=\"18\" font-weight=\"700\" fill=\"#222\">B. Inside one cell: a transistor, cut open (side view, not to scale)</text>
<!-- substrate -->
<rect x=\"60\" y=\"680\" width=\"560\" height=\"90\" fill=\"#8e949b\"/>
<!-- oxide insulator -->
<rect x=\"60\" y=\"560\" width=\"560\" height=\"120\" fill=\"#bcd6ea\" opacity=\".75\"/>
<!-- n+ regions -->
<rect x=\"130\" y=\"660\" width=\"110\" height=\"20\" fill=\"#2fa84f\"/>
<rect x=\"440\" y=\"660\" width=\"110\" height=\"20\" fill=\"#2fa84f\"/>
<!-- gate oxide -->
<rect x=\"240\" y=\"650\" width=\"200\" height=\"10\" fill=\"#f5e9f2\" stroke=\"#999\" stroke-width=\".5\"/>
<!-- poly gate -->
<rect x=\"240\" y=\"615\" width=\"200\" height=\"35\" fill=\"#c0392b\"/>
<!-- contacts -->
<rect x=\"170\" y=\"590\" width=\"30\" height=\"72\" fill=\"#4a4a52\"/>
<rect x=\"490\" y=\"590\" width=\"30\" height=\"72\" fill=\"#4a4a52\"/>
<!-- metal1 -->
<rect x=\"130\" y=\"570\" width=\"110\" height=\"22\" fill=\"#e0b020\"/>
<rect x=\"440\" y=\"570\" width=\"110\" height=\"22\" fill=\"#e0b020\"/>
<!-- via + metal2 -->
<rect x=\"490\" y=\"540\" width=\"30\" height=\"32\" fill=\"#4a4a52\"/>
<rect x=\"300\" y=\"518\" width=\"290\" height=\"24\" fill=\"#b87333\"/>
<text x=\"310\" y=\"535\" font-size=\"12\" fill=\"#fff\">metal 2 → bit line</text>
<text x=\"140\" y=\"585\" font-size=\"12\" fill=\"#222\">metal 1</text>
<text x=\"255\" y=\"637\" font-size=\"12\" fill=\"#fff\">poly gate ← word line</text>
<text x=\"150\" y=\"676\" font-size=\"12\" fill=\"#fff\">source</text>
<text x=\"470\" y=\"676\" font-size=\"12\" fill=\"#fff\">drain</text>
<text x=\"300\" y=\"730\" font-size=\"13\" fill=\"#fff\" text-anchor=\"middle\">p-type silicon substrate</text>
<!-- channel -->
<rect x=\"240\" y=\"660\" width=\"200\" height=\"6\" fill=\"#ffc400\" opacity=\".9\"/>
<text x=\"340\" y=\"690\" font-size=\"11\" text-anchor=\"middle\" fill=\"#fff\">channel forms when gate is HIGH</text>
<g font-size=\"13\" fill=\"#333\">
<text x=\"650\" y=\"560\">Word line HIGH → electric field through the</text>
<text x=\"650\" y=\"578\">gate oxide pulls electrons under the gate →</text>
<text x=\"650\" y=\"596\">a conducting channel joins source to drain →</text>
<text x=\"650\" y=\"614\">the cell's stored voltage reaches the bit line.</text>
<text x=\"650\" y=\"650\">Word line LOW → no channel → cell is cut off.</text>
<text x=\"650\" y=\"690\">Each real cell has two of these access</text>
<text x=\"650\" y=\"708\">transistors plus four more forming the</text>
<text x=\"650\" y=\"726\">cross-coupled inverters (the latch): 6T SRAM.</text>
</g>

<text x=\"20\" y=\"805\" font-size=\"18\" font-weight=\"700\" fill=\"#222\">Colour key</text>
<g font-size=\"13\" fill=\"#333\">
<rect x=\"20\" y=\"820\" width=\"22\" height=\"22\" fill=\"#8e949b\"/><text x=\"52\" y=\"836\">Grey: bulk p-type silicon wafer. Real silicon is a dull, mirror-like grey.</text>
<rect x=\"20\" y=\"848\" width=\"22\" height=\"22\" fill=\"#2fa84f\"/><text x=\"52\" y=\"864\">Green: n+ doped silicon (source/drain), the layout-diagram convention. Under a microscope it is not green.</text>
<rect x=\"20\" y=\"876\" width=\"22\" height=\"22\" fill=\"#c0392b\"/><text x=\"52\" y=\"892\">Red: polysilicon gate, the control terminal. Also a layout convention (real poly looks grey-brown).</text>
<rect x=\"20\" y=\"904\" width=\"22\" height=\"22\" fill=\"#bcd6ea\"/><text x=\"52\" y=\"920\">Pale blue: silicon dioxide, glass insulator. Transparent in reality; thin-film interference gives it rainbow tints.</text>
<rect x=\"20\" y=\"932\" width=\"22\" height=\"22\" fill=\"#e0b020\"/><text x=\"52\" y=\"948\">Gold/yellow: lowest metal wiring (metal 1). Real chips use copper or aluminium, not gold; gold is only in the bond wires.</text>
<rect x=\"20\" y=\"960\" width=\"22\" height=\"22\" fill=\"#b87333\"/><text x=\"52\" y=\"976\">Copper: upper metal layers (bit lines). Real modern wiring really is copper, which looks orange-pink.</text>
<rect x=\"20\" y=\"984\" width=\"22\" height=\"18\" fill=\"#4a4a52\"/><text x=\"52\" y=\"998\">Dark grey: tungsten plugs (contacts/vias) joining layers.   Bright yellow in panel A = signal active.</text>
</g>
</svg>"
 :AT "2026-11-13T20:11:48" :VERSION 1)
(:PINNED T :ID "ram-in-action" :MAP "computers" :NODE "ram" :TYPE "html" :TITLE "RAM in action"
 :LANGUAGE NIL :CONTENT "<!DOCTYPE html><html><head><meta charset=\"utf-8\"><style>
body{font-family:system-ui,sans-serif;background:#fafafa;margin:0;padding:16px;color:#222}
h2{margin:0 0 6px;font-size:18px}p.s{margin:0 0 12px;color:#555;font-size:13px}
.row{display:flex;gap:18px;flex-wrap:wrap;align-items:flex-start}
.box{background:#fff;border:1px solid #ccd;border-radius:8px;padding:10px}
.sw{display:inline-block;width:44px;height:44px;margin:3px;border-radius:6px;border:2px solid #556;background:#eef;font:700 18px monospace;cursor:pointer}
.sw.on{background:#ffc400}
table{border-collapse:collapse}
td{padding:2px 4px;font:13px monospace}
.dec{width:150px;text-align:right;color:#667}
.wl{width:60px}.wl div{height:6px;background:#bbb;border-radius:3px}
.wl.on div{background:#ffc400;box-shadow:0 0 6px #ffc400}
.cell{width:46px;height:30px;border-radius:5px;background:#3f8f5a;color:#fff;font:700 15px monospace;text-align:center;line-height:30px}
tr.sel .cell{background:#2e7d4a;outline:3px solid #ffc400}
tr.sel .dec{color:#a33;font-weight:700}
button{padding:10px 16px;font-size:15px;border-radius:6px;border:0;background:#2f6fdb;color:#fff;cursor:pointer;margin:4px 0}
button.w{background:#c0392b}
#log{font-size:13px;color:#333;min-height:36px;margin-top:8px}
.lbl{font-size:12px;color:#556;margin-top:6px}
</style></head><body>
<h2>RAM in action: 8 words × 4 bits</h2>
<p class=\"s\">Click the address switches (A2 A1 A0) and data switches (D3..D0). The decoder lights exactly one word line. Output always shows the selected row. WRITE overwrites it.</p>
<div class=\"row\">
<div class=\"box\">
<div class=\"lbl\">ADDRESS</div><div id=\"addr\"></div>
<div class=\"lbl\">DATA IN</div><div id=\"din\"></div>
<button class=\"w\" onclick=\"wr()\">WRITE pulse</button><br>
<div class=\"lbl\">DATA OUT (read of selected row)</div><div id=\"dout\" style=\"font:700 24px monospace\"></div>
<div class=\"lbl\"><button onclick=\"rnd()\" style=\"background:#667;font-size:12px;padding:6px 10px\">fill with random</button> <button onclick=\"clr()\" style=\"background:#667;font-size:12px;padding:6px 10px\">clear</button></div>
</div>
<div class=\"box\"><table id=\"t\"></table></div>
</div>
<div id=\"log\"></div>
<script>
let a=[0,0,0],d=[1,0,1,1],mem=[0,0,0,0,0,0,0,0].map(()=>[0,0,0,0]);
mem[0]=[0,1,1,0];mem[3]=[1,1,0,1];mem[5]=[0,0,1,1];
const A=document.getElementById('addr'),D=document.getElementById('din');
function sw(el,arr,i,name){const b=document.createElement('button');b.className='sw';b.onclick=()=>{arr[i]^=1;draw()};b.dataset.n=name;el.appendChild(b);return b}
const ab=[2,1,0].map((n,i)=>sw(A,a,i,'A'+n)),db=[3,2,1,0].map((n,i)=>sw(D,d,i,'D'+n));
const t=document.getElementById('t');
for(let r=0;r<8;r++){const bits=r.toString(2).padStart(3,'0');
 const expr=[...bits].map((b,i)=>(b=='1'?'':'¬')+'A'+(2-i)).join('·');
 let h='<tr id=\"r'+r+'\"><td>'+r+'</td><td class=\"dec\">'+expr+' →</td><td class=\"wl\"><div></div></td>';
 for(let c=0;c<4;c++)h+='<td><div class=\"cell\" id=\"c'+r+c+'\"></div></td>';
 t.insertAdjacentHTML('beforeend',h+'</tr>')}
function sel(){return a[0]*4+a[1]*2+a[2]}
function draw(msg){
 ab.forEach((b,i)=>{b.textContent=b.dataset.n+'\\n'+a[i];b.style.fontSize='13px';b.classList.toggle('on',!!a[i])});
 db.forEach((b,i)=>{b.textContent=b.dataset.n+'\\n'+d[i];b.style.fontSize='13px';b.classList.toggle('on',!!d[i])});
 const s=sel();
 for(let r=0;r<8;r++){const row=document.getElementById('r'+r);row.className=r==s?'sel':'';row.querySelector('.wl').className='wl'+(r==s?' on':'');
  for(let c=0;c<4;c++)document.getElementById('c'+r+c).textContent=mem[r][c]}
 document.getElementById('dout').textContent=mem[s].join(' ');
 document.getElementById('log').innerHTML=msg||('Address '+a.join('')+' = '+s+'. The decoder raised word line '+s+' and the other 7 stay low. Only row '+s+' is connected to the bit lines.')}
function wr(){const s=sel();mem[s]=d.slice();draw('Wrote '+d.join('')+' into row '+s+'. Only that row\\'s cells were connected to the bit lines, so no other row changed.')}
function rnd(){mem=mem.map(()=>[0,0,0,0].map(()=>Math.random()<.5?1:0));draw()}
function clr(){mem=mem.map(()=>[0,0,0,0]);draw()}
draw();
</script></body></html>"
 :AT "2026-11-13T20:12:00" :VERSION 1)
