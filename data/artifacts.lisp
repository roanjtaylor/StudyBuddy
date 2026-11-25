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
body{font-family:system-ui,sans-serif;background:#fafafa;margin:0;padding:12px;color:#222}
h2{margin:0 0 4px;font-size:18px}p.s{margin:0 0 8px;color:#555;font-size:13px}
svg{width:100%;max-width:1100px;background:#fff;border:1px solid #ccd;border-radius:8px;display:block}
svg text{font-family:ui-monospace,monospace}
.clk{cursor:pointer}
#log{font-size:14px;color:#222;margin-top:8px;padding:8px 10px;background:#fff8dc;border:1px solid #e6d58a;border-radius:6px;max-width:1080px}
.bar{margin:8px 0;display:flex;gap:8px;align-items:center;flex-wrap:wrap;font-size:13px}
button{padding:7px 12px;font-size:13px;border-radius:6px;border:0;background:#667;color:#fff;cursor:pointer}
.leg span{display:inline-block;width:12px;height:12px;border-radius:2px;vertical-align:middle;margin:0 4px 0 10px}
</style></head><body>
<h2>RAM in action: 8 words × 4 bits</h2>
<p class=\"s\">Click the yellow/grey switches. Set an address, set data, switch WE (write enable) on, then toggle the clock: the data is stored on the clock's <b>rising edge</b>, in the one row the decoder selected.</p>
<div class=\"bar\">
<button onclick=\"tick()\" style=\"background:#2f6fdb\">Toggle clock</button>
<label><input type=\"checkbox\" id=\"auto\" onchange=\"autoRun()\"> run clock automatically</label>
<button onclick=\"rnd()\">fill random</button><button onclick=\"clr()\">clear</button>
<span class=\"leg\"><span style=\"background:#f5b800\"></span>1 / high<span style=\"background:#b8bcc8\"></span>0 / low<span style=\"background:#c0392b\"></span>just written</span>
</div>
<svg id=\"svg\" viewBox=\"0 0 1100 600\"></svg>
<div id=\"log\"></div>
<script>
const HI='#f5b800',LO='#b8bcc8',RED='#c0392b';
let a=[0,0,0],d=[1,0,1,1],we=0,oe=1,clk=0,flash=-1,msg='',timer=null;
let mem=[[0,1,1,0],[0,0,0,0],[0,0,0,0],[1,1,0,1],[0,0,0,0],[0,0,1,1],[0,0,0,0],[0,0,0,0]];
let hist=[{v:0,w:0}];
const XS=[150,166,182,198,214,230],CX=[548,628,708,788];
const col=v=>v?HI:LO;
const sel=()=>a[0]*4+a[1]*2+a[2];
function tgl(arr,i){arr[i]^=1;flash=-1;msg='';draw()}
function setWE(){we^=1;flash=-1;msg='';draw()}
function setOE(){oe^=1;flash=-1;msg='';draw()}
function tick(){
 clk^=1;flash=-1;const s=sel();let w=0;
 if(clk){ if(we){mem[s]=d.slice();flash=s;w=1;
   msg='<b>Rising edge with WE=1</b>: strobe = WE AND CLK went high, the write drivers pushed '+d.join('')+' onto the bit lines, and only word line '+s+' was high, so only row '+s+' captured it.';}
  else msg='<b>Rising edge, but WE=0</b>: the strobe stays low, the drivers are off, nothing is stored. The clock alone changes nothing.';}
 else msg='Clock fell. Stores happen only on the rising edge, so nothing changes now.';
 hist.push({v:clk,w:w});if(hist.length>11)hist.shift();draw()}
function autoRun(){clearInterval(timer);if(document.getElementById('auto').checked)timer=setInterval(tick,1000)}
function rnd(){mem=mem.map(()=>[0,0,0,0].map(()=>Math.random()<.5?1:0));flash=-1;msg='';draw()}
function clr(){mem=mem.map(()=>[0,0,0,0]);flash=-1;msg='';draw()}
function T(x,y,t,sz,c,an){return `<text x=\"${x}\" y=\"${y}\" font-size=\"${sz||12}\" fill=\"${c||'#334'}\" text-anchor=\"${an||'start'}\">${t}</text>`}
function draw(){
 const s=sel(),strobe=we&&clk,names=['A2','A1','A0'];
 let o='';
 // titles
 o+=T(150,16,'ADDRESS IN',12,'#556')+T(150,448+40,'DECODER  3 → 8',13,'#2a5')+T(400,16,'',12);
 o+=T(548,16,'DATA IN (D3 D2 D1 D0)',12,'#556');
 o+=T(300,150,'WORD LINES',11,'#2a5');
 o+=T(860,16,'CONTROL PINS',12,'#556');
 // decoder vertical lines
 const lv=[];for(let i=0;i<3;i++){lv.push(a[i]);lv.push(1-a[i])}
 for(let k=0;k<6;k++)o+=`<line x1=\"${XS[k]}\" y1=\"100\" x2=\"${XS[k]}\" y2=\"452\" stroke=\"${col(lv[k])}\" stroke-width=\"3\"/>`;
 // address switches + inverters
 for(let i=0;i<3;i++){const t=XS[2*i],c=XS[2*i+1],m=(t+c)/2;
  o+=`<line x1=\"${m}\" y1=\"62\" x2=\"${m}\" y2=\"76\" stroke=\"${col(a[i])}\" stroke-width=\"3\"/>`;
  o+=`<line x1=\"${t}\" y1=\"76\" x2=\"${c}\" y2=\"76\" stroke=\"${col(a[i])}\" stroke-width=\"3\"/>`;
  o+=`<line x1=\"${t}\" y1=\"76\" x2=\"${t}\" y2=\"100\" stroke=\"${col(a[i])}\" stroke-width=\"3\"/>`;
  o+=`<line x1=\"${c}\" y1=\"76\" x2=\"${c}\" y2=\"86\" stroke=\"${col(a[i])}\" stroke-width=\"3\"/><circle cx=\"${c}\" cy=\"90\" r=\"4\" fill=\"#fff\" stroke=\"#334\" stroke-width=\"2\"/>`+`<line x1=\"${c}\" y1=\"94\" x2=\"${c}\" y2=\"100\" stroke=\"${col(1-a[i])}\" stroke-width=\"3\"/>`;
  o+=`<g class=\"clk\" onclick=\"tgl(a,${i})\"><rect x=\"${m-20}\" y=\"26\" width=\"40\" height=\"36\" rx=\"6\" fill=\"${col(a[i])}\" stroke=\"#445\" stroke-width=\"2\"/>${T(m,41,names[i],11,'#222','middle')}${T(m,56,a[i],14,'#000','middle')}</g>`;
 }
 o+=T(256,75,'← ¬ = inverter',11,'#778')+T(256,95,'each bit as true &',10,'#778')+T(256,108,'complement line',10,'#778');
 // rows
 for(let r=0;r<8;r++){const y=164+40*r,on=r==s;
  const bits=[(r>>2)&1,(r>>1)&1,r&1];
  o+=`<line x1=\"146\" y1=\"${y}\" x2=\"258\" y2=\"${y}\" stroke=\"${on?HI:'#ddd'}\" stroke-width=\"2\"/>`;
  for(let i=0;i<3;i++){const k=2*i+(bits[i]?0:1);o+=`<circle cx=\"${XS[k]}\" cy=\"${y}\" r=\"4.5\" fill=\"#334\"/>`}
  o+=`<rect x=\"258\" y=\"${y-13}\" width=\"34\" height=\"26\" rx=\"6\" fill=\"${on?HI:'#eee'}\" stroke=\"#445\" stroke-width=\"1.5\"/>${T(275,y+4,'AND',10,'#222','middle')}`;
  o+=`<line x1=\"292\" y1=\"${y}\" x2=\"810\" y2=\"${y}\" stroke=\"${on?HI:'#ddd'}\" stroke-width=\"${on?4:2}\"/>`;
  o+=T(30,y+4,'row '+r+'  '+bits.join(''),12,on?'#a33':'#889');
 }
 // bit lines
 const bl=[0,1,2,3].map(c=>we?d[c]:mem[s][c]);
 for(let c=0;c<4;c++)o+=`<line x1=\"${CX[c]}\" y1=\"112\" x2=\"${CX[c]}\" y2=\"470\" stroke=\"${col(bl[c])}\" stroke-width=\"4\"/>`;
 o+=T(812,300,'← bit lines',11,'#778')+T(812,314,'carry data',11,'#778')+T(812,328,'in or out',11,'#778');
 // cells
 for(let r=0;r<8;r++){const y=164+40*r,on=r==s;
  for(let c=0;c<4;c++){const f=flash==r;
   o+=`<rect x=\"${CX[c]-26}\" y=\"${y-14}\" width=\"52\" height=\"28\" rx=\"5\" fill=\"${f?RED:(on?'#2e7d4a':'#3f8f5a')}\" stroke=\"${on?HI:'#235'}\" stroke-width=\"${on?3:1}\"/>${T(CX[c],y+6,mem[r][c],16,'#fff','middle')}`}}
 o+=T(548,148,'cells: each is a flip-flop (one bit)',11,'#2a5').replace('x=\"548\"','x=\"520\"');
 // data in switches and write drivers
 for(let c=0;c<4;c++){const n=3-c;
  o+=`<line x1=\"${CX[c]}\" y1=\"62\" x2=\"${CX[c]}\" y2=\"84\" stroke=\"${col(d[c])}\" stroke-width=\"3\"/>`;
  o+=`<g class=\"clk\" onclick=\"tgl(d,${c})\"><rect x=\"${CX[c]-22}\" y=\"26\" width=\"44\" height=\"36\" rx=\"6\" fill=\"${col(d[c])}\" stroke=\"#445\" stroke-width=\"2\"/>${T(CX[c],41,'D'+n,11,'#222','middle')}${T(CX[c],56,d[c],14,'#000','middle')}</g>`;
  o+=`<rect x=\"${CX[c]-24}\" y=\"84\" width=\"48\" height=\"26\" rx=\"4\" fill=\"${we?'#cfe8ff':'#eee'}\" stroke=\"${we?'#2f6fdb':'#aaa'}\" stroke-width=\"2\"/>${T(CX[c],101,'driver',11,we?'#124':'#999','middle')}`;
 }
 o+=T(300,40,'DATA IN → write drivers',11,'#556').replace('x=\"300\"','x=\"330\"');
 // output buffers
 for(let c=0;c<4;c++){
  o+=`<rect x=\"${CX[c]-24}\" y=\"470\" width=\"48\" height=\"26\" rx=\"4\" fill=\"${oe?'#d9f2d9':'#eee'}\" stroke=\"${oe?'#2a7':'#aaa'}\" stroke-width=\"2\"/>${T(CX[c],487,'buffer',11,oe?'#141':'#999','middle')}`;
  o+=`<line x1=\"${CX[c]}\" y1=\"496\" x2=\"${CX[c]}\" y2=\"512\" stroke=\"${oe?col(bl[c]):LO}\" stroke-width=\"3\" ${oe?'':'stroke-dasharray=\"3 3\"'}/>`;
  o+=`<circle cx=\"${CX[c]}\" cy=\"530\" r=\"16\" fill=\"${oe?col(bl[c]):'#f4f4f4'}\" stroke=\"#445\" stroke-width=\"2\"/>${T(CX[c],535,oe?bl[c]:'Z',14,'#000','middle')}`;
  o+=T(CX[c],566,'Q'+(3-c),11,'#556','middle');
 }
 o+=T(400,530,'DATA OUT',13,'#556','end')+T(400,546,oe?'(selected row)':'(disconnected)',11,'#778','end');
 // control pins
 o+=`<g class=\"clk\" onclick=\"setWE()\"><rect x=\"860\" y=\"26\" width=\"90\" height=\"36\" rx=\"6\" fill=\"${col(we)}\" stroke=\"#445\" stroke-width=\"2\"/>${T(905,41,'WE (write)',11,'#222','middle')}${T(905,56,we,14,'#000','middle')}</g>`;
 o+=`<g class=\"clk\" onclick=\"tick()\"><rect x=\"970\" y=\"26\" width=\"90\" height=\"36\" rx=\"6\" fill=\"${col(clk)}\" stroke=\"#445\" stroke-width=\"2\"/>${T(1015,41,'CLK',11,'#222','middle')}${T(1015,56,clk,14,'#000','middle')}</g>`;
 o+=`<line x1=\"905\" y1=\"62\" x2=\"905\" y2=\"80\" stroke=\"${col(we)}\" stroke-width=\"3\"/><line x1=\"1015\" y1=\"62\" x2=\"1015\" y2=\"80\" stroke=\"${col(clk)}\" stroke-width=\"3\"/>`;
 o+=`<path d=\"M885 80 H1035 V104 Q1035 124 960 124 Q885 124 885 104 Z\" fill=\"${strobe?HI:'#eee'}\" stroke=\"#445\" stroke-width=\"2\"/>${T(960,106,'AND  → strobe',12,'#222','middle')}`;
 o+=`<path d=\"M960 124 V136 H830 V105 H812\" fill=\"none\" stroke=\"${col(strobe)}\" stroke-width=\"3\"/>`;
 o+=T(1060,142,'strobe='+(strobe?1:0),11,strobe?'#a60':'#778','end');
 o+=T(830,150,'',10);
 // OE
 o+=`<g class=\"clk\" onclick=\"setOE()\"><rect x=\"860\" y=\"468\" width=\"90\" height=\"36\" rx=\"6\" fill=\"${col(oe)}\" stroke=\"#445\" stroke-width=\"2\"/>${T(905,483,'OE (read)',11,'#222','middle')}${T(905,498,oe,14,'#000','middle')}</g>`;
 o+=`<line x1=\"860\" y1=\"486\" x2=\"812\" y2=\"486\" stroke=\"${col(oe)}\" stroke-width=\"3\"/>`;
 // waveform
 o+=T(860,190,'CLOCK HISTORY',11,'#556');
 const x0=860,yH=210,yL=250;let p='',prev=hist[0].v;p+=`M${x0} ${prev?yH:yL}`;
 hist.forEach((h,i)=>{const x=x0+i*20,y=h.v?yH:yL,py=prev?yH:yL;if(i>0)p+=` L${x} ${py} L${x} ${y}`;p+=` L${x+20} ${y}`;prev=h.v});
 o+=`<path d=\"${p}\" fill=\"none\" stroke=\"#2f6fdb\" stroke-width=\"2.5\"/>`;
 hist.forEach((h,i)=>{if(h.w)o+=`<text x=\"${x0+i*20}\" y=\"${yH-6}\" font-size=\"12\" fill=\"${RED}\" text-anchor=\"middle\">▲W</text>`});
 o+=T(860,270,'▲W = rising edge that wrote a row',10,RED);
 // legend explainer
 o+=T(860,310,'HOW TO READ IT',11,'#556');
 ['1 Address bits (A2 A1 A0)','  and their inverses feed','  eight AND gates.','2 Exactly one AND fires:','  that word line goes high.','3 Read: row connects to bit','  lines, OE passes it to Q.','4 Write: WE and CLK make a','  strobe; drivers put D on','  the bit lines; the selected','  row stores it.'].forEach((t,i)=>o+=T(860,328+i*15,t,11,'#445'));
 document.getElementById('svg').innerHTML=o;
 document.getElementById('log').innerHTML=msg||('Address <b>'+a.join('')+'</b> = '+s+': the decoder raised word line '+s+' (the other 7 stay low). '+(we?'WE=1, so the bit lines show your data '+d.join('')+' and the row will take it on the next clock rising edge.':'WE=0, so the bit lines carry row '+s+'\\'s contents '+mem[s].join('')+(oe?' out to Q.':', but OE=0 so the output is disconnected (Z).')));
}
draw();
</script></body></html>"
 :AT "2026-11-14T09:42:32" :VERSION 2)
(:PINNED T :ID "clock-skew-vs-clock-tree" :MAP "computers" :NODE "clock-tree" :TYPE "html" :TITLE
 "Clock skew vs clock tree" :LANGUAGE NIL :CONTENT
 "<!DOCTYPE html><html><head><meta charset=\"utf-8\"><style>
body{font-family:system-ui,sans-serif;margin:0;padding:12px;background:#fafafa;color:#222}
.bar{display:flex;gap:8px;flex-wrap:wrap;align-items:center;margin-bottom:8px}
button{padding:6px 12px;border:1px solid #888;border-radius:6px;background:#fff;cursor:pointer;font-size:14px}
button.on{background:#222;color:#fff}
svg{width:100%;background:#fff;border:1px solid #ddd;border-radius:8px}
#info{margin-top:8px;font-size:14px;line-height:1.45;padding:8px 10px;border-radius:6px;background:#eef}
.sk{font-weight:600}
text{font-family:system-ui,sans-serif}
#buf{margin-top:20px;font-size:14px;line-height:1.5}
#buf h3{margin:0 0 6px}
</style></head><body>
<div class=\"bar\">
<button id=\"bN\" class=\"on\">Naive: direct wires</button>
<button id=\"bT\">Clock tree: balanced + buffers</button>
<button id=\"bR\">▶ Replay</button>
<label style=\"font-size:13px\">slow-mo <input type=\"range\" id=\"sp\" min=\"0.3\" max=\"2\" step=\"0.1\" value=\"1\"></label>
</div>
<svg id=\"s\" viewBox=\"0 0 780 390\"></svg>
<div id=\"info\"></div>

<div id=\"buf\">
<h3>What is a buffer?</h3>
<p>A buffer is a gate that outputs <b>the same value it receives</b>, but with much more current behind it. It doesn't change the logic; it re-drives the signal. A long wire and many flip-flop inputs act like a big capacitor, and a weak source charges it slowly (a slow, mushy edge). A buffer's output stage is built from wide transistors that charge it fast, and it also restores a clean edge.</p>
<p>It is made of <b>two inverters in series</b>: the first small (light load for whoever drives it), the second large (strong drive). Each inverter is one PMOS and one NMOS transistor.</p>
<svg viewBox=\"0 0 780 330\" id=\"bsvg\">
 <!-- Panel A -->
 <text x=\"130\" y=\"20\" text-anchor=\"middle\" font-size=\"14\" font-weight=\"600\">A. One inverter (CMOS)</text>
 <line x1=\"90\" y1=\"38\" x2=\"190\" y2=\"38\" stroke=\"#c33\" stroke-width=\"3\"/>
 <text x=\"200\" y=\"42\" font-size=\"12\" fill=\"#c33\">VDD (1)</text>
 <line x1=\"140\" y1=\"38\" x2=\"140\" y2=\"62\" stroke=\"#222\" stroke-width=\"2\"/>
 <rect x=\"112\" y=\"62\" width=\"56\" height=\"50\" rx=\"5\" fill=\"#fde8e8\" stroke=\"#c33\" stroke-width=\"1.5\"/>
 <text x=\"140\" y=\"85\" text-anchor=\"middle\" font-size=\"12\" font-weight=\"600\">PMOS</text>
 <text x=\"140\" y=\"101\" text-anchor=\"middle\" font-size=\"11\" fill=\"#555\">on when in=0</text>
 <line x1=\"140\" y1=\"112\" x2=\"140\" y2=\"182\" stroke=\"#222\" stroke-width=\"2\"/>
 <circle cx=\"140\" cy=\"147\" r=\"4\" fill=\"#222\"/>
 <line x1=\"140\" y1=\"147\" x2=\"230\" y2=\"147\" stroke=\"#222\" stroke-width=\"2\"/>
 <text x=\"236\" y=\"151\" font-size=\"12\" font-weight=\"600\">OUT</text>
 <rect x=\"112\" y=\"182\" width=\"56\" height=\"50\" rx=\"5\" fill=\"#e6eefc\" stroke=\"#27c\" stroke-width=\"1.5\"/>
 <text x=\"140\" y=\"205\" text-anchor=\"middle\" font-size=\"12\" font-weight=\"600\">NMOS</text>
 <text x=\"140\" y=\"221\" text-anchor=\"middle\" font-size=\"11\" fill=\"#555\">on when in=1</text>
 <line x1=\"140\" y1=\"232\" x2=\"140\" y2=\"262\" stroke=\"#222\" stroke-width=\"2\"/>
 <line x1=\"110\" y1=\"262\" x2=\"170\" y2=\"262\" stroke=\"#222\" stroke-width=\"3\"/>
 <line x1=\"120\" y1=\"268\" x2=\"160\" y2=\"268\" stroke=\"#222\" stroke-width=\"2\"/>
 <line x1=\"130\" y1=\"274\" x2=\"150\" y2=\"274\" stroke=\"#222\" stroke-width=\"2\"/>
 <text x=\"180\" y=\"266\" font-size=\"12\">GND (0)</text>
 <!-- gate wire -->
 <line x1=\"20\" y1=\"147\" x2=\"70\" y2=\"147\" stroke=\"#222\" stroke-width=\"2\"/>
 <text x=\"20\" y=\"139\" font-size=\"12\" font-weight=\"600\">IN</text>
 <polyline points=\"112,87 70,87 70,207 112,207\" fill=\"none\" stroke=\"#222\" stroke-width=\"2\"/>
 <circle cx=\"70\" cy=\"147\" r=\"4\" fill=\"#222\"/>
 <text x=\"130\" y=\"305\" text-anchor=\"middle\" font-size=\"12\" fill=\"#555\">in=1: bottom on, top off → out pulled to 0</text>
 <text x=\"130\" y=\"321\" text-anchor=\"middle\" font-size=\"12\" fill=\"#555\">in=0: top on, bottom off → out pulled to 1</text>
 <!-- divider -->
 <line x1=\"285\" y1=\"14\" x2=\"285\" y2=\"320\" stroke=\"#ddd\"/>
 <!-- Panel B -->
 <text x=\"530\" y=\"20\" text-anchor=\"middle\" font-size=\"14\" font-weight=\"600\">B. Buffer = two inverters, small then big</text>
 <rect x=\"335\" y=\"55\" width=\"215\" height=\"140\" rx=\"8\" fill=\"none\" stroke=\"#2a7\" stroke-dasharray=\"6 4\" stroke-width=\"1.5\"/>
 <text x=\"442\" y=\"212\" text-anchor=\"middle\" font-size=\"12\" fill=\"#164\">buffer</text>
 <line x1=\"300\" y1=\"125\" x2=\"350\" y2=\"125\" stroke=\"#222\" stroke-width=\"2\"/>
 <text x=\"300\" y=\"115\" font-size=\"12\" font-weight=\"600\">IN</text>
 <polygon points=\"350,100 350,150 395,125\" fill=\"#e6f5ee\" stroke=\"#164\" stroke-width=\"2\"/>
 <circle cx=\"400\" cy=\"125\" r=\"5\" fill=\"#fff\" stroke=\"#164\" stroke-width=\"2\"/>
 <text x=\"375\" y=\"170\" text-anchor=\"middle\" font-size=\"12\">1×</text>
 <line x1=\"405\" y1=\"125\" x2=\"425\" y2=\"125\" stroke=\"#222\" stroke-width=\"2\"/>
 <text x=\"415\" y=\"113\" text-anchor=\"middle\" font-size=\"11\" fill=\"#555\">inverted</text>
 <polygon points=\"425,80 425,170 505,125\" fill=\"#e6f5ee\" stroke=\"#164\" stroke-width=\"2\"/>
 <circle cx=\"510\" cy=\"125\" r=\"5\" fill=\"#fff\" stroke=\"#164\" stroke-width=\"2\"/>
 <text x=\"462\" y=\"187\" text-anchor=\"middle\" font-size=\"12\">4× (wider transistors)</text>
 <line x1=\"515\" y1=\"125\" x2=\"700\" y2=\"125\" stroke=\"#222\" stroke-width=\"2\"/>
 <text x=\"560\" y=\"115\" font-size=\"12\" font-weight=\"600\">OUT (same as IN)</text>
 <!-- load cap -->
 <circle cx=\"650\" cy=\"125\" r=\"4\" fill=\"#222\"/>
 <line x1=\"650\" y1=\"125\" x2=\"650\" y2=\"148\" stroke=\"#222\" stroke-width=\"2\"/>
 <line x1=\"632\" y1=\"148\" x2=\"668\" y2=\"148\" stroke=\"#222\" stroke-width=\"3\"/>
 <line x1=\"632\" y1=\"156\" x2=\"668\" y2=\"156\" stroke=\"#222\" stroke-width=\"3\"/>
 <line x1=\"650\" y1=\"156\" x2=\"650\" y2=\"176\" stroke=\"#222\" stroke-width=\"2\"/>
 <line x1=\"636\" y1=\"176\" x2=\"664\" y2=\"176\" stroke=\"#222\" stroke-width=\"3\"/>
 <text x=\"676\" y=\"156\" font-size=\"12\" fill=\"#c40\">load: wire + gate</text>
 <text x=\"676\" y=\"170\" font-size=\"12\" fill=\"#c40\">capacitance</text>
 <text x=\"530\" y=\"250\" text-anchor=\"middle\" font-size=\"12\" fill=\"#555\">Values: IN=1 → middle=0 → OUT=1. Logic unchanged.</text>
 <text x=\"530\" y=\"270\" text-anchor=\"middle\" font-size=\"12\" fill=\"#555\">The first inverter is easy for the source to drive; the second has</text>
 <text x=\"530\" y=\"286\" text-anchor=\"middle\" font-size=\"12\" fill=\"#555\">the muscle to charge the load quickly. Each stage is about 3–4× bigger</text>
 <text x=\"530\" y=\"302\" text-anchor=\"middle\" font-size=\"12\" fill=\"#555\">than the last; a chain of them lets a tiny gate drive a huge load.</text>
 <text x=\"530\" y=\"322\" text-anchor=\"middle\" font-size=\"12\" fill=\"#164\">In the clock tree each green triangle above is one of these.</text>
</svg>
</div>

<script>
const NS=\"http://www.w3.org/2000/svg\",svg=document.getElementById('s');
const V=250,DD=0.8,PS=2; // px/s, data delay (s), ps per px (exaggerated)
const sinks=[{id:'reg',name:'Register file',sub:'flip-flops',L:1,y:80,cx:200},
{id:'pc',name:'Control / PC',sub:'flip-flops',L:1,y:320,cx:200},
{id:'alu',name:'ALU result reg',sub:'flip-flops',L:0,y:80,cx:700},
{id:'ram',name:'RAM',sub:'write port',L:0,y:320,cx:700}];
let mode='N',t=0,last=null,els={};
function el(n,a,p=svg,txt){const e=document.createElementNS(NS,n);for(const k in a)e.setAttribute(k,a[k]);if(txt!==undefined)e.textContent=txt;p.appendChild(e);return e}
function pathFor(s){const pin=s.L?260:640;
 if(mode=='T')return`M60 200 H450 V${s.y} H${pin}`;
 return s.L?`M60 200 H300 V${s.y} H260`:`M60 200 H600 V${s.y} H640`}
function build(){
 svg.innerHTML='';els={};
 el('path',{d:'M200 50 V22 H410 M490 22 H700 V50',fill:'none',stroke:'#9ab','stroke-width':2,'stroke-dasharray':'5 4'});
 el('rect',{x:410,y:6,width:80,height:32,rx:5,fill:'#e8f0ff',stroke:'#58a'});
 el('text',{x:450,y:27,'text-anchor':'middle','font-size':13},svg,'ALU (logic)');
 el('text',{x:330,y:16,'text-anchor':'middle','font-size':11,fill:'#678'},svg,'data wire');
 el('rect',{x:6,y:175,width:54,height:50,rx:6,fill:'#fff3d6',stroke:'#c90'});
 el('text',{x:33,y:197,'text-anchor':'middle','font-size':12},svg,'Clock');
 el('text',{x:33,y:213,'text-anchor':'middle','font-size':12},svg,'source');
 sinks.forEach(s=>{
  const d=pathFor(s);
  el('path',{d,fill:'none',stroke:'#ccc','stroke-width':4});
  const ov=el('path',{d,fill:'none',stroke:'#e63',\"stroke-width\":4});
  const dot=el('circle',{r:7,fill:'#e63',stroke:'#fff','stroke-width':2,visibility:'hidden'});
  const bx=s.L?140:640;
  const rect=el('rect',{x:bx,y:s.y-30,width:120,height:60,rx:7,fill:'#f4f4f4',stroke:'#555','stroke-width':1.5});
  el('text',{x:bx+60,y:s.y-10,'text-anchor':'middle','font-size':13,'font-weight':600},svg,s.name);
  el('text',{x:bx+60,y:s.y+5,'text-anchor':'middle','font-size':11,fill:'#666'},svg,s.sub);
  const st=el('text',{x:bx+60,y:s.y+22,'text-anchor':'middle','font-size':12,fill:'#666'},svg,'waiting…');
  el('rect',{x:s.L?256:636,y:s.y-4,width:8,height:8,fill:'#222'});
  els[s.id]={ov,dot,rect,st,path:ov,len:ov.getTotalLength()};
 });
 if(mode=='T'){
  [[450,200,'root'],[450,80,'mid'],[450,320,'mid']].forEach(([x,y])=>{
   const g=el('path',{d:`M${x-9} ${y-10} L${x+11} ${y} L${x-9} ${y+10}Z`,fill:'#2a7',stroke:'#164'});
  });
  el('text',{x:462,y:222,'font-size':12,fill:'#164'},svg,'buffers');
  el('text',{x:462,y:68,'font-size':12,fill:'#164'},svg,'every leaf = 700 px path');
 }
 els.q=el('text',{x:200,y:140,'text-anchor':'middle','font-size':13,'font-weight':600},svg,'Q = 0');
 els.dd=el('circle',{r:6,fill:'#27c',visibility:'hidden'});
 els.dp=svg.querySelector('path[stroke-dasharray]');
 els.dl=els.dp.getTotalLength();
 els.verdict=el('text',{x:700,y:140,'text-anchor':'middle','font-size':13,'font-weight':600},svg,'');
 el('text',{x:390,y:375,'text-anchor':'middle','font-size':12,fill:'#666'},svg,'Orange = clock edge travelling at a fixed wire speed. Arrival times shown in ps (exaggerated, schematic).');
}
function arr(s){return els[s.id].len/V}
function frame(ms){
 if(last==null)last=ms;const dt=(ms-last)/1000;last=ms;
 t+=dt*document.getElementById('sp').value;
 const tA=arr(sinks[0]),tB=arr(sinks[2]);
 sinks.forEach(s=>{const e=els[s.id],d=Math.min(t*V,e.len);
  e.ov.setAttribute('stroke-dasharray',`${d} ${e.len+10}`);
  const p=e.path.getPointAtLength(d);
  e.dot.setAttribute('cx',p.x);e.dot.setAttribute('cy',p.y);
  e.dot.setAttribute('visibility',(t>0&&d<e.len)?'visible':'hidden');
  if(t>=arr(s)){e.rect.setAttribute('fill','#ffe3d3');e.rect.setAttribute('stroke','#e63');
   e.st.textContent='edge @ '+Math.round(e.len*PS)+' ps';e.st.setAttribute('fill','#c40');}
 });
 els.q.textContent='Q = '+(t>=tA?1:0);
 const u=(t-tA)/DD;
 if(u>0&&u<1){const p=els.dp.getPointAtLength(u*els.dl);els.dd.setAttribute('cx',p.x);els.dd.setAttribute('cy',p.y);els.dd.setAttribute('visibility','visible')}else els.dd.setAttribute('visibility','hidden');
 if(t>=tB){const bad=(tA+DD<=tB);
  els.verdict.textContent=bad?'captured 1 ✗ (should be old 0)':'captured 0 ✓ (old value)';
  els.verdict.setAttribute('fill',bad?'#c00':'#168a3a');}
 else els.verdict.textContent='';
 info(t>=Math.max(tA,tB));
 if(t<8)requestAnimationFrame(frame);
}
function info(done){
 const ar=sinks.map(s=>els[s.id].len*PS),sk=Math.max(...ar)-Math.min(...ar);
 const bad=arr(sinks[0])+DD<=arr(sinks[2]);
 document.getElementById('info').innerHTML=
 (mode=='N'?'<b>Naive wiring:</b> each block is wired straight to the clock, so near blocks get the edge early and far blocks late. ':'<b>Clock tree:</b> the edge goes through buffers that split it into equal-length branches, so every block gets it together. ')+
 '<br>Skew (latest − earliest arrival) = <span class=\"sk\" style=\"color:'+(sk?'#c00':'#168a3a')+'\">'+sk+' ps</span>.'+
 (done?(bad?'<br>The register file fired early, its new output raced down the data wire, and the ALU register — whose clock was still late — copied the <b>new</b> value instead of the old one. Wrong state.':'<br>Both registers switched at the same instant, so the ALU register captured the old value, as intended. Everyone arrives later than the source, but at the same moment — only the <i>difference</i> matters.'):'');
}
function replay(){t=0;last=null;build();requestAnimationFrame(frame)}
function setMode(m){mode=m;bN.className=m=='N'?'on':'';bT.className=m=='T'?'on':'';replay()}
bN.onclick=()=>setMode('N');bT.onclick=()=>setMode('T');bR.onclick=replay;
build();info(false);requestAnimationFrame(frame);
</script></body></html>
"
 :AT "2026-11-14T10:11:40" :VERSION 2)
(:PINNED T :ID "von-neumann-vs-harvard" :MAP "computers" :NODE "code-and-data-alike" :TYPE "svg"
 :TITLE "Von Neumann vs Harvard" :LANGUAGE NIL :CONTENT
 "<svg viewBox=\"0 0 900 420\" xmlns=\"http://www.w3.org/2000/svg\" font-family=\"sans-serif\">
<rect width=\"900\" height=\"420\" fill=\"#fff\"/>
<text x=\"225\" y=\"30\" text-anchor=\"middle\" font-size=\"18\" font-weight=\"bold\">Harvard</text>
<text x=\"675\" y=\"30\" text-anchor=\"middle\" font-size=\"18\" font-weight=\"bold\">Von Neumann</text>
<line x1=\"450\" y1=\"45\" x2=\"450\" y2=\"400\" stroke=\"#ccc\" stroke-dasharray=\"6 6\"/>

<rect x=\"150\" y=\"170\" width=\"150\" height=\"70\" rx=\"8\" fill=\"#dbe9ff\" stroke=\"#2b5fb3\" stroke-width=\"2\"/>
<text x=\"225\" y=\"212\" text-anchor=\"middle\" font-size=\"16\">CPU</text>
<rect x=\"30\" y=\"60\" width=\"150\" height=\"70\" rx=\"8\" fill=\"#ffe3c2\" stroke=\"#c46a00\" stroke-width=\"2\"/>
<text x=\"105\" y=\"90\" text-anchor=\"middle\" font-size=\"14\">Instruction</text>
<text x=\"105\" y=\"110\" text-anchor=\"middle\" font-size=\"14\">memory</text>
<rect x=\"270\" y=\"60\" width=\"150\" height=\"70\" rx=\"8\" fill=\"#d6f2dc\" stroke=\"#2c8a45\" stroke-width=\"2\"/>
<text x=\"345\" y=\"90\" text-anchor=\"middle\" font-size=\"14\">Data</text>
<text x=\"345\" y=\"110\" text-anchor=\"middle\" font-size=\"14\">memory</text>
<line x1=\"125\" y1=\"130\" x2=\"185\" y2=\"170\" stroke=\"#c46a00\" stroke-width=\"3\"/>
<line x1=\"325\" y1=\"130\" x2=\"265\" y2=\"170\" stroke=\"#2c8a45\" stroke-width=\"3\"/>
<text x=\"225\" y=\"285\" text-anchor=\"middle\" font-size=\"14\">Two memories, two buses:</text>
<text x=\"225\" y=\"305\" text-anchor=\"middle\" font-size=\"14\">fetch and data access in the same cycle.</text>
<text x=\"225\" y=\"330\" text-anchor=\"middle\" font-size=\"14\" fill=\"#a22\">Program can't be written by the program.</text>
<text x=\"225\" y=\"350\" text-anchor=\"middle\" font-size=\"14\" fill=\"#a22\">No loader, compiler output or JIT in RAM.</text>

<rect x=\"600\" y=\"170\" width=\"150\" height=\"70\" rx=\"8\" fill=\"#dbe9ff\" stroke=\"#2b5fb3\" stroke-width=\"2\"/>
<text x=\"675\" y=\"212\" text-anchor=\"middle\" font-size=\"16\">CPU</text>
<rect x=\"540\" y=\"60\" width=\"270\" height=\"70\" rx=\"8\" fill=\"#f0e0f7\" stroke=\"#7a3b99\" stroke-width=\"2\"/>
<text x=\"675\" y=\"88\" text-anchor=\"middle\" font-size=\"14\">One memory</text>
<text x=\"675\" y=\"108\" text-anchor=\"middle\" font-size=\"13\">[code][data][code][data]…</text>
<line x1=\"675\" y1=\"130\" x2=\"675\" y2=\"170\" stroke=\"#7a3b99\" stroke-width=\"3\"/>
<text x=\"675\" y=\"285\" text-anchor=\"middle\" font-size=\"14\">One memory, one bus:</text>
<text x=\"675\" y=\"305\" text-anchor=\"middle\" font-size=\"14\">instructions are numbers like any other.</text>
<text x=\"675\" y=\"330\" text-anchor=\"middle\" font-size=\"14\" fill=\"#2c6b3a\">Programs can write programs.</text>
<text x=\"675\" y=\"350\" text-anchor=\"middle\" font-size=\"14\" fill=\"#2c6b3a\">Compilers, loaders, OSes, JITs.</text>
<text x=\"675\" y=\"375\" text-anchor=\"middle\" font-size=\"13\" fill=\"#a22\">Cost: data can be run as code (exploits).</text>
</svg>"
 :AT "2026-11-14T14:00:40" :VERSION 1)
(:PINNED T :ID "wiring-to-stored-programs-to-assembly" :MAP "computers" :NODE
 "machine-code-assembly" :TYPE "quiz" :TITLE "Wiring to stored programs to assembly" :LANGUAGE NIL
 :CONTENT
 ((:NODE "machine-code-assembly" :EXPLANATION
   "ENIAC's program lived in its physical wiring and switch settings, not in memory." :ANSWER 1
   :OPTIONS
   ("Loading a program from punched cards into memory" "Rewiring cables and setting switches"
    "Typing mnemonics like LDA on a keyboard" "Running an assembler from paper tape")
   :QUESTION "How was ENIAC (1945) given a new program?")
  (:NODE "machine-code-assembly" :EXPLANATION
   "Binary electronic logic already existed; the shift was instructions sharing memory with data."
   :ANSWER 2 :OPTIONS
   ("It uses binary logic" "It is built from electronic switches"
    "Instructions are numbers held in the same memory as data"
    "It reads programs only from punched cards")
   :QUESTION "What is the defining property of a stored-program computer?")
  (:NODE "machine-code-assembly" :EXPLANATION
   "An assembler outputs instructions; ENIAC's instructions weren't numbers in memory, so there was nowhere to write them."
   :ANSWER 1 :OPTIONS
   ("It was too slow"
    "It had no way to write instructions as numbers into memory, since its program was wiring"
    "It did not use binary" "It had no input device")
   :QUESTION "Why couldn't ENIAC have run an assembler?")
  (:NODE "machine-code-assembly" :EXPLANATION
   "Assembly is mostly a one-to-one rename: lookup table inside a loop. Labels add address bookkeeping."
   :ANSWER 0 :OPTIONS
   ("A loop that reads each line, looks up the name in a table, and emits the number"
    "A program that turns one high-level line into many optimised instructions"
    "A circuit that translates voltages into letters" "A table that rewires the machine")
   :QUESTION "What is the core mechanism of an assembler?")
  (:NODE "machine-code-assembly" :EXPLANATION
   "Wheeler's Initial Orders for EDSAC at Cambridge read letter mnemonics and stored binary instructions."
   :ANSWER 1 :OPTIONS
   ("Grace Hopper, UNIVAC" "David Wheeler, EDSAC" "John Backus, IBM 704" "Konrad Zuse, Z3")
   :QUESTION "Who wrote the first assembler-like 'Initial Orders' (1949), and for which machine?")
  (:NODE "machine-code-assembly" :EXPLANATION
   "Assembly is roughly one-to-one; compilers make one line become many instructions. Both rely on programs that write programs."
   :ANSWER 1 :OPTIONS
   ("Instructions became electronic" "One source line expands into many machine instructions"
    "Programs could be stored in memory for the first time"
    "Programs no longer needed binary at all")
   :QUESTION "What is the real jump in power that came after assembly, with FORTRAN (1957)?")
  (:NODE "machine-code-assembly" :EXPLANATION
   "Logic was already electronic; memory capable of holding programs (Baby 1948, EDSAC 1949) was the enabler."
   :ANSWER 1 :OPTIONS
   ("Electronic logic made assembly possible"
    "Large enough, fast memory let programs be stored, so a program could produce instructions"
    "Punched cards made assembly necessary" "Faster clocks made assembly possible")
   :QUESTION "Which statement about the cause of assembly is most accurate?"))
 :AT "2026-11-14T14:10:04" :VERSION 1)
(:PINNED T :ID "three-kinds-of-bootstrapping" :MAP "computers" :NODE "reset-vector-bootstrap" :TYPE
 "html" :TITLE "Three kinds of bootstrapping" :LANGUAGE NIL :CONTENT "<!DOCTYPE html>
<html><head><meta charset=\"utf-8\"><style>
body{font-family:system-ui,sans-serif;margin:0;padding:12px;background:#fafafa;color:#222}
.tabs{display:flex;gap:6px;flex-wrap:wrap;margin-bottom:8px}
button{border:1px solid #888;background:#fff;border-radius:6px;padding:6px 10px;cursor:pointer;font-size:14px}
button.on{background:#2b5fd9;color:#fff;border-color:#2b5fd9}
svg{width:100%;background:#fff;border:1px solid #ddd;border-radius:8px}
#cap{min-height:3.2em;margin:8px 2px;font-size:15px}
</style></head><body>
<div class=\"tabs\">
<button id=\"b0\" onclick=\"sel(0)\">1. The boots</button>
<button id=\"b1\" onclick=\"sel(1)\">2. Computer boot</button>
<button id=\"b2\" onclick=\"sel(2)\">3. Startup</button>
<button onclick=\"replay()\">↻ Replay</button>
<button id=\"pp\" onclick=\"pause()\">⏸ Pause</button>
</div>
<svg id=\"s\" viewBox=\"0 0 640 420\"></svg>
<div id=\"cap\"></div>
<script>
// Single source of truth: elapsed seconds `el`, advanced by real frame deltas while not paused.
// No absolute timestamps are compared, so a button click can never produce a negative time.
let cur=0,el=0,paused=false,last=null;
const S=document.getElementById('s'),C=document.getElementById('cap');
function sel(i){cur=i;el=0;last=null;for(let k=0;k<3;k++)document.getElementById('b'+k).className=k==i?'on':'';draw()}
function replay(){el=0;last=null;draw()}
function pause(){paused=!paused;last=null;document.getElementById('pp').textContent=paused?'▶ Play':'⏸ Pause'}
const clamp=(x,a=0,b=1)=>Math.max(a,Math.min(b,x));
const txt=(x,y,s,o='')=>`<text x=\"${x}\" y=\"${y}\" font-size=\"14\" ${o}>${s}</text>`;

function scene0(t){ // loop 10s
  const pull=clamp(t/3)*(t<6?1:clamp(1-(t-6)/1));
  const sh=Math.sin(t*35)*pull*2.5, cx=200+sh;
  const hy=270-pull*40; // hands rise
  let g=`<line x1=\"20\" y1=\"380\" x2=\"620\" y2=\"380\" stroke=\"#555\" stroke-width=\"3\"/>`;
  g+=`<g stroke=\"#222\" stroke-width=\"5\" stroke-linecap=\"round\" fill=\"none\">
  <line x1=\"${cx}\" y1=\"250\" x2=\"${cx-22}\" y2=\"365\"/><line x1=\"${cx}\" y1=\"250\" x2=\"${cx+22}\" y2=\"365\"/>
  <line x1=\"${cx}\" y1=\"165\" x2=\"${cx}\" y2=\"250\"/>
  <line x1=\"${cx}\" y1=\"180\" x2=\"${cx-45}\" y2=\"${hy}\"/><line x1=\"${cx}\" y1=\"180\" x2=\"${cx+45}\" y2=\"${hy}\"/></g>
  <circle cx=\"${cx}\" cy=\"140\" r=\"24\" fill=\"#fff\" stroke=\"#222\" stroke-width=\"5\"/>
  <rect x=\"${cx-42}\" y=\"364\" width=\"38\" height=\"16\" rx=\"5\" fill=\"#8b5a2b\"/><rect x=\"${cx+4}\" y=\"364\" width=\"38\" height=\"16\" rx=\"5\" fill=\"#8b5a2b\"/>
  <g stroke=\"#c0392b\" stroke-width=\"3\"><line x1=\"${cx-30}\" y1=\"364\" x2=\"${cx-45}\" y2=\"${hy}\"/><line x1=\"${cx+30}\" y1=\"364\" x2=\"${cx+45}\" y2=\"${hy}\"/></g>`;
  if(t>2){const a=clamp((t-2)/1.5), L=70*a;
    g+=`<g stroke=\"#2b5fd9\" stroke-width=\"4\" fill=\"#2b5fd9\" opacity=\"${a}\"><line x1=\"${cx+70}\" y1=\"${hy}\" x2=\"${cx+70}\" y2=\"${hy-L}\"/><polygon points=\"${cx+62},${hy-L} ${cx+78},${hy-L} ${cx+70},${hy-L-12}\"/></g>
    <g stroke=\"#d9302b\" stroke-width=\"4\" fill=\"#d9302b\" opacity=\"${a}\"><line x1=\"${cx+90}\" y1=\"350\" x2=\"${cx+90}\" y2=\"${350+L*0.4}\"/><polygon points=\"${cx+82},${350+L*.4} ${cx+98},${350+L*.4} ${cx+90},${350+L*.4+12}\"/></g>`;
    g+=txt(cx+82,hy-30,'pull up on hands',`fill=\"#2b5fd9\" opacity=\"${a}\"`)+txt(cx+104,372,'push down on boots',`fill=\"#d9302b\" opacity=\"${a}\"`);}
  let c;
  if(t<2)c=\"He tugs on his own bootstraps…\";
  else if(t<6.5){c=\"Pull on the hands is matched by push on the boots. Both forces are <b>internal</b>, so they cancel. Net force 0, and he stays on the ground.\";}
  else {c=\"Literally impossible — so the phrase came to mean <b>getting going with no outside help</b>. A computer cheats the same way: not one giant leap, but a tiny first step that makes the next one possible.\";}
  if(t>6.5)g+=txt(330,90,'“Pull yourself up by your bootstraps”','font-size=\"18\" font-weight=\"bold\"')+txt(330,115,'→ start small, use each step to reach the next','fill=\"#555\"');
  return [g,c];
}

function scene1(t){ // 12.5s
  const st=[[\"Reset vector → ROM\",\"~0.5 KB\",12,\"#c0392b\",\"Reset forces PC to a fixed ROM address. The tiny code there can do just one job: find the next stage.\"],
   [\"Bootloader\",\"~16 KB\",40,\"#e67e22\",\"ROM code starts RAM and a disk or flash, then copies the bootloader into RAM and jumps to it.\"],
   [\"Kernel\",\"~10 MB\",150,\"#d4ac0d\",\"The bootloader is smart enough to read a filesystem. It loads the kernel and passes control.\"],
   [\"OS services\",\"~500 MB\",300,\"#27ae60\",\"The kernel starts drivers, networking and a login screen.\"],
   [\"Your programs\",\"GBs\",440,\"#2b5fd9\",\"Now the machine can load anything you ask it to.\"]];
  const idx=clamp(Math.floor(t/2.5),0,4), f=clamp((t-idx*2.5)/1.6);
  let g=txt(20,26,'RAM (grows as each stage loads the next)','font-weight=\"bold\"');
  st.forEach((s,i)=>{
    const y=50+i*68, w=i<idx?s[2]:i==idx?s[2]*(i==0?1:f):0;
    g+=`<rect x=\"20\" y=\"${y}\" width=\"450\" height=\"46\" fill=\"#f3f3f3\" stroke=\"#ccc\"/>`;
    if(w>0)g+=`<rect x=\"20\" y=\"${y}\" width=\"${Math.max(w,4)}\" height=\"46\" fill=\"${s[3]}\"/>`;
    g+=txt(w>0&&w>150?28:Math.max(w,4)+28,y+28,s[0]+'  ('+s[1]+')',`fill=\"${w>150?'#fff':'#222'}\"`);
    if(i==idx)g+=`<polygon points=\"490,${y+23} 515,${y+11} 515,${y+35}\" fill=\"#222\"/>`+txt(522,y+28,'PC','font-weight=\"bold\"');
    if(i>0&&i<=idx)g+=`<path d=\"M${480},${y-22} L480,${y-2}\" stroke=\"#555\" stroke-width=\"2\"/>`;
  });
  g+=txt(540,200,'each stage',`font-size=\"12\" fill=\"#666\"`)+txt(540,216,'loads a bigger',`font-size=\"12\" fill=\"#666\"`)+txt(540,232,'one, then jumps',`font-size=\"12\" fill=\"#666\"`);
  return [g,`<b>Stage ${idx+1}: ${st[idx][0]}.</b> ${st[idx][4]}`];
}

function scene2(t){ // 7 laps x 2.2s
  const lap=clamp(Math.floor(t/2.2),0,6), p=clamp((t-lap*2.2)/2.0);
  const cash=n=>10*Math.pow(1.6,n), nodes=[\"Build product\",\"Win customers\",\"Collect revenue\",\"Reinvest (hire, market)\"];
  const cx=170,cy=215,R=105;
  let g=txt(20,26,'The loop','font-weight=\"bold\"')+txt(380,26,'Revenue per lap ($k)','font-weight=\"bold\"');
  g+=`<circle cx=\"${cx}\" cy=\"${cy}\" r=\"${R}\" fill=\"none\" stroke=\"#bbb\" stroke-width=\"3\" stroke-dasharray=\"6 5\"/>`;
  nodes.forEach((n,i)=>{const a=-Math.PI/2+i*Math.PI/2,x=cx+R*Math.cos(a),y=cy+R*Math.sin(a);
    g+=`<circle cx=\"${x}\" cy=\"${y}\" r=\"9\" fill=\"#2b5fd9\"/>`+txt(x+(i==3?-14:14),y+(i==0?-14:i==2?26:4),n,`font-size=\"12\" text-anchor=\"${i==3?'end':'start'}\"`);});
  const a=-Math.PI/2+p*2*Math.PI, cr=6+Math.min(cash(lap)/10,14)*1.2;
  g+=`<circle cx=\"${cx+R*Math.cos(a)}\" cy=\"${cy+R*Math.sin(a)}\" r=\"${cr}\" fill=\"#f1c40f\" stroke=\"#b7950b\" stroke-width=\"2\"/>`;
  g+=txt(cx,cy-4,'Cash',`text-anchor=\"middle\" font-size=\"13\"`)+txt(cx,cy+16,'$'+Math.round(cash(lap+(p>.75?clamp((p-.75)*4):0)))+'k',`text-anchor=\"middle\" font-weight=\"bold\" font-size=\"16\"`);
  const bx=380,base=380;
  for(let i=0;i<=lap;i++){const h=(i<lap?1:clamp(p*1.3))*cash(i+1)*3.4*0.95;
    g+=`<rect x=\"${bx+i*34}\" y=\"${base-h}\" width=\"26\" height=\"${h}\" fill=\"#27ae60\"/>`+txt(bx+i*34+13,base+16,i+1,`text-anchor=\"middle\" font-size=\"12\"`);}
  g+=`<line x1=\"370\" y1=\"${base}\" x2=\"625\" y2=\"${base}\" stroke=\"#555\"/>`+txt(450,404,'lap',`font-size=\"12\"`);
  const c=lap==0?\"<b>Seed money</b> pays for a first rough product — the “tiny ROM”.\":lap<3?\"Revenue is reinvested, so the <b>next lap starts from a bigger base</b>.\":\"Each lap’s output funds a larger next lap: compounding. No outside push needed once the loop turns.\";
  return [g,c];
}
const sc=[scene0,scene1,scene2],dur=[10,13,15.4],HOLD=2;
function draw(){
  const d=dur[cur];
  if(el>d+HOLD)el=0;            // restart after holding the final state
  const t=clamp(el,0,d);        // never negative, never past the end
  try{const [g,c]=sc[cur](t);S.innerHTML=g;C.innerHTML=c}catch(e){console.error(e)}
}
function frame(now){
  if(last!==null&&!paused)el+=Math.min((now-last)/1000,0.1); // delta time; capped so tab-switches don't jump
  last=now;
  draw();
  requestAnimationFrame(frame);  // always reschedules
}
sel(0);requestAnimationFrame(frame);
</script></body></html>
"
 :AT "2026-11-14T22:18:20" :VERSION 2)
(:PINNED T :ID "primitives-that-build-everything" :MAP "computers" :NODE "instruction-set" :TYPE
 "html" :TITLE "Primitives that build everything" :LANGUAGE NIL :CONTENT
 "<!DOCTYPE html><html><head><meta charset=\"utf-8\"><style>
body{font-family:system-ui,sans-serif;margin:0;padding:16px;background:#fafafa;color:#222}
h2{margin:0 0 4px;font-size:18px}p.s{margin:0 0 12px;color:#555;font-size:13px}
.tabs{display:flex;gap:8px;margin-bottom:12px}.tabs button{padding:6px 12px;border:1px solid #bbb;background:#fff;border-radius:8px;cursor:pointer}
.tabs button.on{background:#2b6cb0;color:#fff;border-color:#2b6cb0}
.box{background:#fff;border:1px solid #ddd;border-radius:10px;padding:10px 14px;margin-bottom:10px;font-size:14px}
table{border-collapse:collapse;font-family:monospace}td,th{border:1px solid #ddd;padding:3px 10px;text-align:center}
.ok{color:#1a7f37;font-weight:600}.no{color:#c00;font-weight:600}
.prim{display:inline-flex;align-items:center;gap:6px;margin:4px 12px 4px 0;padding:6px 10px;border:2px solid #ccc;border-radius:8px;cursor:pointer;background:#fff;user-select:none}
.prim.on{border-color:#2b6cb0;background:#e6f0fb}
.task{display:flex;justify-content:space-between;padding:6px 0;border-bottom:1px solid #eee}
.small{font-size:12px;color:#666}code{background:#eee;padding:1px 5px;border-radius:4px}
.hide{display:none}
</style></head><body>
<h2>The primitives: what is the minimum?</h2>
<p class=\"s\">Two different \"completeness\" ideas. Gates need NAND to make any Boolean function. A computer needs four kinds of instruction to run any program.</p>
<div class=\"tabs\"><button id=\"t1\" class=\"on\">1 · Logic: everything from NAND</button><button id=\"t2\">2 · Instructions: what can you compute?</button></div>

<div id=\"p1\">
<div class=\"box\">Pick a gate. It is built <b>only</b> from NAND gates, and checked against the real thing.
<div style=\"margin:8px 0\"><select id=\"g\"><option>NOT</option><option>AND</option><option>OR</option><option>XOR</option></select></div>
<div id=\"recipe\"></div><div id=\"tt\" style=\"margin-top:8px\"></div></div>
<div class=\"box small\">NAND is <i>functionally complete</i> for Boolean logic. That alone gives you a calculator-like circuit, but with no memory of its own and no way to run a program that loops.</div>
</div>

<div id=\"p2\" class=\"hide\">
<div class=\"box\">Click to switch primitives on or off. Which programs can the machine still run?
<div id=\"prims\" style=\"margin-top:8px\"></div></div>
<div class=\"box\" id=\"tasks\"></div>
<div class=\"box small\" id=\"verdict\"></div>
</div>

<script>
const $=id=>document.getElementById(id);
$('t1').onclick=()=>{$('p1').classList.remove('hide');$('p2').classList.add('hide');$('t1').classList.add('on');$('t2').classList.remove('on')};
$('t2').onclick=()=>{$('p2').classList.remove('hide');$('p1').classList.add('hide');$('t2').classList.add('on');$('t1').classList.remove('on')};
// ---- NAND
const nand=(a,b)=>+!(a&&b),NOT=a=>nand(a,a),AND=(a,b)=>NOT(nand(a,b)),OR=(a,b)=>nand(NOT(a),NOT(b));
const XOR=(a,b)=>{const n=nand(a,b);return nand(nand(a,n),nand(b,n))};
const G={NOT:{f:a=>NOT(a),ref:a=>+!a,n:1,r:'NOT a = NAND(a, a)  — tie both inputs together',u:1},
AND:{f:AND,ref:(a,b)=>a&b,n:2,r:'AND = NOT(NAND(a,b))  — NAND, then invert'},
OR:{f:OR,ref:(a,b)=>a|b,n:3,r:'OR = NAND(NOT a, NOT b)  — invert both inputs, then NAND'},
XOR:{f:XOR,ref:(a,b)=>a^b,n:4,r:'n = NAND(a,b); XOR = NAND( NAND(a,n), NAND(b,n) )'}};
function gate(){const k=$('g').value,g=G[k];$('recipe').innerHTML=`<code>${g.r}</code><br><span class=\"small\">${g.n} NAND gate${g.n>1?'s':''}</span>`;
 let rows='';const ins=g.u?[[0],[1]]:[[0,0],[0,1],[1,0],[1,1]];
 for(const i of ins){const o=g.f(...i),r=g.ref(...i);rows+=`<tr><td>${i.join('</td><td>')}</td><td>${o}</td><td>${r}</td><td class=\"${o==r?'ok':'no'}\">${o==r?'✓':'✗'}</td></tr>`}
 $('tt').innerHTML=`<table><tr>${g.u?'<th>a</th>':'<th>a</th><th>b</th>'}<th>from NANDs</th><th>real ${k}</th><th></th></tr>${rows}</table>`}
$('g').onchange=gate;gate();
// ---- instruction primitives
const P=[{k:'alu',n:'Arithmetic / logic (ADD, AND…)'},{k:'imm',n:'Constants (LOADI)'},{k:'mem',n:'Memory (LOAD / STORE)'},{k:'br',n:'Conditional branch (BEQZ)'}];
const on={alu:1,imm:1,mem:1,br:1};
const T=[{n:'Add two numbers already in registers',need:['alu']},
{n:'Put the number 5 into a register',need:['imm']},
{n:'Remember a value and read it back later',need:['mem']},
{n:'Do something only if x = 0 (if / else)',need:['br','alu']},
{n:'Compute 6 × 7 by repeated addition (loop)',need:['alu','imm','br']},
{n:'Sum an array of numbers',need:['alu','imm','mem','br']}];
function draw(){
 $('prims').innerHTML=P.map(p=>`<span class=\"prim ${on[p.k]?'on':''}\" data-k=\"${p.k}\">${on[p.k]?'☑':'☐'} ${p.n}</span>`).join('');
 document.querySelectorAll('.prim').forEach(e=>e.onclick=()=>{on[e.dataset.k]=!on[e.dataset.k];draw()});
 $('tasks').innerHTML=T.map(t=>{const miss=t.need.filter(k=>!on[k]).map(k=>P.find(p=>p.k==k).n.split(' (')[0]);
  return `<div class=\"task\"><span>${t.n}</span><span class=\"${miss.length?'no':'ok'}\">${miss.length?'✗ needs '+miss.join(', '):'✓ possible'}</span></div>`}).join('');
 const all=P.every(p=>on[p.k]);
 $('verdict').innerHTML=all?'With all four, you can express any computation (given enough memory): <b>Turing complete</b>. Compilers then turn languages into sequences of these. Real ISAs add many more instructions, but only for speed and convenience. The extreme: <b>SUBLEQ</b> is a single instruction (subtract, branch if ≤ 0) and is still Turing complete.':
 'Remove or add primitives and watch what breaks. The key one is the <b>conditional branch</b>: without it, a program runs straight through once and cannot loop or decide.'}
draw();
</script></body></html>"
 :AT "2026-11-14T22:48:07" :VERSION 1)
(:PINNED T :ID "abstraction-layers-parts-merge-into-wholes" :MAP "computers" :NODE
 "instruction-set" :TYPE "html" :TITLE "Abstraction layers: parts merge into wholes" :LANGUAGE NIL
 :CONTENT "<!DOCTYPE html><html><head><meta charset=\"utf-8\"><style>
body{font-family:system-ui,sans-serif;margin:0;padding:16px;background:#fafafa;color:#222}
h2{margin:0 0 4px;font-size:18px}p.s{margin:0 0 10px;color:#555;font-size:13px}
.bar{display:flex;gap:8px;flex-wrap:wrap;margin-bottom:8px;align-items:center}
button{padding:6px 12px;border:1px solid #bbb;background:#fff;border-radius:8px;cursor:pointer;font-size:13px}
button.on{background:#2b6cb0;color:#fff;border-color:#2b6cb0}
svg{width:100%;background:#fff;border:1px solid #ddd;border-radius:10px;display:block}
.crumbs{display:flex;gap:4px;flex-wrap:wrap;margin:8px 0;font-size:12px}
.crumbs span{padding:3px 8px;border-radius:12px;border:1px solid #ccc;cursor:pointer;background:#fff}
.crumbs span.cur{font-weight:700;border-width:2px}
.note{background:#fff;border:1px solid #ddd;border-radius:10px;padding:10px 14px;font-size:14px;margin-top:8px}
</style></head><body>
<h2>Abstraction: group the parts, forget the insides</h2>
<p class=\"s\">Each level takes the block from the level below, uses many copies of it, and wraps them into one new block. Then you stop thinking about the insides.</p>
<div class=\"bar\"><button id=\"hw\" class=\"on\">Hardware track</button><button id=\"sw\">Instruction track</button>
<span style=\"width:12px\"></span><button id=\"play\">⏸ Pause</button><button id=\"step\">Next level ▶</button><button id=\"reset\">⟲ Restart</button></div>
<div class=\"crumbs\" id=\"crumbs\"></div>
<svg id=\"svg\" viewBox=\"0 0 800 380\"></svg>
<div class=\"note\" id=\"note\"></div>
<script>
const TR={
hw:[
 {items:Array(4).fill('MOSFET'),cols:4,out:'NAND gate',c:'#4a90d9',note:'4 transistors (switches) wired together make a NAND gate. From here on you think in 1s and 0s, not voltages.'},
 {items:Array(9).fill('NAND'),cols:3,out:'Full adder',c:'#4caf50',note:'9 NAND gates add three bits (a, b, carry-in) and give a sum and carry-out. You no longer think about individual gates.'},
 {items:Array(4).fill('Full adder'),cols:4,out:'4-bit adder IC',c:'#d9a400',note:'Chain the carry through 4 full adders and put it in a package: a real chip (like the 74283). Now it is one part with pins.'},
 {items:['Adder / ALU','Registers','Control logic','Clock'],cols:4,out:'CPU',c:'#e05555',note:'Arithmetic, a few fast memory cells, and control logic that decodes opcodes. The CPU is the thing that implements the ISA.'},
 {items:['CPU','RAM','I/O','Storage'],cols:4,out:'Computer',c:'#8e44ad',note:'The CPU, memory and devices. Software now sees only the ISA and memory, not the circuitry.'}],
sw:[
 {items:['LOAD r1,a','LOAD r2,b','ADD r3,r1,r2','STORE c,r3'],cols:4,out:'c = a + b',c:'#4a90d9',note:'Four instructions (each an opcode + operands) become one line of code. A compiler writes them for you.'},
 {items:['c = a + b','i = i + 1','if i < n: loop'],cols:3,out:'for-loop',c:'#4caf50',note:'Repeating a statement with a conditional branch: the loop. Branching is what makes the machine more than a calculator.'},
 {items:['sum = 0','for-loop','return sum'],cols:3,out:'sum(array)',c:'#d9a400',note:'Setup, loop and result become a function. Others can call it without knowing how it works.'},
 {items:['sum(array)','sort(array)','print(text)'],cols:3,out:'Application',c:'#e05555',note:'Functions combine into a program. You are many layers above the opcodes, and all of it still ends as ISA bit patterns.'}]};
let track='hw',lvl=0,t=0,playing=true,last=performance.now(),hold=0;
const $=id=>document.getElementById(id),svg=$('svg'),DUR=3.2;
const ease=x=>x<0?0:x>1?1:x*x*(3-2*x),cl=x=>Math.max(0,Math.min(1,x));
function crumbs(){const L=TR[track];let h='';
 L.forEach((l,i)=>{h+=`<span data-i=\"${i}\" class=\"${i==lvl?'cur':''}\" style=\"border-color:${l.c};${i<lvl?'background:'+l.c+'22':''}\">${i+1}. ${l.out}</span>`});
 $('crumbs').innerHTML=h;document.querySelectorAll('.crumbs span').forEach(e=>e.onclick=()=>{lvl=+e.dataset.i;t=0;hold=0;crumbs();note()})}
function note(){const l=TR[track][lvl];$('note').innerHTML=`<b>${l.items.length} × ${[...new Set(l.items)].join(' + ')} → ${l.out}</b><br>${l.note}`}
function draw(){
 const l=TR[track][lvl],n=l.items.length,cols=l.cols,rows=Math.ceil(n/cols),W=132,H=46,gx=12,gy=22;
 const gw=cols*W+(cols-1)*gx,gh=rows*H+(rows-1)*gy,cx=400,cy=170,x0=cx-gw/2,y0=cy-gh/2;
 const mv=ease((t-0.3)/0.4),fade=1-ease((t-0.65)/0.15),outp=ease((t-0.72)/0.25);
 let s=`<text x=\"400\" y=\"30\" text-anchor=\"middle\" font-size=\"15\" fill=\"#666\">Level ${lvl+1}: ${l.items.length} blocks join together</text>`;
 const pad=14,bx=x0-pad,by=y0-pad,bw=gw+2*pad,bh=gh+2*pad;
 s+=`<rect x=\"${bx}\" y=\"${by}\" width=\"${bw}\" height=\"${bh}\" rx=\"14\" fill=\"${l.c}\" fill-opacity=\"${0.10*ease((t-0.15)/0.3)*fade}\" stroke=\"${l.c}\" stroke-dasharray=\"6 4\" stroke-opacity=\"${ease((t-0.15)/0.3)*fade}\"/>`;
 l.items.forEach((it,i)=>{const r=Math.floor(i/cols),c=i%cols,rowN=Math.min(cols,n-r*cols),off=(cols-rowN)*(W+gx)/2;
  const ix=x0+off+c*(W+gx),iy=y0+r*(H+gy);
  const tx=cx-W/2+(c-(rowN-1)/2)*8*(1-mv)*0,ty=cy-H/2;
  const x=ix+(cx-W/2-ix)*mv,y=iy+(ty-iy)*mv;
  s+=`<g opacity=\"${fade}\"><rect x=\"${x}\" y=\"${y}\" width=\"${W}\" height=\"${H}\" rx=\"8\" fill=\"#fff\" stroke=\"${l.c}\" stroke-width=\"2\"/><text x=\"${x+W/2}\" y=\"${y+H/2+5}\" text-anchor=\"middle\" font-size=\"13\" fill=\"#222\">${it}</text></g>`});
 if(outp>0){const sc=0.6+0.4*outp,w=240*sc,h=90*sc;
  s+=`<g opacity=\"${outp}\"><rect x=\"${cx-w/2}\" y=\"${cy-h/2}\" width=\"${w}\" height=\"${h}\" rx=\"16\" fill=\"${l.c}\" /><text x=\"${cx}\" y=\"${cy+6}\" text-anchor=\"middle\" font-size=\"${22*sc}\" font-weight=\"700\" fill=\"#fff\">${l.out}</text></g>`}
 // stack below
 const L=TR[track];let sx=20;
 s+=`<text x=\"20\" y=\"318\" font-size=\"12\" fill=\"#888\">Built so far (each is now a single block you can reuse):</text>`;
 L.forEach((q,i)=>{if(i<lvl||(i==lvl&&outp>0.9)){const w=q.out.length*8+24;s+=`<rect x=\"${sx}\" y=\"328\" width=\"${w}\" height=\"30\" rx=\"8\" fill=\"${q.c}\"/><text x=\"${sx+w/2}\" y=\"348\" text-anchor=\"middle\" font-size=\"12\" fill=\"#fff\">${q.out}</text>`;sx+=w+6}});
 svg.innerHTML=s}
function tick(now){const dt=Math.min(0.05,(now-last)/1000);last=now;
 if(playing){if(t<1){t+=dt/DUR;if(t>=1){t=1;hold=0}}else{hold+=dt;if(hold>1.2){if(lvl<TR[track].length-1){lvl++;t=0;crumbs();note()}else{hold=-99}}}}
 draw();requestAnimationFrame(tick)}
function setTrack(k){track=k;lvl=0;t=0;hold=0;$('hw').classList.toggle('on',k=='hw');$('sw').classList.toggle('on',k=='sw');crumbs();note()}
$('hw').onclick=()=>setTrack('hw');$('sw').onclick=()=>setTrack('sw');
$('play').onclick=()=>{playing=!playing;$('play').textContent=playing?'⏸ Pause':'▶ Play'};
$('step').onclick=()=>{if(t<1){t=1}else if(lvl<TR[track].length-1){lvl++;t=0;hold=0;crumbs();note()}};
$('reset').onclick=()=>setTrack(track);
setTrack('hw');requestAnimationFrame(tick);
</script></body></html>"
 :AT "2026-11-14T22:48:27" :VERSION 1)
(:PINNED T :ID "isa-opcode-and-operand-fields" :MAP "computers" :NODE "instruction-set" :TYPE
 "html" :TITLE "ISA: opcode and operand fields" :LANGUAGE NIL :CONTENT
 "<!DOCTYPE html><html><head><meta charset=\"utf-8\"><style>
body{font-family:system-ui,sans-serif;margin:0;padding:16px;background:#fafafa;color:#222;max-width:860px}
h2{margin:0 0 4px;font-size:19px}h3{margin:0 0 6px;font-size:14px}
p.s{margin:0 0 12px;color:#444;font-size:14px;line-height:1.45}
.row{display:flex;gap:12px;flex-wrap:wrap;align-items:end;margin-bottom:12px}
label{font-size:12px;color:#555;display:flex;flex-direction:column;gap:2px}
select,input{font-size:14px;padding:4px 6px;border:1px solid #bbb;border-radius:6px;font-family:monospace}
input[type=number]{width:70px}
.box{background:#fff;border:1px solid #ddd;border-radius:10px;padding:10px 14px;margin-bottom:10px;font-size:14px;line-height:1.45}
code{font-family:monospace;background:#eee;padding:1px 5px;border-radius:4px}
table{border-collapse:collapse;font-family:monospace;font-size:13px}td,th{border:1px solid #ddd;padding:2px 8px}
.ch{background:#ffe9a8}.bad{color:#c00}
.grid{display:grid;grid-template-columns:repeat(16,1fr);gap:0;text-align:center;font-family:monospace}
.num{font-size:11px;color:#888;padding-bottom:2px}
.bit{font-size:20px;padding:8px 0;border-top:2px solid;border-bottom:2px solid;border-left:1px solid rgba(0,0,0,.08)}
.bit.first{border-left:2px solid;border-radius:8px 0 0 8px}.bit.last{border-right:2px solid;border-radius:0 8px 8px 0}
.lab{font-family:system-ui,sans-serif;font-size:12px;font-weight:600;padding:4px 2px;border-bottom:3px solid;margin-top:4px;line-height:1.3}
.lab small{display:block;font-weight:400;color:#444;font-size:11px}
.hexrow .h{grid-column:span 4;font-size:15px;color:#555;border-left:1px dashed #bbb;padding:2px 0}
.op{background:#fde2e2;border-color:#e05555}.rd{background:#dff0ff;border-color:#4a90d9}.rs{background:#e1f5e1;border-color:#4caf50}
.imm{background:#fff2cc;border-color:#d9a400}.un{background:#eee;border-color:#bbb;color:#888}
.key{display:flex;gap:10px;flex-wrap:wrap;font-size:12px;margin:4px 0 10px}
.key span{padding:2px 8px;border-radius:10px;border:2px solid}
ol{margin:4px 0 0 18px;padding:0}li{margin:3px 0}
</style></head><body>
<h2>One instruction = one 16-bit word</h2>
<p class=\"s\">A 16-bit word is 16 switches, each 0 or 1. The hardware has no idea what they \"mean\" until we agree to <b>cut the 16 bits into fields</b>: the leftmost 4 bits name the operation, and the rest say which registers (or which constant) to use. Pick an instruction below and watch the same 16 bits get colored into fields.</p>
<div class=\"row\">
<label>Operation<select id=\"op\"></select></label>
<label id=\"Lrd\">rd (destination register, 0–7)<input type=\"number\" id=\"rd\" min=\"0\" max=\"7\" value=\"3\"></label>
<label id=\"Lrs1\">rs1 (first source register)<input type=\"number\" id=\"rs1\" min=\"0\" max=\"7\" value=\"1\"></label>
<label id=\"Lrs2\">rs2 (second source register)<input type=\"number\" id=\"rs2\" min=\"0\" max=\"7\" value=\"2\"></label>
<label id=\"Limm\">constant (0–511)<input type=\"number\" id=\"imm\" min=\"0\" max=\"511\" value=\"42\"></label>
<label>…or type the word in hex<input id=\"hex\" size=\"7\" value=\"0x1650\"></label>
</div>

<div class=\"box\">
<h3>The 16 bits (bit 15 is leftmost, bit 0 rightmost)</h3>
<div class=\"grid\" id=\"nums\"></div>
<div class=\"grid\" id=\"bits\"></div>
<div class=\"grid\" id=\"labs\"></div>
<div class=\"grid hexrow\" id=\"hexrow\" style=\"margin-top:8px\"></div>
<div style=\"font-size:11px;color:#888;margin-top:2px\">Each group of 4 bits is one hex digit, so the whole word is written as 4 hex digits.</div>
</div>

<div class=\"box\" id=\"why\"></div>
<div class=\"box\" id=\"asm\"></div>
<div class=\"box\"><b>Execute</b> on a sample machine: r0…r7 = 0, 5, 7, 3, 0, 0, 0, 0 and memory address a holds a×10. Changed registers are highlighted.<div id=\"exe\"></div></div>
<div class=\"box\" style=\"font-size:13px;color:#555\">Fetch: the 16-bit word is read from memory (to memory it is just data). Decode: the top 4 bits pick the operation, the other fields pick registers or a constant. Execute: the ALU or memory does it. Try <code>0xFFFF</code>: no operation numbered 15 exists, so the hardware has no meaning for it. The ISA is exactly the list of patterns that <i>do</i> have a meaning.</div>
<script>
const OPS=[{n:'ADD',c:1,f:'R',d:'rd ← rs1 + rs2'},{n:'SUB',c:2,f:'R',d:'rd ← rs1 − rs2'},{n:'AND',c:3,f:'R',d:'rd ← rs1 AND rs2'},
{n:'LOADI',c:4,f:'I',d:'rd ← constant'},{n:'LOAD',c:5,f:'L',d:'rd ← mem[rs1]'},{n:'STORE',c:6,f:'S',d:'mem[rs1] ← rs2'}];
const $=id=>document.getElementById(id);
OPS.forEach((o,i)=>$('op').add(new Option(o.n,i)));$('op').value=0;
// [name,length,class,plain role]
const LAY={R:[['op',4,'op','operation'],['rd',3,'rd','result goes here'],['rs1',3,'rs','first input'],['rs2',3,'rs','second input'],['unused',3,'un','ignored']],
I:[['op',4,'op','operation'],['rd',3,'rd','result goes here'],['constant',9,'imm','the number itself']],
L:[['op',4,'op','operation'],['rd',3,'rd','result goes here'],['rs1',3,'rs','holds the address'],['unused',6,'un','ignored']],
S:[['op',4,'op','operation'],['unused',3,'un','ignored'],['rs1',3,'rs','holds the address'],['rs2',3,'rs','value to store'],['unused',3,'un','ignored']]};
const USES={R:['rd','rs1','rs2'],I:['rd','imm'],L:['rd','rs1'],S:['rs1','rs2']};
function val(id){return Math.max(0,Math.min(id=='imm'?511:7,parseInt($(id).value)||0))}
function encode(){const o=OPS[$('op').value],r=val('rd'),a=val('rs1'),b=val('rs2'),m=val('imm');
 if(o.f=='R')return o.c<<12|r<<9|a<<6|b<<3; if(o.f=='I')return o.c<<12|r<<9|m;
 if(o.f=='L')return o.c<<12|r<<9|a<<6; return o.c<<12|a<<6|b<<3}
function render(w){
 const code=w>>12,o=OPS.find(x=>x.c==code),bin=w.toString(2).padStart(16,'0'),hx=w.toString(16).padStart(4,'0').toUpperCase();
 $('nums').innerHTML=[...Array(16)].map((_,i)=>'<div class=\"num\">'+(15-i)+'</div>').join('');
 $('hexrow').innerHTML=[...hx].map(c=>'<div class=\"h\">'+c+'</div>').join('');
 $('labs').innerHTML='';$('why').innerHTML='';
 if(!o){$('bits').innerHTML=[...bin].map((b,i)=>'<div class=\"bit un'+(i==0?' first':'')+(i==15?' last':'')+'\">'+b+'</div>').join('');
  $('labs').innerHTML='<div class=\"lab bad\" style=\"grid-column:span 16;border-color:#c00\">top 4 bits = '+bin.slice(0,4)+' = operation '+code+': not in the ISA, so this is an illegal instruction</div>';
  $('asm').innerHTML='Hex <code>0x'+hx+'</code> → <span class=\"bad\">no defined meaning</span>';$('exe').innerHTML='';return}
 const L=LAY[o.f];let pos=0,bh='',lh='',steps=[];
 const rd=(w>>9)&7,a=(w>>6)&7,b=(w>>3)&7,m=w&511;
 L.forEach(([n,len,cl,role])=>{
  const hi=15-pos,lo=hi-len+1,v=(w>>lo)&((1<<len)-1);
  for(let i=0;i<len;i++)bh+='<div class=\"bit '+cl+(i==0?' first':'')+(i==len-1?' last':'')+'\">'+bin[pos+i]+'</div>';
  const range=len==1?'bit '+hi:'bits '+hi+' to '+lo;
  lh+='<div class=\"lab '+cl+'\" style=\"grid-column:span '+len+';background:none\">'+n+(cl=='un'?'':' = '+v)+'<small>'+range+'<br>'+role+'</small></div>';
  if(cl!='un'){let t;
   if(n=='op')t=`<b>${range}</b> are <code>${bin.slice(pos,pos+len)}</code> = ${v}. The ISA says operation ${v} is <b>${o.n}</b>.`;
   else if(n=='constant')t=`<b>${range}</b> are <code>${bin.slice(pos,pos+len)}</code> = ${v}: the constant ${v}, stored directly in the instruction.`;
   else t=`<b>${range}</b> are <code>${bin.slice(pos,pos+len)}</code> = ${v}: register <b>r${v}</b> (${role}).`;
   steps.push(t)}
  pos+=len});
 $('bits').innerHTML=bh;$('labs').innerHTML=lh;
 const un=L.some(x=>x[2]=='un');
 $('why').innerHTML='<h3>How the hardware reads this word, field by field</h3><ol>'+steps.map(s=>'<li>'+s+'</li>').join('')+'</ol>'+(un?'<div style=\"font-size:12px;color:#666;margin-top:6px\">Grey bits are unused by this operation: the hardware never looks at them, and the assembler just writes 0s. Fields are narrow because each only has to count to what it names: 3 bits = 8 registers (0–7), 4 bits = up to 16 operations, 9 bits = constants up to 511.</div>':'<div style=\"font-size:12px;color:#666;margin-top:6px\">Fields are narrow because each only has to count to what it names: 3 bits = 8 registers (0–7), 4 bits = up to 16 operations, 9 bits = constants up to 511.</div>');
 let t;if(o.f=='R')t=`${o.n} r${rd}, r${a}, r${b}`;else if(o.f=='I')t=`LOADI r${rd}, ${m}`;else if(o.f=='L')t=`LOAD r${rd}, [r${a}]`;else t=`STORE [r${a}], r${b}`;
 $('asm').innerHTML=`Hex <code>0x${hx}</code> = assembly <code>${t}</code> &nbsp;·&nbsp; meaning: <b>${o.d}</b>`;
 const R=[0,5,7,3,0,0,0,0],R2=R.slice(),mem=x=>(x&511)*10;let s='';
 if(o.n=='ADD'){R2[rd]=(R[a]+R[b])&0xFFFF;s=`r${rd} ← r${a} + r${b} = ${R[a]} + ${R[b]} = ${R2[rd]}`}
 if(o.n=='SUB'){R2[rd]=(R[a]-R[b])&0xFFFF;s=`r${rd} ← r${a} − r${b} = ${R[a]} − ${R[b]} = ${R2[rd]} (negatives wrap around in 16 bits)`}
 if(o.n=='AND'){R2[rd]=R[a]&R[b];s=`r${rd} ← r${a} AND r${b} = ${R[a]} AND ${R[b]} = ${R2[rd]}`}
 if(o.n=='LOADI'){R2[rd]=m;s=`r${rd} ← ${m}`}
 if(o.n=='LOAD'){R2[rd]=mem(R[a]);s=`r${a} holds ${R[a]}, so r${rd} ← mem[${R[a]}] = ${R2[rd]}`}
 if(o.n=='STORE'){s=`r${a} holds ${R[a]}, r${b} holds ${R[b]}, so mem[${R[a]}] ← ${R[b]} (memory changes, registers do not)`}
 $('exe').innerHTML=`<p>${s}</p><table><tr>${R.map((_,i)=>'<th>r'+i+'</th>').join('')}</tr><tr>${R2.map((v,i)=>'<td class=\"'+(v!=R[i]?'ch':'')+'\">'+v+'</td>').join('')}</tr></table>`;
}
function sync(w){const o=OPS.find(x=>x.c==(w>>12));if(!o)return;$('op').value=OPS.indexOf(o);$('rd').value=(w>>9)&7;$('rs1').value=(w>>6)&7;$('rs2').value=(w>>3)&7;$('imm').value=w&511}
function vis(){const o=OPS[$('op').value];['rd','rs1','rs2','imm'].forEach(k=>$('L'+k).style.display=USES[o.f].includes(k)?'flex':'none')}
function fromControls(){vis();const w=encode();$('hex').value='0x'+w.toString(16).padStart(4,'0');render(w)}
['op','rd','rs1','rs2','imm'].forEach(i=>$(i).addEventListener('input',fromControls));
$('hex').addEventListener('input',()=>{const w=parseInt($('hex').value,16);if(isNaN(w))return;const x=w&0xFFFF;sync(x);vis();render(x)});
fromControls();
</script></body></html>
"
 :AT "2026-11-14T22:51:15" :VERSION 2)
(:PINNED T :ID "register-vs-sram-cache-vs-dram" :MAP "computers" :NODE "caches" :TYPE "svg" :TITLE
 "Register vs SRAM cache vs DRAM" :LANGUAGE NIL :CONTENT
 "<svg viewBox=\"0 0 1200 760\" xmlns=\"http://www.w3.org/2000/svg\" font-family=\"system-ui, sans-serif\">
<rect width=\"1200\" height=\"760\" fill=\"#fafafa\"/>
<text x=\"600\" y=\"38\" font-size=\"22\" font-weight=\"700\" text-anchor=\"middle\" fill=\"#222\">Same job, three designs: register, cache, RAM</text>

<!-- panel titles -->
<g font-size=\"18\" font-weight=\"700\" text-anchor=\"middle\">
<text x=\"200\" y=\"85\" fill=\"#1d4ed8\">Register file</text>
<text x=\"600\" y=\"85\" fill=\"#047857\">Cache (SRAM + tags)</text>
<text x=\"1000\" y=\"85\" fill=\"#b45309\">Main RAM (DRAM)</text>
</g>
<g stroke=\"#ccc\" stroke-dasharray=\"4 4\"><line x1=\"400\" y1=\"60\" x2=\"400\" y2=\"730\"/><line x1=\"800\" y1=\"60\" x2=\"800\" y2=\"730\"/></g>

<!-- ===== REGISTER ===== -->
<g>
<text x=\"200\" y=\"115\" font-size=\"13\" text-anchor=\"middle\" fill=\"#444\">Cell: latch/flip-flop, many ports (6–10+ T)</text>
<rect x=\"110\" y=\"130\" width=\"180\" height=\"90\" rx=\"6\" fill=\"#dbeafe\" stroke=\"#1d4ed8\" stroke-width=\"2\"/>
<text x=\"200\" y=\"152\" font-size=\"12\" text-anchor=\"middle\" fill=\"#1d4ed8\">one bit cell</text>
<circle cx=\"170\" cy=\"190\" r=\"14\" fill=\"#fff\" stroke=\"#1d4ed8\"/><circle cx=\"230\" cy=\"190\" r=\"14\" fill=\"#fff\" stroke=\"#1d4ed8\"/>
<path d=\"M184 190h32\" stroke=\"#1d4ed8\" stroke-width=\"2\"/>
<text x=\"200\" y=\"168\" font-size=\"12\" text-anchor=\"middle\" fill=\"#1d4ed8\">latch loop</text>
<!-- ports -->
<g stroke=\"#1d4ed8\" stroke-width=\"2\"><line x1=\"60\" y1=\"150\" x2=\"110\" y2=\"150\"/><line x1=\"60\" y1=\"175\" x2=\"110\" y2=\"175\"/><line x1=\"290\" y1=\"150\" x2=\"340\" y2=\"150\"/><line x1=\"290\" y1=\"175\" x2=\"340\" y2=\"175\"/></g>
<text x=\"60\" y=\"144\" font-size=\"11\" fill=\"#444\">read A</text><text x=\"60\" y=\"193\" font-size=\"11\" fill=\"#444\">read B</text>
<text x=\"300\" y=\"144\" font-size=\"11\" fill=\"#444\">write</text>

<!-- datapath -->
<text x=\"200\" y=\"260\" font-size=\"13\" text-anchor=\"middle\" fill=\"#444\">Instruction bits pick the register directly</text>
<rect x=\"60\" y=\"275\" width=\"120\" height=\"40\" rx=\"5\" fill=\"#fff\" stroke=\"#1d4ed8\"/><text x=\"120\" y=\"300\" font-size=\"13\" text-anchor=\"middle\">instr: rs, rt</text>
<rect x=\"220\" y=\"275\" width=\"120\" height=\"40\" rx=\"5\" fill=\"#fff\" stroke=\"#1d4ed8\"/><text x=\"280\" y=\"300\" font-size=\"13\" text-anchor=\"middle\">small mux</text>
<path d=\"M180 295h40\" stroke=\"#1d4ed8\" stroke-width=\"2\"/>
<path d=\"M280 315v40\" stroke=\"#1d4ed8\" stroke-width=\"2\"/>
<path d=\"M240 355h80l-20 50h-40z\" fill=\"#1d4ed8\"/><text x=\"280\" y=\"385\" font-size=\"14\" text-anchor=\"middle\" fill=\"#fff\">ALU</text>
<text x=\"200\" y=\"440\" font-size=\"13\" text-anchor=\"middle\" fill=\"#444\">No tags, no search. Wired into the ALU.</text>
</g>

<!-- ===== CACHE ===== -->
<g>
<text x=\"600\" y=\"115\" font-size=\"13\" text-anchor=\"middle\" fill=\"#444\">Cell: 6T SRAM (two cross-coupled inverters)</text>
<rect x=\"520\" y=\"130\" width=\"160\" height=\"90\" rx=\"6\" fill=\"#d1fae5\" stroke=\"#047857\" stroke-width=\"2\"/>
<circle cx=\"565\" cy=\"175\" r=\"14\" fill=\"#fff\" stroke=\"#047857\"/><circle cx=\"635\" cy=\"175\" r=\"14\" fill=\"#fff\" stroke=\"#047857\"/>
<path d=\"M579 168h42M621 182h-42\" stroke=\"#047857\" stroke-width=\"2\"/>
<text x=\"600\" y=\"150\" font-size=\"12\" text-anchor=\"middle\" fill=\"#047857\">bistable loop</text>
<text x=\"600\" y=\"212\" font-size=\"11\" text-anchor=\"middle\" fill=\"#047857\">+2 access T, bit lines</text>

<text x=\"600\" y=\"255\" font-size=\"13\" text-anchor=\"middle\" fill=\"#444\">Array plus \"do I hold this address?\" logic</text>
<rect x=\"430\" y=\"270\" width=\"340\" height=\"36\" rx=\"4\" fill=\"#fff\" stroke=\"#047857\"/>
<text x=\"470\" y=\"293\" font-size=\"13\" text-anchor=\"middle\">tag</text><text x=\"590\" y=\"293\" font-size=\"13\" text-anchor=\"middle\">index</text><text x=\"720\" y=\"293\" font-size=\"13\" text-anchor=\"middle\">offset</text>
<line x1=\"510\" y1=\"270\" x2=\"510\" y2=\"306\" stroke=\"#047857\"/><line x1=\"670\" y1=\"270\" x2=\"670\" y2=\"306\" stroke=\"#047857\"/>
<!-- sets -->
<g font-size=\"11\" text-anchor=\"middle\">
<rect x=\"430\" y=\"330\" width=\"40\" height=\"26\" fill=\"#fde68a\" stroke=\"#047857\"/><text x=\"450\" y=\"347\">V D</text>
<rect x=\"470\" y=\"330\" width=\"80\" height=\"26\" fill=\"#a7f3d0\" stroke=\"#047857\"/><text x=\"510\" y=\"347\">tag</text>
<rect x=\"550\" y=\"330\" width=\"220\" height=\"26\" fill=\"#d1fae5\" stroke=\"#047857\"/><text x=\"660\" y=\"347\">data block (SRAM)</text>
<rect x=\"430\" y=\"356\" width=\"40\" height=\"26\" fill=\"#fde68a\" stroke=\"#047857\"/><text x=\"450\" y=\"373\">V D</text>
<rect x=\"470\" y=\"356\" width=\"80\" height=\"26\" fill=\"#a7f3d0\" stroke=\"#047857\"/><text x=\"510\" y=\"373\">tag</text>
<rect x=\"550\" y=\"356\" width=\"220\" height=\"26\" fill=\"#d1fae5\" stroke=\"#047857\"/><text x=\"660\" y=\"373\">data block (SRAM)</text>
</g>
<circle cx=\"500\" cy=\"410\" r=\"14\" fill=\"#fff\" stroke=\"#047857\" stroke-width=\"2\"/><text x=\"500\" y=\"415\" font-size=\"14\" text-anchor=\"middle\">=</text>
<text x=\"545\" y=\"415\" font-size=\"12\" fill=\"#444\">tag compare → hit/miss</text>
<path d=\"M510 382v14\" stroke=\"#047857\" stroke-width=\"2\"/>
<text x=\"600\" y=\"450\" font-size=\"13\" text-anchor=\"middle\" fill=\"#444\">Plus mux, LRU, dirty bits, coherence</text>
</g>

<!-- ===== DRAM ===== -->
<g>
<text x=\"1000\" y=\"115\" font-size=\"13\" text-anchor=\"middle\" fill=\"#444\">Cell: 1 transistor + 1 capacitor</text>
<rect x=\"920\" y=\"130\" width=\"160\" height=\"90\" rx=\"6\" fill=\"#fef3c7\" stroke=\"#b45309\" stroke-width=\"2\"/>
<line x1=\"940\" y1=\"145\" x2=\"940\" y2=\"210\" stroke=\"#b45309\" stroke-width=\"3\"/>
<text x=\"936\" y=\"140\" font-size=\"11\" text-anchor=\"end\" fill=\"#b45309\">bit line</text>
<rect x=\"940\" y=\"165\" width=\"40\" height=\"22\" fill=\"#fff\" stroke=\"#b45309\"/><text x=\"960\" y=\"180\" font-size=\"11\" text-anchor=\"middle\">T</text>
<line x1=\"980\" y1=\"176\" x2=\"1010\" y2=\"176\" stroke=\"#b45309\" stroke-width=\"2\"/>
<line x1=\"1010\" y1=\"160\" x2=\"1010\" y2=\"192\" stroke=\"#b45309\" stroke-width=\"3\"/><line x1=\"1022\" y1=\"160\" x2=\"1022\" y2=\"192\" stroke=\"#b45309\" stroke-width=\"3\"/>
<text x=\"1050\" y=\"180\" font-size=\"11\" fill=\"#b45309\">C</text>
<text x=\"1000\" y=\"210\" font-size=\"11\" text-anchor=\"middle\" fill=\"#b45309\">charge leaks → refresh</text>

<text x=\"1000\" y=\"255\" font-size=\"13\" text-anchor=\"middle\" fill=\"#444\">Pure address → data grid, no tags</text>
<g fill=\"#fde68a\" stroke=\"#b45309\">
<rect x=\"860\" y=\"270\" width=\"280\" height=\"14\"/><rect x=\"860\" y=\"288\" width=\"280\" height=\"14\"/><rect x=\"860\" y=\"306\" width=\"280\" height=\"14\"/><rect x=\"860\" y=\"324\" width=\"280\" height=\"14\"/>
</g>
<text x=\"850\" y=\"298\" font-size=\"11\" text-anchor=\"end\" fill=\"#444\">row decoder</text>
<rect x=\"860\" y=\"350\" width=\"280\" height=\"22\" fill=\"#b45309\"/><text x=\"1000\" y=\"366\" font-size=\"12\" text-anchor=\"middle\" fill=\"#fff\">sense amps = row buffer</text>
<path d=\"M1000 338v12\" stroke=\"#b45309\" stroke-width=\"2\"/>
<text x=\"1000\" y=\"395\" font-size=\"12\" text-anchor=\"middle\" fill=\"#444\">column decoder picks bits</text>
<text x=\"1000\" y=\"425\" font-size=\"12\" text-anchor=\"middle\" fill=\"#444\">Read is destructive: sense, then restore</text>
<text x=\"1000\" y=\"450\" font-size=\"13\" text-anchor=\"middle\" fill=\"#444\">Off-chip, via memory controller + bus</text>
</g>

<!-- comparison table -->
<g font-size=\"14\" text-anchor=\"middle\">
<rect x=\"40\" y=\"490\" width=\"1120\" height=\"240\" rx=\"8\" fill=\"#fff\" stroke=\"#bbb\"/>
<g font-weight=\"700\"><text x=\"110\" y=\"518\" text-anchor=\"start\">Property</text><text x=\"400\" y=\"518\" fill=\"#1d4ed8\">Register</text><text x=\"680\" y=\"518\" fill=\"#047857\">Cache</text><text x=\"960\" y=\"518\" fill=\"#b45309\">RAM</text></g>
<line x1=\"60\" y1=\"528\" x2=\"1140\" y2=\"528\" stroke=\"#ddd\"/>
<text x=\"60\" y=\"556\" text-anchor=\"start\">Transistors / bit</text><text x=\"400\" y=\"556\">6–10+</text><text x=\"680\" y=\"556\">6</text><text x=\"960\" y=\"556\">1 + capacitor</text>
<text x=\"60\" y=\"590\" text-anchor=\"start\">Addressing</text><text x=\"400\" y=\"590\">instr bits → mux</text><text x=\"680\" y=\"590\">tag compare</text><text x=\"960\" y=\"590\">row/column decode</text>
<text x=\"60\" y=\"624\" text-anchor=\"start\">Refresh needed</text><text x=\"400\" y=\"624\">no</text><text x=\"680\" y=\"624\">no</text><text x=\"960\" y=\"624\">yes</text>
<text x=\"60\" y=\"658\" text-anchor=\"start\">Typical size</text><text x=\"400\" y=\"658\">hundreds of bits–KB</text><text x=\"680\" y=\"658\">KB–tens of MB</text><text x=\"960\" y=\"658\">GB</text>
<text x=\"60\" y=\"692\" text-anchor=\"start\">Latency</text><text x=\"400\" y=\"692\">under 1 ns</text><text x=\"680\" y=\"692\">1–20 ns</text><text x=\"960\" y=\"692\">60–100 ns</text>
<text x=\"60\" y=\"720\" text-anchor=\"start\">Location</text><text x=\"400\" y=\"720\">in the datapath</text><text x=\"680\" y=\"720\">on the CPU die</text><text x=\"960\" y=\"720\">separate chips</text>
</g>
</svg>"
 :AT "2026-11-14T23:07:33" :VERSION 1)
(:PINNED T :ID "symbolic-search-vs-neural-network" :MAP "computers" :NODE "symbolic-reasoning"
 :TYPE "html" :TITLE "Symbolic search vs neural network" :LANGUAGE NIL :CONTENT
 "<!DOCTYPE html><html><head><meta charset=\"utf-8\"><meta name=\"viewport\" content=\"width=device-width,initial-scale=1\">
<style>
body{font-family:system-ui,sans-serif;margin:0;padding:14px;background:#fafaf7;color:#222;max-width:820px;margin:auto}
h2{font-size:18px;margin:4px 0 8px}
.tabs button,.ctl button{padding:7px 12px;border:1px solid #888;background:#fff;border-radius:6px;cursor:pointer;font-size:14px;margin:2px}
.tabs button.on{background:#222;color:#fff}
.box{background:#fff;border:1px solid #ddd;border-radius:8px;padding:10px;margin:10px 0}
canvas{max-width:100%;border:1px solid #eee;border-radius:6px;background:#fff}
.stat{font-family:monospace;font-size:14px;margin:6px 0}
.ok{color:#127a3a;font-weight:600}.bad{color:#b3261e;font-weight:600}
.row{display:flex;gap:10px;flex-wrap:wrap;justify-content:center}
.cap{font-size:13px;text-align:center;color:#555}
small{color:#555}
pre{background:#f3f1ea;padding:8px;border-radius:6px;font-size:13px;white-space:pre-wrap;margin:6px 0}
</style></head><body>
<h2>Axioms and search vs. learned probabilities</h2>
<div class=\"tabs\"><button id=\"t1\" class=\"on\" onclick=\"tab(1)\">1. Symbolic reasoning</button><button id=\"t2\" onclick=\"tab(2)\">2. Neural network</button></div>

<div id=\"p1\">
<div class=\"box\">
<b>Task:</b> given axioms (hand-written rules) and a start fact, <i>prove the goal</i> by searching chains of rule applications. Each node is a fact; each branch is a rule that could fire next.
<div class=\"ctl\"><button onclick=\"runTree('small')\">▶ Small, tidy domain</button><button onclick=\"runTree('big')\">▶ Bigger domain</button></div>
<canvas id=\"tree\" width=\"560\" height=\"560\"></canvas>
<div class=\"stat\" id=\"tstat\">Press a button.</div>
<div id=\"tmsg\"></div>
</div>
<div class=\"box\">
<b>Second wall: brittleness.</b> Real input has exceptions the author didn't foresee.
<div class=\"ctl\"><button onclick=\"exc()\">Add real-world input</button></div>
<pre id=\"excp\">Rule 1: bird(x) → flies(x)
Fact:   penguin(Tweety), penguin(x) → bird(x)</pre>
<div id=\"excm\" class=\"stat\"></div>
</div>
</div>

<div id=\"p2\" style=\"display:none\">
<div class=\"box\">
<b>Task:</b> label points as A (orange) or B (blue). The truth is a circle in the middle, but the labels are never written as a rule. The network only sees example points.
<div class=\"ctl\">Training examples: <button onclick=\"setN(10)\">10</button><button onclick=\"setN(60)\">60</button><button onclick=\"setN(400)\">400</button><button onclick=\"setN(3000)\">3000</button> <button onclick=\"train()\">▶ Train</button></div>
<div class=\"row\">
<div><canvas id=\"rule\" width=\"260\" height=\"260\"></canvas><div class=\"cap\">Hand-written axiom:<br>\"if x &gt; 0.5 then A\"<br><span id=\"racc\"></span></div></div>
<div><canvas id=\"nn\" width=\"260\" height=\"260\"></canvas><div class=\"cap\">Neural net: probability of A<br><span id=\"nacc\">untrained</span></div></div>
</div>
<div class=\"stat\" id=\"nstat\"></div>
<small>Click the right map to read the network's probability at that point. Colour strength = confidence; white = unsure.</small>
</div>
</div>

<div class=\"box\"><b>The contrast</b>
<table style=\"font-size:14px;border-collapse:collapse;width:100%\">
<tr><td></td><td><b>Symbolic</b></td><td><b>Neural</b></td></tr>
<tr><td>Knowledge comes from</td><td>people writing axioms</td><td>examples (data)</td></tr>
<tr><td>Answer</td><td>proved, or nothing</td><td>probability, can be wrong</td></tr>
<tr><td>Fails when</td><td>search explodes, exceptions appear</td><td>too little or biased data</td></tr>
</table></div>

<script>
function tab(n){for(let i=1;i<=2;i++){document.getElementById('p'+i).style.display=i==n?'':'none';document.getElementById('t'+i).className=i==n?'on':''}if(n==2)drawNN()}

/* ---------- symbolic tree ---------- */
const tc=document.getElementById('tree'),tx=tc.getContext('2d');
let anim=null;
function runTree(kind){
 if(anim)cancelAnimationFrame(anim);
 const cfg=kind=='small'?{b:2,d:3,goal:5,budget:1e9,rate:0.07,rules:6}:{b:4,d:6,goal:3000,budget:1200,rate:6,rules:'thousands'};
 const {b,d}=cfg;
 // BFS-ordered nodes
 const nodes=[];let off=[0];
 for(let l=0;l<=d;l++){const n=Math.pow(b,l);for(let i=0;i<n;i++)nodes.push({l,i});off[l+1]=off[l]+n}
 const R=255,step=R/d,cx=280,cy=280;
 nodes.forEach(n=>{const cnt=Math.pow(b,n.l);const a=2*Math.PI*(n.i+.5)/cnt;n.x=cx+Math.cos(a)*n.l*step;n.y=cy+Math.sin(a)*n.l*step;if(n.l==0){n.x=cx;n.y=cy}});
 const par=k=>{const n=nodes[k];return n.l==0?-1:off[n.l-1]+Math.floor(n.i/b)};
 const goalK=off[d]+cfg.goal%Math.pow(b,d);
 let shown=0,done=false,found=false,fail=false;
 const total=nodes.length;
 document.getElementById('tmsg').innerHTML='';
 function draw(){
  tx.clearRect(0,0,560,560);
  const dot=kind=='small'?6:2;
  for(let k=1;k<shown;k++){const p=nodes[par(k)],n=nodes[k];tx.strokeStyle='rgba(120,120,140,'+(kind=='small'?.6:.25)+')';tx.beginPath();tx.moveTo(p.x,p.y);tx.lineTo(n.x,n.y);tx.stroke()}
  for(let k=0;k<shown;k++){const n=nodes[k];tx.fillStyle=k==0?'#222':'#4a6fd6';tx.beginPath();tx.arc(n.x,n.y,k==0?7:dot,0,7);tx.fill()}
  // goal marker
  const g=nodes[goalK];tx.strokeStyle='#127a3a';tx.lineWidth=2;tx.beginPath();tx.arc(g.x,g.y,10,0,7);tx.stroke();tx.fillStyle='#127a3a';tx.font='13px sans-serif';tx.fillText('GOAL',Math.min(g.x+12,520),g.y+4);tx.lineWidth=1;
  tx.fillStyle='#222';tx.fillText('start fact',cx-24,cy-12);
  if(found){let k=goalK;tx.strokeStyle='#127a3a';tx.lineWidth=4;while(par(k)>=0){const p=nodes[par(k)],n=nodes[k];tx.beginPath();tx.moveTo(p.x,p.y);tx.lineTo(n.x,n.y);tx.stroke();k=par(k)}tx.lineWidth=1}
 }
 function tick(){
  if(!done){
   shown=Math.min(total,shown+(kind=='small'?cfg.rate*1:cfg.rate*(1+shown/120)));
   shown=Math.floor(shown)||shown;
   if(kind=='small'){window._f=(window._f||0)+cfg.rate;shown=Math.min(total,Math.floor(window._f)+1)}
   if(shown>goalK&&kind=='small'){shown=goalK+1;found=true;done=true}
   if(shown>=cfg.budget){shown=cfg.budget;fail=true;done=true}
  }
  draw();
  document.getElementById('tstat').innerHTML='Nodes searched: '+Math.floor(shown).toLocaleString()+' &nbsp;|&nbsp; branching '+b+', depth '+d+' → '+total.toLocaleString()+' nodes in full tree &nbsp;|&nbsp; rules hand-written: '+cfg.rules;
  if(found)document.getElementById('tmsg').innerHTML='<span class=\"ok\">Proof found after '+Math.floor(shown)+' nodes.</span> Small domain: the chain of rules from start to goal is the green path, and the result is certain given the axioms.';
  if(fail)document.getElementById('tmsg').innerHTML='<span class=\"bad\">Budget exhausted before reaching the goal.</span> Each extra level multiplies the work by '+b+'. Real domains have far more rules per step (say 30 at depth 20 ≈ 10<sup>29</sup> nodes), and someone would have had to write all those rules. Heuristics prune, but only where a person knew what to prune.';
  if(!done)anim=requestAnimationFrame(tick);else draw();
 }
 window._f=0;
 tick();
}
tx.fillStyle='#888';tx.font='15px sans-serif';tx.fillText('Pick a domain size to see the search',150,285);

let ne=0;
const steps=[
 ['Rule 1: bird(x) → flies(x)\\nFact:   penguin(Tweety), penguin(x) → bird(x)\\n⇒ flies(Tweety)   ✗ wrong, with full logical certainty','Fix needed: add \"unless penguin\".'],
 ['Rule 1: bird(x) ∧ ¬penguin(x) → flies(x)\\nFact:   ostrich(Sam), ostrich(x) → bird(x)\\n⇒ flies(Sam)   ✗ wrong again','Fix needed: add \"unless ostrich\".'],
 ['Rule 1: bird(x) ∧ ¬penguin ∧ ¬ostrich → flies(x)\\nFact:   bird(Polly), wing_broken(Polly)\\n⇒ flies(Polly)   ✗ wrong again','Fix needed: broken wing, dead, caged, chick, painted on a wall...'],
 ['Rule 1: bird(x) ∧ ¬penguin ∧ ¬ostrich ∧ ¬broken ∧ ¬dead ∧ ¬caged ...\\nInput: \"the bird in the picture\"\\n⇒ no symbol bird(x) was produced from pixels. No answer.','Rules cannot read ambiguous input. Exceptions never end.']];
function exc(){const s=steps[Math.min(ne,steps.length-1)];ne++;document.getElementById('excp').textContent=s[0];document.getElementById('excm').innerHTML='<span class=\"bad\">'+s[1]+'</span> Exceptions patched by hand: '+(ne-1)}

/* ---------- neural net ---------- */
const truth=(x,y)=>(x-.5)**2+(y-.5)**2<0.09?1:0;
const H=12;let N=60,net,data=[],timer=null,epoch=0;
const rule=document.getElementById('rule').getContext('2d'),nnc=document.getElementById('nn'),nx=nnc.getContext('2d');
function rnd(){return Math.random()*2-1}
function init(){net={W1:Array.from({length:H},()=>[rnd(),rnd()]),b1:Array(H).fill(0),W2:Array.from({length:H},()=>Array.from({length:H},()=>rnd()*.5)),b2:Array(H).fill(0),W3:Array.from({length:H},()=>rnd()*.5),b3:0}}
function fwd(x,y){const i=[(x-.5)*3,(y-.5)*3];const h1=net.W1.map((w,j)=>Math.tanh(w[0]*i[0]+w[1]*i[1]+net.b1[j]));const h2=net.W2.map((w,j)=>Math.tanh(w.reduce((s,v,k)=>s+v*h1[k],0)+net.b2[j]));const o=1/(1+Math.exp(-(net.W3.reduce((s,v,k)=>s+v*h2[k],0)+net.b3)));return{i,h1,h2,o}}
function sgd(x,y,t,lr){const f=fwd(x,y);const d3=f.o-t;const d2=f.h2.map((h,k)=>d3*net.W3[k]*(1-h*h));const d1=f.h1.map((h,k)=>{let s=0;for(let j=0;j<H;j++)s+=d2[j]*net.W2[j][k];return s*(1-h*h)});
 for(let k=0;k<H;k++)net.W3[k]-=lr*d3*f.h2[k];net.b3-=lr*d3;
 for(let j=0;j<H;j++){for(let k=0;k<H;k++)net.W2[j][k]-=lr*d2[j]*f.h1[k];net.b2[j]-=lr*d2[j]}
 for(let j=0;j<H;j++){net.W1[j][0]-=lr*d1[j]*f.i[0];net.W1[j][1]-=lr*d1[j]*f.i[1];net.b1[j]-=lr*d1[j]}}
function setN(n){N=n;if(timer)clearInterval(timer);init();epoch=0;data=[];for(let i=0;i<N;i++){const x=Math.random(),y=Math.random();let t=truth(x,y);if(Math.random()<.08)t=1-t;data.push([x,y,t])}drawNN();document.getElementById('nstat').textContent=N+' labelled examples ready (8% of labels are noisy). Press Train.'}
function acc(fn){let c=0,n=1500;const r=mulberry(7);for(let i=0;i<n;i++){const x=r(),y=r();if((fn(x,y)>.5?1:0)==truth(x,y))c++}return Math.round(100*c/n)}
function mulberry(a){return()=>{a|=0;a=a+0x6D2B79F5|0;let t=Math.imul(a^a>>>15,1|a);t=t+Math.imul(t^t>>>7,61|t)^t;return((t^t>>>14)>>>0)/4294967296}}
function paint(ctx,fn,pts){const g=52,s=260/g;for(let a=0;a<g;a++)for(let b=0;b<g;b++){const p=fn((a+.5)/g,(b+.5)/g);const c=Math.abs(p-.5)*2;ctx.fillStyle=p>.5?`rgba(235,130,20,${.15+c*.7})`:`rgba(40,90,220,${.15+c*.7})`;ctx.fillRect(a*s,b*s,s+1,s+1)}
 if(pts)pts.forEach(p=>{ctx.fillStyle=p[2]?'#a04800':'#0f2f8f';ctx.strokeStyle='#fff';ctx.beginPath();ctx.arc(p[0]*260,p[1]*260,3.5,0,7);ctx.fill();ctx.stroke()});
 ctx.strokeStyle='#127a3a';ctx.setLineDash([4,3]);ctx.beginPath();ctx.arc(130,130,.3*260,0,7);ctx.stroke();ctx.setLineDash([])}
function drawNN(){const rf=(x,y)=>x>.5?.95:.05;paint(rule,rf,null);document.getElementById('racc').textContent='accuracy on new points: '+acc(rf)+'%';
 paint(nx,(x,y)=>fwd(x,y).o,data);if(epoch>0)document.getElementById('nacc').textContent='epoch '+epoch+' — accuracy on new points: '+acc((x,y)=>fwd(x,y).o)+'%'}
function train(){if(timer)clearInterval(timer);if(!data.length)setN(N);const total=N<100?400:N<1000?120:40;timer=setInterval(()=>{for(let e=0;e<4;e++){epoch++;for(const i of data.map((_,i)=>i).sort(()=>Math.random()-.5)){const p=data[i];sgd(p[0],p[1],p[2],.05)}}drawNN();if(epoch>=total){clearInterval(timer);const a=acc((x,y)=>fwd(x,y).o);document.getElementById('nstat').innerHTML=(a>=90?'<span class=\"ok\">':'<span class=\"bad\">')+'Final accuracy on new points: '+a+'%</span> with '+N+' examples. '+(N<=60?'Too little data: it memorises the noisy points and the boundary is lumpy.':N<1000?'Better: the circle starts to emerge.':'Plenty of data: the noise averages out and the boundary is a smooth circle. It was never told \"circle\".')}},30)}
nnc.addEventListener('click',e=>{const r=nnc.getBoundingClientRect();const x=(e.clientX-r.left)/r.width,y=(e.clientY-r.top)/r.height;document.getElementById('nstat').textContent='P(A) at ('+x.toFixed(2)+', '+y.toFixed(2)+') = '+fwd(x,y).o.toFixed(2)+'  (a probability, not a proof)'});
init();setN(60);
</script></body></html>"
 :AT "2026-11-15T12:31:31" :VERSION 1)
(:PINNED T :ID "keyboard-interrupt-1-vs-4-cores" :MAP "computers" :NODE "interrupts" :TYPE "html"
 :TITLE "Keyboard interrupt: 1 vs 4 cores" :LANGUAGE NIL :CONTENT "<!DOCTYPE html>
<html><head><meta charset=\"utf-8\"><title>Keyboard interrupt</title>
<style>
:root{--ink:#2b2d42;--blue:#4ea8de;--red:#ef476f;--yel:#ffd166;--grn:#06d6a0}
*{box-sizing:border-box}
body{margin:0;padding:12px;background:#fdf6e3;font-family:\"Comic Sans MS\",\"Chalkboard SE\",\"Segoe UI\",sans-serif;color:var(--ink);font-size:14px}
h1{font-size:20px;margin:0 0 8px}
.panel{background:#fff;border:3px solid var(--ink);border-radius:14px;padding:10px;margin-bottom:12px;box-shadow:3px 3px 0 var(--ink)}
.controls{display:flex;flex-wrap:wrap;gap:8px;align-items:center}
button{font:inherit;border:3px solid var(--ink);border-radius:10px;background:var(--yel);padding:3px 10px;cursor:pointer;box-shadow:2px 2px 0 var(--ink)}
button.on{background:var(--grn)}
button:active{transform:translate(2px,2px);box-shadow:none}
label{display:inline-flex;gap:4px;align-items:center}
.legend{font-size:12px;margin-top:6px}
.sw{display:inline-block;width:12px;height:12px;border:2px solid var(--ink);vertical-align:middle;border-radius:3px}
.scene{display:flex;gap:14px;align-items:flex-end;flex-wrap:wrap}
.person{text-align:center;width:120px}
.face{font-size:56px;line-height:1}
.bubble{background:#fff9d6;border:3px solid var(--ink);border-radius:14px;padding:3px 8px;font-size:12px;margin-top:4px;min-height:26px}
.kbwrap{flex:1;min-width:300px}
.hands{display:flex;justify-content:space-around;font-size:34px;height:42px}
.hands span{display:inline-block;transition:transform .08s}
.hands span.tap{transform:translateY(14px) rotate(8deg)}
#kb{background:#8d99ae;border:3px solid var(--ink);border-radius:12px;padding:6px;display:flex;flex-direction:column;gap:4px;align-items:center}
#kb.other{background:#f4a261}
.row{display:flex;gap:4px}
.key{min-width:26px;height:26px;background:#edf2f4;border:2px solid var(--ink);border-radius:6px;display:flex;align-items:center;justify-content:center;font-size:12px;font-weight:bold;box-shadow:0 3px 0 var(--ink);transition:all .08s}
.key.down{transform:translateY(3px);box-shadow:0 0 0 var(--ink);background:var(--yel)}
.key.space{min-width:180px}
#inp{width:100%;margin-top:8px;font:inherit;font-size:15px;padding:6px 10px;border:3px solid var(--ink);border-radius:10px}
.wire{width:8px;height:26px;margin:0 auto;background:#bbb;border:2px solid var(--ink);border-radius:4px;position:relative;overflow:hidden}
.wire.hot{background:var(--red)}
.wire.svc{background:#f4a261}
.wire.hot::after,.drop.hot .stub::after{content:\"\";position:absolute;left:1px;width:6px;height:6px;border-radius:50%;background:#fff;animation:fall .5s linear infinite}
@keyframes fall{from{top:-6px}to{top:100%}}
.ctl{display:flex;flex-wrap:wrap;gap:10px;align-items:center;justify-content:center}
.chip{display:inline-block;border:2px solid var(--ink);background:var(--yel);border-radius:8px;padding:0 6px;font-family:monospace;font-size:12px;margin:0 2px}
.linestate{font-weight:bold}
.coreswrap{overflow-x:auto;padding-bottom:4px}
.grid{display:grid;gap:0}
.col{padding:0 5px}
.drop{height:26px;position:relative;border-top:8px solid #bbb;border-top-color:#bbb}
.drop .stub{position:absolute;left:50%;top:-2px;width:8px;height:28px;margin-left:-4px;background:#bbb;border:2px solid var(--ink);border-radius:4px;overflow:hidden}
.drop.hot .stub{background:var(--red)}
.drop.hot{border-top-color:var(--red)}
.irqtag{position:absolute;left:calc(50% + 8px);top:4px;font-size:10px}
.card{background:#eaf6ff;border:3px solid var(--ink);border-radius:14px;padding:8px;box-shadow:3px 3px 0 var(--ink);font-size:12px;min-width:150px}
.card.int{background:#ffe3ea}
.ch{display:flex;justify-content:space-between;gap:4px;margin-bottom:4px}
.task{font-size:10px;opacity:.7}
.status{font-weight:bold;min-height:32px;font-size:12px}
.pills{display:flex;gap:3px;margin:4px 0}
.pill{flex:1;text-align:center;border:2px solid var(--ink);border-radius:8px;padding:1px 0;font-size:11px;background:#fff;opacity:.5}
.pill.a{background:var(--blue);opacity:1;color:#fff;font-weight:bold}
.pill.h{background:var(--red);opacity:1;color:#fff;font-weight:bold}
.pill.p{background:#ccc;opacity:.8;text-decoration:line-through}
.regs{display:grid;grid-template-columns:1fr 1fr;gap:2px 6px;font-family:monospace;font-size:11px;background:#fff;border:2px solid var(--ink);border-radius:8px;padding:4px}
.bad{color:#fff;background:var(--red);border-radius:4px;padding:0 3px}
.code{font-family:monospace;font-size:10.5px;margin-top:4px;background:#fff;border:2px solid var(--ink);border-radius:8px;padding:3px;white-space:pre}
.ln{padding:0 2px;border-radius:3px}
.ln.cur{background:var(--blue);color:#fff}
.ln.curh{background:var(--red);color:#fff}
.ln.skip{text-decoration:line-through;opacity:.4}
.sep{border-top:1px dashed #888;margin:2px 0}
.stk{font-family:monospace;font-size:10.5px;margin-top:4px;background:#fffbe6;border:2px solid var(--ink);border-radius:8px;padding:3px;min-height:20px}
.tl{display:flex;height:12px;margin-top:5px;border:2px solid var(--ink);border-radius:4px;overflow:hidden;background:#fff}
.tl span{flex:1}
.stat{font-size:11px;margin-top:3px}
.ram{display:grid;grid-template-columns:repeat(auto-fit,minmax(200px,1fr));gap:10px}
.ram h3{margin:0 0 4px;font-size:13px}
.mono{font-family:monospace;font-size:12px}
.slots{display:grid;grid-template-columns:repeat(8,1fr);gap:3px}
.slot{border:2px solid var(--ink);border-radius:6px;height:34px;text-align:center;font-family:monospace;font-size:13px;background:#fff;position:relative;padding-top:2px}
.slot.new{background:var(--grn)}
.slot.done{opacity:.4}
.slot small{position:absolute;bottom:-1px;left:0;right:0;font-size:9px;line-height:9px;color:var(--red)}
.ivt div{border:2px solid var(--ink);border-radius:6px;margin-bottom:3px;padding:1px 6px;background:#fff;font-family:monospace;font-size:12px}
.ivt div.hot{background:var(--yel)}
#screen{border:2px solid var(--ink);border-radius:8px;min-height:50px;background:#1d2d44;color:#9ef;font-family:monospace;padding:6px;white-space:pre-wrap;word-break:break-all}
#log{font-size:12px;line-height:1.5}
#log div:first-child{font-weight:bold}
.foot{font-size:11px;opacity:.75}
</style></head><body>
<h1>⌨️ → ⚡ → 🧠 What a keypress does to the CPU</h1>

<div class=\"panel\">
 <div class=\"controls\">
  <button id=\"b1\" class=\"on\">1 core</button><button id=\"b4\">4 cores</button>
  <label id=\"routeL\" style=\"display:none\">IRQ routed to
   <select id=\"route\"><option value=\"c0\">core 0 only</option><option value=\"rr\">round-robin</option></select></label>
  <label>Speed <input type=\"range\" id=\"spd\" min=\"1\" max=\"20\" value=\"4\"></label>
  <button id=\"bp\">⏸ Pause</button><button id=\"bs\">⏭ Step</button>
  <button id=\"bb\">⌨ Burst “hello”</button><button id=\"br\">↺ Reset</button>
  <label><input type=\"checkbox\" id=\"bug\"> 😈 handler forgets to save R0/R1</label>
 </div>
 <div class=\"legend\"><span class=\"sw\" style=\"background:var(--blue)\"></span> background work &nbsp; <span class=\"sw\" style=\"background:var(--red)\"></span> interrupt sequence (timeline strip at the bottom of each core). Each tick = one Fetch, Decode or Execute step.</div>
</div>

<div class=\"panel\">
 <div class=\"scene\">
  <div class=\"person\"><div class=\"face\">🧑‍💻</div><div class=\"bubble\" id=\"bubble\">Type in the box →</div></div>
  <div class=\"kbwrap\"><div class=\"hands\"><span id=\"hL\">✋</span><span id=\"hR\">✋</span></div><div id=\"kb\"></div></div>
 </div>
 <input id=\"inp\" placeholder=\"Type here: every keystroke becomes an interrupt…\" autocomplete=\"off\">
</div>

<div class=\"wire\" id=\"w0\"></div>
<div class=\"panel ctl\">
 <b>🔔 Keyboard controller + interrupt controller</b>
 <span>FIFO of unread scancodes: <span id=\"fifo\"></span></span>
 <span class=\"linestate\" id=\"lineState\"></span>
</div>

<div class=\"coreswrap\"><div class=\"grid\" id=\"cores\"></div></div>

<div class=\"panel\" style=\"margin-top:12px\">
 <b>🗄️ Shared RAM</b>
 <div class=\"ram\" style=\"margin-top:6px\">
  <div><h3>Interrupt vector table</h3><div class=\"ivt\" id=\"ivt\"></div></div>
  <div style=\"grid-column:span 2\"><h3>Keyboard buffer (ring of 8)</h3><div class=\"slots\" id=\"slots\"></div>
   <h3 style=\"margin-top:8px\">Text editor window (gets chars later)</h3><div id=\"screen\"></div></div>
 </div>
</div>

<div class=\"panel\"><b>📜 What just happened</b><div id=\"log\"></div></div>
<div class=\"foot\">Not to scale: a real handler takes microseconds (thousands of cycles) and keystrokes arrive about 100 ms apart, so the CPU spends over 99.99% of its time on background work. Here the handler is shown as 1 tick per instruction, and keys come as fast as you type.</div>

<script>
const $=id=>document.getElementById(id);
const hx=(n,w=2)=>'0x'+n.toString(16).toUpperCase().padStart(w,'0');
const TASKS=['OS background work','Web browser','Music player','Compiler'];
const PROG=[
 {t:'ADD R1,R0',f:c=>{c.r1=(c.r1+c.r0)&0xFFFF;c.pc=1}},
 {t:'INC R0',f:c=>{c.r0=(c.r0+1)&0xFF;c.pc=2}},
 {t:'JMP 0x00',f:c=>{c.pc=0;c.iters++}}];
const HL=['PUSH R0','PUSH R1','IN   R0,0x60','XLAT R1,R0','STORE [kbbuf],R1','OUT  0x20,EOI','POP  R1','POP  R0','IRET'];
const SKIPL=[0,1,6,7];
const SCAN={};
'1234567890'.split('').forEach((k,i)=>SCAN[k]=2+i);
'QWERTYUIOP'.split('').forEach((k,i)=>SCAN[k]=0x10+i);
'ASDFGHJKL'.split('').forEach((k,i)=>SCAN[k]=0x1E+i);
'ZXCVBNM'.split('').forEach((k,i)=>SCAN[k]=0x2C+i);
SCAN[' ']=0x39;SCAN.Enter=0x1C;SCAN.Backspace=0x0E;

let N=1,routing='c0',tick=0,paused=false,cores=[],kbdQueue=[],claimed=-1,rr=0;
let buf,head,tail,screen,deliveries,logL,ivtHot,lastWrite,lastWriteTick;

function resetAll(){
 tick=0;kbdQueue=[];claimed=-1;rr=0;buf=new Array(8).fill(null);head=0;tail=0;screen='';
 deliveries=[];logL=[];ivtHot=-9;lastWrite=-1;lastWriteTick=-9;
 buildCores();say('Ready. Type something and watch the red interrupt line.');render();
}
function say(m){logL.unshift(m);if(logL.length>7)logL.pop()}
function makeCore(i){return{id:i,pc:0,phase:0,insIdx:0,ir:'—',r0:3+i*40,r1:0,IF:1,mode:'run',steps:[],step:0,stack:[],base:0x7F00-i*0x100,hist:[],iters:0,grace:0,shadow:null,cur:null,lastPhase:-1,curLine:-1,handled:0,flash:0,flashTxt:''}}
function buildCores(){
 cores=[];const g=$('cores');
 g.style.gridTemplateColumns=`repeat(${N},minmax(${N==1?260:165}px,${N==1?'430px':'1fr'}))`;
 let h='';
 for(let i=0;i<N;i++){cores.push(makeCore(i));
  h+=`<div class=\"col\"><div class=\"drop\" id=\"drop${i}\"><div class=\"stub\"></div><span class=\"irqtag\">IRQ1</span></div>
  <div class=\"card\" id=\"card${i}\"><div class=\"ch\"><b>🧠 Core ${i}</b><span class=\"task\">${TASKS[i]}</span></div>
  <div class=\"status\" id=\"st${i}\"></div><div class=\"pills\" id=\"pl${i}\"></div><div class=\"regs\" id=\"rg${i}\"></div>
  <div class=\"code\" id=\"cd${i}\"></div><div class=\"stk\" id=\"sk${i}\"></div><div class=\"tl\" id=\"tl${i}\"></div><div class=\"stat\" id=\"ss${i}\"></div></div></div>`}
 g.innerHTML=h;
}
function buildKb(){
 const rows=['1234567890','QWERTYUIOP','ASDFGHJKL','ZXCVBNM'];let h='';
 rows.forEach(r=>{h+='<div class=\"row\">'+r.split('').map(k=>`<div class=\"key\" data-k=\"${k}\">${k}</div>`).join('')+'</div>'});
 h+='<div class=\"row\"><div class=\"key space\" data-k=\" \">SPACE</div></div>';$('kb').innerHTML=h;
}
function target(){return(routing==='rr'&&N>1)?rr%N:0}
function lineHigh(){return kbdQueue.length>0&&claimed===-1}

/* ---- key input ---- */
let hand=0;
function press(key){
 let disp,out,code,sc;
 if(key==='Backspace'){disp='⌫';out='⌫';code=8;sc=SCAN.Backspace}
 else if(key==='Enter'){disp='↵';out='↵';code=13;sc=SCAN.Enter}
 else if(key.length===1){out=key;disp=key===' '?'␣':key;code=key.charCodeAt(0);sc=SCAN[key.toUpperCase()]??0x56}
 else return;
 if(kbdQueue.length>=16)return;
 kbdQueue.push({sc,disp,out,code});
 const el=document.querySelector(`.key[data-k=\"${key.toUpperCase()}\"]`);
 $('kb').classList.toggle('other',!el);
 if(el){el.classList.add('down');setTimeout(()=>el.classList.remove('down'),160)}
 const h=$(hand++%2?'hL':'hR');h.classList.add('tap');setTimeout(()=>h.classList.remove('tap'),130);
 $('bubble').textContent=`clack! “${disp}” (scancode ${hx(sc)})`;
 say(`Key “${disp}” pressed: keyboard controller latches scancode ${hx(sc)} and raises the IRQ line.`);
 render();
}
$('inp').addEventListener('keydown',e=>{if(e.ctrlKey||e.metaKey||e.altKey)return;press(e.key)});
$('bb').onclick=()=>{[...'hello'].forEach((c,i)=>setTimeout(()=>{press(c);$('inp').value+=c},i*160))};

/* ---- cores ---- */
function push(c,label,val){c.stack.push({label,val})}
function buildSteps(skip){
 const S=[];
 S.push({line:-1,t:'Instruction finished. Hardware PUSHes the return PC onto this core’s stack.',f:c=>push(c,'PC',c.pc)});
 S.push({line:-1,t:'Hardware PUSHes FLAGS, then clears IF so no other IRQ barges in.',f:c=>{push(c,'FLAGS',c.IF);c.IF=0}});
 S.push({line:-1,t:'Hardware reads IVT[1] → handler at 0x80 and loads it into PC.',f:c=>{c.pc=0x80;ivtHot=tick}});
 if(!skip){
  S.push({line:0,t:'PUSH R0: save the program’s register.',f:c=>push(c,'R0',c.r0)});
  S.push({line:1,t:'PUSH R1: save the program’s register.',f:c=>push(c,'R1',c.r1)});}
 S.push({line:2,t:'IN R0,0x60: read the scancode from the keyboard (R0 is overwritten!).',f:c=>{c.cur=kbdQueue.shift();c.r0=c.cur.sc}});
 S.push({line:3,t:'XLAT: translate scancode to a character code in R1.',f:c=>{c.r1=c.cur.code}});
 S.push({line:4,t:'STORE: put the character into the keyboard buffer in RAM.',f:c=>{buf[head]={ch:c.cur.disp,out:c.cur.out,done:false};lastWrite=head;lastWriteTick=tick;head=(head+1)%8}});
 S.push({line:5,t:'OUT EOI: tell the controller “done”. The IRQ line is free again.',f:c=>{claimed=-1;if(N>1&&routing==='rr')rr=(rr+1)%N}});
 if(!skip){
  S.push({line:6,t:'POP R1: restore the program’s register.',f:c=>{c.r1=c.stack.pop().val}});
  S.push({line:7,t:'POP R0: restore the program’s register.',f:c=>{c.r0=c.stack.pop().val}});}
 S.push({line:8,t:'IRET (1/2): POP FLAGS, so IF=1 again.',f:c=>{c.IF=c.stack.pop().val}});
 S.push({line:8,t:'IRET (2/2): POP PC. Back to the interrupted program.',f:c=>{
  c.pc=c.stack.pop().val;c.mode='run';c.phase=0;c.grace=1;c.handled++;c.lastPhase=-1;c.curLine=-1;
  const s=c.shadow;
  if(c.r0!==s.r0||c.r1!==s.r1){c.flash=14;c.flashTxt=`💥 R0 was ${hx(s.r0)}, now ${hx(c.r0)}. The program’s data is corrupted!`;
   say(`Core ${c.id}: 💥 Registers were not restored. R0 ${hx(s.r0)} → ${hx(c.r0)}. The program computes garbage from here on.`)}
  else say(`Core ${c.id}: registers identical to before the interrupt. The program never noticed.`);
  deliveries.push(tick+6)}});
 return S;
}
function coreTick(c){
 if(c.flash>0)c.flash--;
 if(c.mode==='run'){
  if(c.phase===0&&lineHigh()&&target()===c.id&&c.IF&&c.grace===0){
   claimed=c.id;c.mode='int';c.step=0;c.shadow={r0:c.r0,r1:c.r1,pc:c.pc};c.steps=buildSteps($('bug').checked);
   say(`Core ${c.id}: IRQ accepted at an instruction boundary. The FDE loop stops fetching program code.`);
  } else {
   if(c.phase===0){c.insIdx=c.pc;c.ir=PROG[c.pc].t}
   c.lastPhase=c.phase;
   if(c.phase===2){PROG[c.insIdx].f(c);if(c.grace>0)c.grace--}
   c.phase=(c.phase+1)%3;c.hist.push(0);if(c.hist.length>48)c.hist.shift();return}
 }
 const s=c.steps[c.step++];
 if(s.line>=0)c.pc=0x80+s.line;
 c.curLine=s.line;c.lastPhase=-1;
 s.f(c);c.lastStep=s;
 if(c.mode==='int')c.ir=s.line>=0?HL[s.line]:'(hardware)';
 else c.ir='—';
 say(`Core ${c.id}: ${s.t}`);
 c.hist.push(1);if(c.hist.length>48)c.hist.shift();
}
function consume(){
 const e=buf[tail];
 if(e&&!e.done){e.done=true;
  if(e.out==='⌫')screen=screen.slice(0,-1);else if(e.out==='↵')screen+='\\n';else screen+=e.out;
  tail=(tail+1)%8;say(`OS bottom half: character “${e.disp}” taken from the buffer and delivered to the text editor.`)}
}
function step(){
 tick++;cores.forEach(coreTick);
 while(deliveries.length&&deliveries[0]<=tick){deliveries.shift();consume()}
 render();
}

/* ---- render ---- */
function statusText(c){
 if(c.mode==='int')return '⚡ '+c.lastStep.t;
 if(lineHigh()&&target()===c.id){
  return c.grace>0?'🔔 IRQ pending: the one instruction after an IRET must finish first…':'🔔 IRQ pending: finishing the current instruction first…'}
 if(c.flash>0)return c.flashTxt;
 return '▶ Running background work'+(N>1&&claimed!==-1?' (undisturbed)':'');
}
function render(){
 const high=lineHigh();
 $('w0').className='wire'+(high?' hot':claimed!==-1?' svc':'');
 $('fifo').innerHTML=kbdQueue.map(k=>`<span class=\"chip\">${k.disp} ${hx(k.sc)}</span>`).join('')||'<i>empty</i>';
 $('lineState').textContent=high?`🔴 INT line HIGH → core ${target()}`:claimed!==-1?`🟠 core ${claimed} is servicing (masked until EOI)`:'⚪ INT line low (idle)';
 cores.forEach(c=>{
  const i=c.id,int=c.mode==='int';
  $('card'+i).className='card'+(int?' int':'');
  $('drop'+i).className='drop'+((high&&target()===i)||claimed===i?' hot':'');
  $('st'+i).textContent=statusText(c);
  const L=['Fetch','Decode','Execute'];
  $('pl'+i).innerHTML=L.map((n,k)=>{
   let cl='';
   if(int){cl=c.curLine<0?'p':'h'} else if(c.lastPhase===k)cl='a';
   return `<div class=\"pill ${cl}\">${n[0]}</div>`}).join('')+
   `<div style=\"font-size:10px;align-self:center\">${int?(c.curLine<0?'paused':'handler'):''}</div>`;
  const bad=c.flash>0?'bad':'';
  $('rg'+i).innerHTML=`<span>PC ${hx(c.pc)}</span><span>IF=${c.IF}</span><span class=\"${bad}\">R0 ${hx(c.r0)}</span><span class=\"${bad}\">R1 ${hx(c.r1,4)}</span><span style=\"grid-column:span 2\">IR: ${c.ir}</span>`;
  let code='<div style=\"opacity:.6\">background program</div>';
  PROG.forEach((p,k)=>{const cur=c.pc===k&&!(int&&c.pc>=0x80);
   code+=`<div class=\"ln ${cur?(int?'curh':'cur'):''}\">${cur?'▶':' '} ${hx(k)} ${p.t}</div>`});
  code+='<div class=\"sep\"></div><div style=\"opacity:.6\">keyboard handler</div>';
  const skip=$('bug').checked;
  HL.forEach((t,k)=>{const cur=int&&c.pc===0x80+k;
   code+=`<div class=\"ln ${cur?'curh':''} ${skip&&SKIPL.includes(k)?'skip':''}\">${cur?'▶':' '} ${hx(0x80+k)} ${t}</div>`});
  $('cd'+i).innerHTML=code;
  let sp=c.base-2*c.stack.length;
  let sk=`<div style=\"opacity:.6\">stack, SP=${hx(sp,4)}</div>`;
  if(!c.stack.length)sk+='<div>(empty)</div>';
  for(let k=c.stack.length-1;k>=0;k--){const e=c.stack[k];sk+=`<div>${hx(c.base-2*(k+1),4)}: ${e.label}=${hx(e.val)}</div>`}
  $('sk'+i).innerHTML=sk;
  $('tl'+i).innerHTML=c.hist.map(v=>`<span style=\"background:${v?'#ef476f':'#4ea8de'}\"></span>`).join('');
  $('ss'+i).textContent=`Loop iterations: ${c.iters} · interrupts handled: ${c.handled}`;
 });
 $('ivt').innerHTML=`<div>[0] timer → 0x70</div><div class=\"${tick-ivtHot<=1?'hot':''}\">[1] keyboard → 0x80</div><div>[2] disk → 0x90</div>`;
 $('slots').innerHTML=buf.map((e,k)=>{
  let m=(k===head?'H':'')+(k===tail?'T':'');
  return `<div class=\"slot ${e?(e.done?'done':''):''} ${k===lastWrite&&tick-lastWriteTick<3?'new':''}\">${e?e.disp:''}<small>${m}</small></div>`}).join('');
 $('screen').textContent=screen+'▌';
 $('log').innerHTML=logL.map(l=>`<div>${l}</div>`).join('');
}

/* ---- controls ---- */
function setN(n){N=n;$('b1').className=n===1?'on':'';$('b4').className=n===4?'on':'';$('routeL').style.display=n>1?'inline-flex':'none';resetAll()}
$('b1').onclick=()=>setN(1);$('b4').onclick=()=>setN(4);
$('route').onchange=e=>{routing=e.target.value;render()};
$('bp').onclick=()=>{paused=!paused;$('bp').textContent=paused?'▶ Play':'⏸ Pause'};
$('bs').onclick=()=>{if(paused)step()};
$('br').onclick=()=>{$('inp').value='';resetAll()};
$('bug').onchange=render;
function loop(){if(!paused)step();setTimeout(loop,2000/$('spd').value)}
buildKb();resetAll();loop();
</script></body></html>
"
 :AT "2026-11-15T13:30:50" :VERSION 1)
(:PINNED T :ID "interrupt-wire-to-handler-and-back" :MAP "computers" :NODE "interrupts" :TYPE
 "html" :TITLE "Interrupt: wire to handler and back" :LANGUAGE NIL :CONTENT
 "<!DOCTYPE html><html><head><meta charset=\"utf-8\"><style>
body{margin:0;padding:12px;font-family:system-ui,sans-serif;background:#fdf6e3;color:#2b2d42;font-size:14px}
button{font:inherit;border:2px solid #2b2d42;border-radius:8px;background:#ffd166;padding:4px 12px;cursor:pointer;margin-right:6px}
.row{display:flex;gap:12px;flex-wrap:wrap;margin-top:10px}
.box{background:#fff;border:2px solid #2b2d42;border-radius:10px;padding:8px;flex:1;min-width:190px}
.box h3{margin:0 0 6px;font-size:13px}
.ln{font-family:monospace;font-size:13px;padding:2px 6px;border-radius:4px;margin:2px 0}
.cur{background:#4ea8de;color:#fff}.curh{background:#ef476f;color:#fff}
.pill{display:inline-block;border:2px solid #2b2d42;border-radius:8px;padding:1px 8px;margin-right:4px;opacity:.4}
.pill.on{opacity:1;background:#4ea8de;color:#fff}
.flow{display:flex;align-items:center;gap:6px;flex-wrap:wrap}
.node{border:2px solid #2b2d42;border-radius:8px;padding:4px 8px;background:#fff}
.wire{height:8px;width:60px;background:#bbb;border:2px solid #2b2d42;border-radius:4px}
.wire.hot{background:#ef476f}
.sig{font-family:monospace;padding:1px 6px;border-radius:4px;background:#eee;margin-right:4px}
.sig.t{background:#06d6a0}
#msg{margin-top:10px;background:#fff9d6;border:2px solid #2b2d42;border-radius:10px;padding:8px;min-height:44px;font-weight:600}
.stk div{font-family:monospace;background:#ffe3ea;border:2px solid #2b2d42;border-radius:6px;padding:1px 6px;margin:2px 0}
.vt div{font-family:monospace;padding:1px 6px;border:2px solid #2b2d42;border-radius:6px;margin:2px 0;background:#fff}
.vt .hot{background:#ffd166}
</style></head><body>
<b>How hardware forces the CPU to handle an interrupt</b>
<div style=\"margin:8px 0\"><button id=\"key\">⌨ Press a key (raise IRQ)</button><button id=\"play\">⏸ Pause</button><button id=\"step\">⏭ Step</button><button id=\"reset\">↺ Reset</button></div>
<div class=\"flow\">
 <span class=\"node\">⌨ Keyboard</span><span class=\"wire\" id=\"w1\"></span>
 <span class=\"node\">Interrupt controller<br><small>latch · mask · priority</small></span><span class=\"wire\" id=\"w2\"></span>
 <span class=\"node\">CPU pin <b>INT</b></span>
</div>
<div class=\"row\">
 <div class=\"box\"><h3>Program (running)</h3><div id=\"prog\"></div></div>
 <div class=\"box\"><h3>CPU control unit</h3>
  <div id=\"ph\"><span class=\"pill\">Fetch</span><span class=\"pill\">Decode</span><span class=\"pill\">Execute</span></div>
  <div style=\"margin:8px 0\">PC = <b id=\"pc\"></b> &nbsp; mode: <b id=\"mode\"></b></div>
  <div><small>At each instruction boundary the gate computes:</small></div>
  <div style=\"margin-top:4px\"><span class=\"sig\" id=\"s1\">IRQ pending</span>AND<span class=\"sig\" id=\"s2\" style=\"margin-left:4px\">enabled</span>= <span class=\"sig\" id=\"s3\">take</span></div>
 </div>
 <div class=\"box\"><h3>Handler (OS code)</h3><div id=\"hand\"></div></div>
 <div class=\"box\"><h3>RAM</h3><b style=\"font-size:12px\">Stack</b><div class=\"stk\" id=\"stk\" style=\"min-height:26px\"></div>
  <b style=\"font-size:12px\">Vector table</b><div class=\"vt\" id=\"vt\"><div>0: …</div><div id=\"v1\">1 (keyboard): → handler</div><div>2: …</div></div></div>
</div>
<div id=\"msg\"></div>
<script>
const P=[\"ADD R0,R1\",\"LOAD R2,[x]\",\"MUL R2,R0\",\"STORE [x],R2\",\"JMP loop\"];
const H=[\"IN  R0,keyboard\",\"STORE buf,R0\",\"IRET\"];
let pc,ph,mode,hs,en,irq,stack,es,msg,t,playing=true,timer;
const $=i=>document.getElementById(i);
function reset(){pc=0;ph=0;mode=\"main\";hs=0;en=true;irq=false;stack=[];es=0;msg=\"Program running: one instruction = fetch, decode, execute. Press a key at any moment.\";render()}
const E=[\"① Push PC and flags onto the stack (PC = next unstarted instruction).\",\"② Switch to privileged mode and disable further interrupts.\",\"③ Ask the interrupt controller for the vector number (1 = keyboard).\",\"④ Read handler address from vector table and load it into PC. Handler starts.\"];
function tick(){
 if(mode==\"main\"){
  if(ph<2){ph++;msg=irq?\"IRQ is pending but the CPU ignores it mid-instruction: finishing \"+P[pc]+\".\":\"Executing \"+P[pc]+\"…\";}
  else{ // boundary
   if(irq&&en){mode=\"entry\";es=0;msg=\"Boundary: pending AND enabled = TRUE. Control unit skips the next fetch and starts the fixed entry sequence. \"+E[0];stack.push(\"flags\");stack.push(\"PC=\"+((pc+1)%5));es=1;}
   else{pc=(pc+1)%5;ph=0;msg=\"Boundary: gate = FALSE. Fetch next instruction.\"}
  }
 }else if(mode==\"entry\"){
  msg=E[es];if(es==1){en=false}
  if(es==3){pc=(pc+1)%5;mode=\"hand\";hs=0}
  es++;
 }else{
  if(hs<2){msg=\"Handler runs: \"+H[hs];hs++;}
  else{pc=parseInt(stack.pop().slice(3));stack.pop();en=true;irq=false;mode=\"main\";ph=0;msg=\"IRET: pop PC and flags, re-enable interrupts, clear request. Program resumes at instruction \"+(pc+1)+\" as if nothing happened.\";}
 }
 render()}
function render(){
 $(\"prog\").innerHTML=P.map((p,i)=>`<div class=\"ln ${mode==\"main\"&&i==pc?\"cur\":\"\"}\">${i+1}. ${p}</div>`).join(\"\");
 $(\"hand\").innerHTML=H.map((p,i)=>`<div class=\"ln ${mode==\"hand\"&&i==hs-1?\"curh\":\"\"}\">${p}</div>`).join(\"\");
 [...$(\"ph\").children].forEach((e,i)=>e.className=\"pill\"+(mode==\"main\"&&i==ph?\" on\":\"\"));
 $(\"pc\").textContent=mode==\"hand\"?\"handler\":(pc+1);
 $(\"mode\").textContent=mode==\"main\"?\"user\":\"privileged\";
 $(\"w1\").className=\"wire\"+(irq?\" hot\":\"\");$(\"w2\").className=\"wire\"+(irq?\" hot\":\"\");
 $(\"s1\").className=\"sig\"+(irq?\" t\":\"\");$(\"s2\").className=\"sig\"+(en?\" t\":\"\");$(\"s3\").className=\"sig\"+(irq&&en&&mode==\"main\"&&ph==2?\" t\":\"\");
 $(\"stk\").innerHTML=stack.slice().reverse().map(s=>`<div>${s}</div>`).join(\"\");
 $(\"v1\").className=(mode==\"entry\"&&es>=3)||mode==\"hand\"?\"hot\":\"\";
 $(\"msg\").textContent=msg}
function loop(){clearInterval(timer);if(playing)timer=setInterval(tick,900)}
$(\"key\").onclick=()=>{irq=true;msg=\"Keyboard raises its line. Controller latches it and drives INT high. The CPU does not stop mid-instruction.\";render()};
$(\"play\").onclick=()=>{playing=!playing;$(\"play\").textContent=playing?\"⏸ Pause\":\"▶ Play\";loop()};
$(\"step\").onclick=tick;$(\"reset\").onclick=reset;
reset();loop();
</script></body></html>"
 :AT "2026-11-15T13:50:40" :VERSION 1)
(:PINNED T :ID "scheduling-algorithms-on-one-cpu" :MAP "computers" :NODE "scheduler" :TYPE "html"
 :TITLE "Scheduling algorithms on one CPU" :LANGUAGE NIL :CONTENT
 "<!DOCTYPE html><html><head><meta charset=\"utf-8\"><style>
body{font-family:system-ui,sans-serif;margin:0;padding:14px;background:#fafafa;color:#222}
h2{margin:0 0 6px;font-size:18px}
.row{display:flex;gap:8px;flex-wrap:wrap;align-items:center;margin:8px 0}
button{padding:6px 12px;border:1px solid #888;border-radius:6px;background:#fff;cursor:pointer;font-size:14px}
button.on{background:#222;color:#fff}
#desc{font-size:14px;background:#fff;border:1px solid #ddd;border-radius:6px;padding:8px;margin:8px 0;min-height:60px}
canvas{width:100%;background:#fff;border:1px solid #ddd;border-radius:6px}
table{border-collapse:collapse;font-size:13px;margin-top:8px;width:100%}
td,th{border:1px solid #ddd;padding:4px 6px;text-align:center}
.sw{display:inline-block;width:12px;height:12px;border-radius:3px;vertical-align:middle}
</style></head><body>
<h2>One CPU, four programs: how the kernel picks who runs</h2>
<div class=\"row\" id=\"algos\"></div>
<div id=\"desc\"></div>
<div class=\"row\">
<button id=\"play\">Pause</button><button id=\"reset\">Restart</button>
<label>Speed <input type=\"range\" id=\"spd\" min=\"1\" max=\"10\" value=\"4\"></label>
<label>Quantum <input type=\"range\" id=\"q\" min=\"1\" max=\"6\" value=\"2\"></label><span id=\"qv\"></span>
</div>
<canvas id=\"c\" width=\"800\" height=\"330\"></canvas>
<table id=\"tbl\"></table>
<p style=\"font-size:12px;color:#555\">Each tick = one timer interrupt. Jobs: A needs 8 ticks (arrives 0), B 3 (arrives 1), C 5 (arrives 2), D 2 (arrives 3). Each coloured block is a program owning the CPU; at each change the kernel saves one set of registers and loads another (a context switch).</p>
<script>
const jobs=[{n:'A',arr:0,len:8,col:'#4e79a7',pri:3},{n:'B',arr:1,len:3,col:'#f28e2b',pri:1},{n:'C',arr:2,len:5,col:'#59a14f',pri:4},{n:'D',arr:3,len:2,col:'#e15759',pri:2}];
const algos={
fcfs:['First come, first served','No preemption: run each program to completion in arrival order. Simple, but short jobs wait behind long ones (the \"convoy effect\"). No timer needed.'],
rr:['Round robin (equal time each)','The timer fires every <b>quantum</b> ticks; the running program goes to the back of the queue. Everyone gets equal turns, so all make steady progress. Tiny quantum = many context switches (overhead); huge quantum = becomes FCFS.'],
sjf:['Shortest job first','Always run the ready job with least work remaining (preemptive version = SRTF). Minimises average waiting time but needs to know job length in advance, and can starve long jobs.'],
pri:['Priority (preemptive)','Each program has a priority (A=3, B=1, C=4, D=2; lower number = more important). A newly arrived higher-priority job preempts at once. Low priority can starve; real kernels \"age\" waiting jobs.']
};
let cur='rr',tl=[],sw=0,t=0,acc=0,playing=true;
function sim(){
 const Q=+document.getElementById('q').value;
 let rem=jobs.map(j=>j.len),fin={},first={},tl=[],queue=[],run=-1,qleft=0,added=new Set();
 for(let time=0;time<40;time++){
  jobs.forEach((j,i)=>{if(j.arr<=time&&!added.has(i)){added.add(i);queue.push(i)}});
  if(rem.every(r=>r==0))break;
  const ready=jobs.map((j,i)=>i).filter(i=>j(i).arr<=time&&rem[i]>0);
  function j(i){return jobs[i]}
  let pick=run;
  if(cur=='fcfs'){ if(run<0||rem[run]==0) pick=ready.sort((a,b)=>jobs[a].arr-jobs[b].arr)[0]; }
  else if(cur=='sjf'){ pick=ready.sort((a,b)=>rem[a]-rem[b]||a-b)[0]; }
  else if(cur=='pri'){ pick=ready.sort((a,b)=>jobs[a].pri-jobs[b].pri)[0]; }
  else { queue=queue.filter(i=>rem[i]>0);
   if(run<0||rem[run]==0||qleft==0){
     if(run>=0&&rem[run]>0&&!queue.includes(run))queue.push(run);
     pick=queue.shift();qleft=Q;
   }}
  if(pick===undefined){tl.push(-1);run=-1;continue}
  run=pick;rem[run]--;qleft--;tl.push(run);
  if(first[run]===undefined)first[run]=time;
  if(rem[run]==0)fin[run]=time+1;
 }
 return {tl,fin,first};
}
let R;
function setAlgo(a){cur=a;document.querySelectorAll('#algos button').forEach(b=>b.classList.toggle('on',b.dataset.a==a));
 document.getElementById('desc').innerHTML='<b>'+algos[a][0]+'</b><br>'+algos[a][1];restart()}
function restart(){document.getElementById('qv').textContent=cur=='rr'?document.getElementById('q').value+' ticks':'(unused)';R=sim();t=0;acc=0;draw()}
const ab=document.getElementById('algos');
for(const k in algos){const b=document.createElement('button');b.textContent=algos[k][0].split(' (')[0];b.dataset.a=k;b.onclick=()=>setAlgo(k);ab.appendChild(b)}
const cv=document.getElementById('c'),g=cv.getContext('2d');
function draw(){
 g.clearRect(0,0,800,330);g.font='13px system-ui';
 const W=700/Math.max(R.tl.length,1)>40?40:700/R.tl.length, x0=60;
 // job lanes
 jobs.forEach((j,i)=>{const y=50+i*36;g.fillStyle='#000';g.fillText(j.n,30,y+18);
  g.strokeStyle='#eee';g.strokeRect(x0,y,W*R.tl.length,28);
  g.fillStyle='#888';g.fillText('▼',x0+j.arr*W+W/2-6,y-3);
  for(let k=0;k<t&&k<R.tl.length;k++)if(R.tl[k]==i){g.fillStyle=j.col;g.fillRect(x0+k*W,y,W,28)}
  else if(k>=j.arr&&(R.fin[i]===undefined||k<R.fin[i])){g.fillStyle='#f3f3f3';g.fillRect(x0+k*W+1,y+10,W-2,8)}
 });
 // CPU lane
 g.fillStyle='#000';g.fillText('CPU',20,222);
 let sws=0;
 for(let k=0;k<t&&k<R.tl.length;k++){const v=R.tl[k];
  if(v>=0){g.fillStyle=jobs[v].col;g.fillRect(x0+k*W,205,W,28);g.fillStyle='#fff';g.fillText(jobs[v].n,x0+k*W+W/2-4,224)}
  if(k>0&&v!=R.tl[k-1]&&v>=0){sws++;g.fillStyle='#000';g.fillRect(x0+k*W-1,198,2,42)}}
 for(let k=0;k<=R.tl.length;k+=2){g.fillStyle='#777';g.fillText(k,x0+k*W-3,255)}
 if(t<R.tl.length){g.strokeStyle='#d00';g.beginPath();g.moveTo(x0+t*W,35);g.lineTo(x0+t*W,245);g.stroke()}
 const cur2=t>0&&t<=R.tl.length?R.tl[t-1]:-1;
 g.fillStyle='#000';g.fillText(cur2>=0?'Now running: '+jobs[cur2].n+'   (black bars = context switches: '+sws+')':'',x0,285);
 g.fillStyle='#888';g.fillText('▼ = arrival of program. Pale bar = ready but waiting.',x0,310);
 // table
 let h='<tr><th>Job</th><th>Arrives</th><th>Needs</th><th>Finished</th><th>Turnaround</th><th>Waiting</th></tr>',sw2=0,n=0;
 jobs.forEach((j,i)=>{const f=R.fin[i],done=f!==undefined&&f<=t;
  h+=`<tr><td><span class=sw style=\"background:${j.col}\"></span> ${j.n}</td><td>${j.arr}</td><td>${j.len}</td><td>${done?f:'-'}</td><td>${done?f-j.arr:'-'}</td><td>${done?f-j.arr-j.len:'-'}</td></tr>`;});
 document.getElementById('tbl').innerHTML=h;
}
function loop(){requestAnimationFrame(loop);if(!playing)return;acc+=+document.getElementById('spd').value/60;
 if(acc>=1){acc=0;if(t<R.tl.length){t++;draw()}}}
document.getElementById('play').onclick=e=>{playing=!playing;e.target.textContent=playing?'Pause':'Play'};
document.getElementById('reset').onclick=restart;
document.getElementById('q').oninput=restart;
setAlgo('rr');loop();
</script></body></html>"
 :AT "2026-11-15T13:56:34" :VERSION 1)
(:PINNED T :ID "interrupt-wiring-wire-to-control-unit" :MAP "computers" :NODE "interrupts" :TYPE
 "svg" :TITLE "Interrupt wiring: wire to control unit" :LANGUAGE NIL :CONTENT
 "<svg viewBox=\"0 0 900 640\" xmlns=\"http://www.w3.org/2000/svg\" font-family=\"system-ui,sans-serif\" font-size=\"14\">
<rect width=\"900\" height=\"640\" fill=\"#fdf6e3\"/>
<defs><marker id=\"a\" markerWidth=\"10\" markerHeight=\"10\" refX=\"8\" refY=\"5\" orient=\"auto\"><path d=\"M0,0L10,5L0,10z\" fill=\"#ef476f\"/></marker>
<marker id=\"b\" markerWidth=\"10\" markerHeight=\"10\" refX=\"8\" refY=\"5\" orient=\"auto\"><path d=\"M0,0L10,5L0,10z\" fill=\"#2b2d42\"/></marker></defs>
<text x=\"20\" y=\"28\" font-size=\"18\" font-weight=\"bold\" fill=\"#2b2d42\">An interrupt is just a wire that the CPU's control logic looks at</text>

<!-- Device -->
<rect x=\"20\" y=\"60\" width=\"150\" height=\"90\" rx=\"10\" fill=\"#fff\" stroke=\"#2b2d42\" stroke-width=\"2\"/>
<text x=\"95\" y=\"85\" text-anchor=\"middle\" font-weight=\"bold\">Device</text>
<text x=\"95\" y=\"105\" text-anchor=\"middle\" font-size=\"12\">(keyboard, disk, timer)</text>
<text x=\"95\" y=\"128\" text-anchor=\"middle\" font-size=\"12\">has \"done/ready\" flip-flop</text>

<!-- Device to controller -->
<line x1=\"170\" y1=\"105\" x2=\"250\" y2=\"105\" stroke=\"#ef476f\" stroke-width=\"4\" marker-end=\"url(#a)\"/>
<text x=\"210\" y=\"95\" text-anchor=\"middle\" font-size=\"12\" fill=\"#ef476f\">IRQ1 = 1</text>

<!-- Controller -->
<rect x=\"250\" y=\"50\" width=\"250\" height=\"170\" rx=\"10\" fill=\"#eaf6ff\" stroke=\"#2b2d42\" stroke-width=\"2\"/>
<text x=\"375\" y=\"72\" text-anchor=\"middle\" font-weight=\"bold\">Interrupt controller</text>
<rect x=\"265\" y=\"85\" width=\"90\" height=\"40\" fill=\"#fff\" stroke=\"#2b2d42\"/><text x=\"310\" y=\"102\" text-anchor=\"middle\" font-size=\"12\">latch (SR)</text><text x=\"310\" y=\"117\" text-anchor=\"middle\" font-size=\"11\">remembers pulse</text>
<rect x=\"375\" y=\"85\" width=\"50\" height=\"40\" fill=\"#fff\" stroke=\"#2b2d42\"/><text x=\"400\" y=\"102\" text-anchor=\"middle\" font-size=\"12\">AND</text><text x=\"400\" y=\"117\" text-anchor=\"middle\" font-size=\"11\">mask bit</text>
<rect x=\"440\" y=\"85\" width=\"50\" height=\"40\" fill=\"#fff\" stroke=\"#2b2d42\"/><text x=\"465\" y=\"102\" text-anchor=\"middle\" font-size=\"12\">priority</text><text x=\"465\" y=\"117\" text-anchor=\"middle\" font-size=\"11\">encoder</text>
<line x1=\"355\" y1=\"105\" x2=\"375\" y2=\"105\" stroke=\"#2b2d42\" stroke-width=\"2\"/>
<line x1=\"425\" y1=\"105\" x2=\"440\" y2=\"105\" stroke=\"#2b2d42\" stroke-width=\"2\"/>
<text x=\"375\" y=\"160\" text-anchor=\"middle\" font-size=\"12\">other IRQ lines (timer, disk…) enter here too</text>
<text x=\"375\" y=\"180\" text-anchor=\"middle\" font-size=\"12\">encoder outputs vector number, e.g. 1 (binary)</text>
<text x=\"375\" y=\"200\" text-anchor=\"middle\" font-size=\"12\">and raises one line: INT</text>

<!-- INT to CPU -->
<line x1=\"500\" y1=\"105\" x2=\"580\" y2=\"105\" stroke=\"#ef476f\" stroke-width=\"4\" marker-end=\"url(#a)\"/>
<text x=\"540\" y=\"95\" text-anchor=\"middle\" font-size=\"12\" fill=\"#ef476f\">INT = 1</text>
<line x1=\"500\" y1=\"190\" x2=\"580\" y2=\"190\" stroke=\"#2b2d42\" stroke-width=\"3\" marker-end=\"url(#b)\"/>
<text x=\"540\" y=\"182\" text-anchor=\"middle\" font-size=\"12\">vector # (data bus)</text>

<!-- CPU -->
<rect x=\"580\" y=\"40\" width=\"300\" height=\"330\" rx=\"12\" fill=\"#fff\" stroke=\"#2b2d42\" stroke-width=\"3\"/>
<text x=\"730\" y=\"62\" text-anchor=\"middle\" font-weight=\"bold\">CPU control unit</text>
<rect x=\"600\" y=\"80\" width=\"120\" height=\"50\" fill=\"#ffd166\" stroke=\"#2b2d42\"/><text x=\"660\" y=\"100\" text-anchor=\"middle\" font-size=\"12\">flip-flop \"INT</text><text x=\"660\" y=\"116\" text-anchor=\"middle\" font-size=\"12\">pending\" (sampled)</text>
<rect x=\"600\" y=\"150\" width=\"120\" height=\"40\" fill=\"#ffd166\" stroke=\"#2b2d42\"/><text x=\"660\" y=\"175\" text-anchor=\"middle\" font-size=\"12\">IE flag (enabled)</text>
<circle cx=\"770\" cy=\"135\" r=\"24\" fill=\"#fff\" stroke=\"#2b2d42\" stroke-width=\"2\"/><text x=\"770\" y=\"140\" text-anchor=\"middle\" font-size=\"13\">AND</text>
<line x1=\"720\" y1=\"105\" x2=\"750\" y2=\"125\" stroke=\"#2b2d42\" stroke-width=\"2\"/>
<line x1=\"720\" y1=\"170\" x2=\"750\" y2=\"146\" stroke=\"#2b2d42\" stroke-width=\"2\"/>
<line x1=\"540\" y1=\"105\" x2=\"540\" y2=\"105\" />
<line x1=\"580\" y1=\"105\" x2=\"600\" y2=\"105\" stroke=\"#ef476f\" stroke-width=\"3\"/>
<text x=\"770\" y=\"180\" text-anchor=\"middle\" font-size=\"11\">only checked when</text>
<text x=\"770\" y=\"194\" text-anchor=\"middle\" font-size=\"11\">\"instruction done\" = 1</text>
<line x1=\"794\" y1=\"135\" x2=\"850\" y2=\"135\" stroke=\"#2b2d42\" stroke-width=\"2\"/>
<text x=\"852\" y=\"125\" text-anchor=\"end\" font-size=\"11\">take = 1</text>

<rect x=\"600\" y=\"215\" width=\"260\" height=\"140\" rx=\"8\" fill=\"#ffe3ea\" stroke=\"#ef476f\" stroke-width=\"2\"/>
<text x=\"730\" y=\"236\" text-anchor=\"middle\" font-weight=\"bold\" font-size=\"13\">Control state machine (microcode)</text>
<text x=\"615\" y=\"258\" font-size=\"12\">Normal: state = FETCH → DECODE → EXECUTE</text>
<text x=\"615\" y=\"278\" font-size=\"12\">If take=1 at end of EXECUTE, next state is</text>
<text x=\"615\" y=\"296\" font-size=\"12\">ENTRY instead of FETCH. ENTRY steps:</text>
<text x=\"625\" y=\"314\" font-size=\"12\">1 write PC+flags to stack (SP→RAM)</text>
<text x=\"625\" y=\"330\" font-size=\"12\">2 clear IE (block nested interrupts)</text>
<text x=\"625\" y=\"346\" font-size=\"12\">3 PC ← vector_table[vector #]</text>
<line x1=\"850\" y1=\"135\" x2=\"850\" y2=\"215\" stroke=\"#2b2d42\" stroke-width=\"2\"/><line x1=\"850\" y1=\"215\" x2=\"850\" y2=\"215\"/>

<!-- vector table -->
<rect x=\"20\" y=\"260\" width=\"540\" height=\"150\" rx=\"10\" fill=\"#fff\" stroke=\"#2b2d42\" stroke-width=\"2\"/>
<text x=\"290\" y=\"282\" text-anchor=\"middle\" font-weight=\"bold\">RAM: vector table (set up by the OS at boot)</text>
<rect x=\"40\" y=\"296\" width=\"220\" height=\"28\" fill=\"#fff\" stroke=\"#2b2d42\"/><text x=\"50\" y=\"315\" font-size=\"12\" font-family=\"monospace\">0: timer handler addr</text>
<rect x=\"40\" y=\"324\" width=\"220\" height=\"28\" fill=\"#ffd166\" stroke=\"#2b2d42\"/><text x=\"50\" y=\"343\" font-size=\"12\" font-family=\"monospace\">1: keyboard handler addr</text>
<rect x=\"40\" y=\"352\" width=\"220\" height=\"28\" fill=\"#fff\" stroke=\"#2b2d42\"/><text x=\"50\" y=\"371\" font-size=\"12\" font-family=\"monospace\">2: disk handler addr</text>
<path d=\"M600 340 Q440 440 262 338\" fill=\"none\" stroke=\"#2b2d42\" stroke-width=\"2\" stroke-dasharray=\"5,4\" marker-end=\"url(#b)\"/>
<text x=\"400\" y=\"405\" font-size=\"12\" text-anchor=\"middle\">step 3: index with vector # → load address into PC</text>
<text x=\"300\" y=\"360\" font-size=\"12\">next fetch reads the</text><text x=\"300\" y=\"376\" font-size=\"12\">handler's first instruction</text>

<!-- Return -->
<rect x=\"20\" y=\"440\" width=\"860\" height=\"180\" rx=\"10\" fill=\"#fff\" stroke=\"#2b2d42\" stroke-width=\"2\"/>
<text x=\"450\" y=\"464\" text-anchor=\"middle\" font-weight=\"bold\">Why this \"forces\" the CPU</text>
<text x=\"40\" y=\"490\" font-size=\"13\">• The program never asks. The INT wire feeds the CPU's own control logic, the same circuit that picks the next step each cycle.</text>
<text x=\"40\" y=\"514\" font-size=\"13\">• Voltage on a wire → flip-flop → AND gate → changes which state the control state machine enters next. That is all \"forcing\" is.</text>
<text x=\"40\" y=\"538\" font-size=\"13\">• Program code cannot veto it, except by clearing the IE flag (privileged). The mask bits in the controller work the same way.</text>
<text x=\"40\" y=\"562\" font-size=\"13\">• Checked only between instructions, so registers are in a clean state and PC points at the next instruction to run.</text>
<text x=\"40\" y=\"586\" font-size=\"13\">• The handler ends with IRET: pop flags and PC from the stack, set IE. The old program continues from the saved PC.</text>
<text x=\"40\" y=\"608\" font-size=\"13\">• Handler tells the device to drop IRQ (e.g. by reading its data register), otherwise the latch re-fires immediately.</text>
</svg>"
 :AT "2026-11-15T14:35:57" :VERSION 1)
(:PINNED T :ID "page-tables-faults-and-eviction" :MAP "computers" :NODE "virtual-memory" :TYPE
 "html" :TITLE "Page tables, faults and eviction" :LANGUAGE NIL :CONTENT
 "<!DOCTYPE html><html><head><meta charset=\"utf-8\"><style>
body{font-family:system-ui,sans-serif;margin:12px;color:#1b1f24;background:#fafafa}
h3{margin:4px 0 8px}
.row{display:flex;gap:12px;flex-wrap:wrap}
.card{background:#fff;border:1px solid #d0d7de;border-radius:8px;padding:10px;flex:1;min-width:210px}
table{border-collapse:collapse;width:100%;font-size:13px}
td,th{border:1px solid #d0d7de;padding:4px 6px;text-align:center}
.A{background:#dbeafe}.B{background:#fde68a}.free{background:#f1f5f9;color:#889}
button{margin:2px;padding:6px 9px;border:1px solid #888;border-radius:6px;background:#fff;cursor:pointer;font-size:13px}
button:hover{background:#eef}
.btnA{border-color:#2563eb}.btnB{border-color:#d97706}.bad{border-color:#c00;color:#c00}
#log{font-family:monospace;font-size:12.5px;height:170px;overflow:auto;background:#0f172a;color:#e2e8f0;padding:8px;border-radius:8px;margin-top:10px}
.hit{color:#86efac}.flt{color:#fca5a5}.seg{color:#f0abfc}.note{font-size:12.5px;color:#555}
.hl{outline:3px solid #16a34a}
</style></head><body>
<h3>Two processes, one 3-frame RAM</h3>
<p class=\"note\">Both processes use the same virtual addresses (pages 0–3, 4 KB each). Click a page to access it. Eviction picks the least recently used frame.</p>
<div>
<b>Process A:</b> <span id=\"bA\"></span> <button class=\"bad\" onclick=\"seg('A')\">A touches page 7</button><br>
<b>Process B:</b> <span id=\"bB\"></span> <button class=\"bad\" onclick=\"seg('B')\">B touches page 7</button>
<button onclick=\"reset()\">Reset</button>
</div>
<div class=\"row\" style=\"margin-top:10px\">
<div class=\"card\"><b>A's page table</b><div id=\"tA\"></div></div>
<div class=\"card\"><b>B's page table</b><div id=\"tB\"></div></div>
<div class=\"card\"><b>Physical RAM (3 frames)</b><div id=\"ram\"></div></div>
<div class=\"card\"><b>Disk (swap/file)</b><div id=\"disk\"></div></div>
</div>
<div id=\"log\"></div>
<p class=\"note\" id=\"stats\"></p>
<script>
const N=4,F=3;let pt,ram,clock,hits,faults;
function reset(){pt={A:[],B:[]};for(const p of['A','B'])for(let i=0;i<N;i++)pt[p].push({present:false,frame:null});
ram=Array(F).fill(null);clock=0;hits=0;faults=0;document.getElementById('log').innerHTML='';render();say('Start: nothing in RAM. All pages are on disk.','')}
function say(t,c){const l=document.getElementById('log');l.innerHTML+=`<div class=\"${c}\">${t}</div>`;l.scrollTop=1e9}
function access(p,v){clock++;const e=pt[p][v];const va='0x'+(v*4096).toString(16).padStart(4,'0');
 if(e.present){hits++;ram[e.frame].t=clock;say(`${p} reads ${va}: page table says frame ${e.frame}. HIT, no kernel involved.`,'hit');render(p,v);return}
 faults++;say(`${p} reads ${va}: present bit = 0 → PAGE FAULT, kernel runs.`,'flt');
 let f=ram.findIndex(x=>!x);
 if(f<0){f=0;for(let i=1;i<F;i++)if(ram[i].t<ram[f].t)f=i;const o=ram[f];pt[o.p][o.v].present=false;pt[o.p][o.v].frame=null;
  say(`  RAM full: evict LRU frame ${f} (${o.p} page ${o.v}) back to disk, clear its present bit.`,'flt')}
 ram[f]={p,v,t:clock};e.present=true;e.frame=f;
 say(`  load ${p} page ${v} from disk into frame ${f}, set present bit, restart the instruction.`,'flt');render(p,v)}
function seg(p){say(`${p} touches page 7: no table entry → SEGFAULT, kernel kills ${p}. The other process is untouched.`,'seg')}
function render(hp,hv){
 for(const p of['A','B']){let h='<table><tr><th>Virt page</th><th>Present</th><th>Frame</th></tr>';
  pt[p].forEach((e,i)=>h+=`<tr class=\"${hp==p&&hv==i?'hl':''}\"><td>${i}</td><td>${e.present?1:0}</td><td>${e.present?e.frame:'–'}</td></tr>`);
  document.getElementById('t'+p).innerHTML=h+'</table>';
  document.getElementById('b'+p).innerHTML=[...Array(N).keys()].map(i=>`<button class=\"btn${p}\" onclick=\"access('${p}',${i})\">page ${i}</button>`).join('')}
 let r='<table><tr><th>Frame</th><th>Holds</th></tr>';
 ram.forEach((x,i)=>r+=`<tr><td>${i}</td><td class=\"${x?x.p:'free'}\">${x?x.p+' page '+x.v:'free'}</td></tr>`);
 document.getElementById('ram').innerHTML=r+'</table>';
 let d=[];for(const p of['A','B'])pt[p].forEach((e,i)=>{if(!e.present)d.push(`<span class=\"${p}\" style=\"padding:2px 5px;margin:2px;display:inline-block;border-radius:4px\">${p}${i}</span>`)});
 document.getElementById('disk').innerHTML=d.join('');
 document.getElementById('stats').textContent=`Hits: ${hits}  Faults: ${faults}. Try A page 0 and B page 0: same virtual address, different frames.`}
reset();
</script></body></html>"
 :AT "2026-11-15T14:48:54" :VERSION 1)
(:PINNED T :ID "cores-processes-threads-zoomable" :MAP "computers" :NODE "processes-threads" :TYPE
 "html" :TITLE "Cores, processes, threads: zoomable" :LANGUAGE NIL :CONTENT "<!DOCTYPE html>
<html><head><meta charset=\"utf-8\"><meta name=\"viewport\" content=\"width=device-width,initial-scale=1\">
<style>
*{box-sizing:border-box}
body{margin:0;font:14px/1.4 system-ui,sans-serif;background:#0f1220;color:#e8eaf6}
header{display:flex;flex-wrap:wrap;gap:10px;align-items:center;padding:10px 14px;background:#171b30;border-bottom:1px solid #2a3050;position:sticky;top:0;z-index:5}
button,select{background:#252b4a;color:#e8eaf6;border:1px solid #3a4270;border-radius:6px;padding:5px 10px;font:inherit;cursor:pointer}
button:hover{background:#2f3760}
.crumb span{cursor:pointer;color:#8fb4ff}.crumb b{color:#fff}
#stage{padding:14px;max-width:1100px;margin:auto}
.zin{animation:zin .45s ease-out}.zout{animation:zout .45s ease-out}
@keyframes zin{from{transform:scale(.6);opacity:0}to{transform:scale(1);opacity:1}}
@keyframes zout{from{transform:scale(1.35);opacity:0}to{transform:scale(1);opacity:1}}
h3{margin:14px 0 6px;font-size:13px;text-transform:uppercase;letter-spacing:.06em;color:#9aa3d0}
.cores{display:grid;grid-template-columns:repeat(auto-fit,minmax(200px,1fr));gap:10px}
.core{border:2px solid #3a4270;border-radius:12px;padding:10px;background:#181d36;cursor:pointer;transition:.2s}
.core:hover{border-color:#8fb4ff;transform:scale(1.02)}
.core .big{font-size:15px;min-height:42px;border-radius:8px;padding:6px 8px;color:#111;font-weight:600;transition:background .2s}
.idle{background:#2a3050!important;color:#7e86b0!important}
.strip{display:flex;gap:2px;margin-top:8px;height:14px}
.strip i{flex:1;border-radius:2px;background:#2a3050}
.chips{display:flex;flex-wrap:wrap;gap:6px;min-height:30px;padding:6px;border:1px dashed #3a4270;border-radius:8px}
.chip{padding:2px 8px;border-radius:12px;color:#111;font-size:12px;font-weight:600}
.procs{display:grid;grid-template-columns:repeat(auto-fill,minmax(235px,1fr));gap:10px}
.proc{border:2px solid;border-radius:12px;padding:8px 10px;cursor:pointer;background:#161a30;transition:.2s}
.proc:hover{transform:scale(1.03);background:#1d2340}
.proc .t{display:flex;flex-wrap:wrap;gap:4px;margin-top:6px}
.dot{font-size:11px;padding:1px 7px;border-radius:10px;border:1.5px solid}
.dot.run{color:#111;font-weight:700}.dot.ready{background:transparent}.dot.blocked{opacity:.4;border-style:dotted}
.cap{margin:12px 0;padding:10px 12px;background:#1b2140;border-left:4px solid #8fb4ff;border-radius:6px}
.tl{display:flex;gap:3px;margin:6px 0}
.tl div{flex:1;height:46px;border-radius:5px;display:flex;align-items:center;justify-content:center;font-size:11px;color:#111;font-weight:700;text-align:center;overflow:hidden}
.panel{border:2px solid #3a4270;border-radius:12px;padding:12px;margin:8px 0;background:#161a30}
.mem{display:flex;flex-wrap:wrap;gap:8px}
.obj{padding:6px 10px;border-radius:8px;border:2px solid #3a4270;background:#1d2340;transition:.15s}
.threads{display:grid;grid-template-columns:repeat(auto-fit,minmax(220px,1fr));gap:10px}
.th{border:2px solid;border-radius:10px;padding:8px;background:#161a30}
.stack{background:#0d1020;border-radius:6px;padding:4px 6px;font:12px monospace;margin:6px 0}
.stack div{padding:1px 0;color:#8e97c8}.stack .pc{color:#fff;background:#2c3566;border-radius:3px}
.st{font-size:12px;font-weight:700}
.legend{font-size:12px;color:#9aa3d0}
input[type=range]{vertical-align:middle}
</style></head><body>
<header>
 <div class=\"crumb\" id=\"crumb\"></div>
 <span style=\"flex:1\"></span>
 <label>Cores <select id=\"ncores\"><option>1</option><option>2</option><option selected>4</option></select></label>
 <label>Speed <input type=\"range\" id=\"spd\" min=\"1\" max=\"10\" value=\"4\"></label>
 <button id=\"pp\">Pause</button>
</header>
<div id=\"stage\"></div>
<script>
const P=[
 {n:'Minecraft',e:'⛏️',c:'#7ed957',th:[
  ['Render',['draw chunks','draw entities','draw HUD','swap buffers'],'World'],
  ['Chunk gen',['noise(x,z)','carve caves','place ores','save chunk'],'World'],
  ['Game tick',['move mobs','update redstone','grow crops','check inventory'],'Player'],
  ['Audio',['mix sounds','fill buffer','play footstep','mix music'],'Sounds']],
  heap:['World','Player','Sounds']},
 {n:'Fortnite',e:'🪂',c:'#b388ff',th:[
  ['Render',['cull objects','draw players','draw storm','post-fx'],'Scene'],
  ['Network',['send position','recv snapshot','ack packets','predict'],'Match'],
  ['Physics',['step bullets','collide builds','ragdoll','gravity'],'Scene']],
  heap:['Scene','Match']},
 {n:'Rocket League',e:'🚗',c:'#ff9e40',th:[
  ['Render',['draw car','draw ball','draw boost','swap'],'Arena'],
  ['Physics',['ball bounce','car wheels','boost force','collide'],'Arena'],
  ['Net',['recv inputs','send state','resync','ping'],'Score']],
  heap:['Arena','Score']},
 {n:'Stardew Valley',e:'🌾',c:'#ffd54f',th:[
  ['Game loop',['water crops','move NPC','tick clock','draw farm'],'Farm'],
  ['Audio',['play music','bird sfx','fade','mix'],'Farm']],heap:['Farm']},
 {n:'Among Us',e:'🧑‍🚀',c:'#ff5c7a',th:[
  ['Game loop',['move crew','check tasks','vent?','draw map'],'Lobby'],
  ['Network',['recv votes','send chat','sync tasks','ping'],'Lobby']],heap:['Lobby']},
 {n:'Tetris',e:'🟦',c:'#4dd0e1',th:[['Main loop',['drop piece','check line','score','draw'],'Board']],heap:['Board']},
 {n:'Discord',e:'💬',c:'#7c8cff',th:[
  ['UI',['draw chat','scroll','render emoji','typing…'],'Chat'],
  ['Voice',['capture mic','encode opus','send UDP','decode'],'Chat']],heap:['Chat']},
 {n:'Chrome',e:'🌐',c:'#f48fb1',th:[
  ['UI',['draw tab','scroll','click','paint'],'DOM'],
  ['JS',['run script','GC','parse JSON','layout'],'DOM'],
  ['Network',['DNS','TLS','fetch','cache'],'DOM']],heap:['DOM']}
];
const WHY=['disk read','network packet','waiting for input','sleep(16ms)'];
let threads=[],cores=[],queue=[],ncores=4,paused=false,view={t:'m'},tickN=0,timer;
function reset(){
 ncores=+document.getElementById('ncores').value;
 threads=[];let id=0;
 P.forEach((p,pi)=>p.th.forEach(t=>threads.push({id:id++,p:pi,name:t[0],acts:t[1],obj:t[2],st:'ready',core:-1,pc:0,slice:0,wait:0,why:''})));
 cores=Array.from({length:ncores},()=>({cur:null,hist:[],sw:0}));
 queue=threads.map(t=>t.id).sort(()=>Math.random()-.5);tickN=0;
}
function tick(){
 tickN++;
 threads.forEach(t=>{if(t.st==='blocked'&&--t.wait<=0){t.st='ready';queue.push(t.id)}});
 cores.forEach((c,ci)=>{
  if(c.cur!=null){const t=threads[c.cur];t.pc++;t.slice--;
   if(Math.random()<.07){t.st='blocked';t.wait=3+Math.floor(Math.random()*7);t.why=WHY[Math.floor(Math.random()*4)];t.core=-1;c.cur=null}
   else if(t.slice<=0){t.st='ready';t.core=-1;queue.push(t.id);c.cur=null}}
 });
 cores.forEach((c,ci)=>{
  if(c.cur==null&&queue.length){const id=queue.shift(),t=threads[id];t.st='run';t.core=ci;t.slice=4;c.cur=id;
   if(c.hist.length&&c.hist[c.hist.length-1]!=null&&c.hist[c.hist.length-1]!==id)c.sw++;}
  c.hist.push(c.cur);if(c.hist.length>32)c.hist.shift();
 });
 render();
}
const col=t=>P[t.p].c;
const lab=t=>P[t.p].e+' '+P[t.p].n+' · '+t.name;
function go(v,dir){view=v;render(dir)}
function render(anim){
 const s=document.getElementById('stage');
 let h='',cr='';
 if(view.t==='m'){cr='<b>Machine</b>';h=machine()}
 else if(view.t==='c'){cr='<span data-go=\"m\">Machine</span> › <b>Core '+view.i+'</b>';h=coreV()}
 else{cr='<span data-go=\"m\">Machine</span> › <b>'+P[view.i].e+' '+P[view.i].n+' (process)</b>';h=procV()}
 document.getElementById('crumb').innerHTML=cr;
 s.innerHTML=h;
 if(anim){s.className=anim;void s.offsetWidth}
 if(anim)s.className=anim;
}
function machine(){
 let h='<div class=\"cap\"><b>The real picture:</b> cores don\\'t run <i>programs</i>, they run <b>threads</b>. The scheduler keeps a queue of ready threads and hands each one a short time slice on a free core. Click a <b>core</b> to zoom into what it does over time, or a <b>process</b> to zoom into its threads and memory.</div>';
 h+='<h3>'+ncores+' core'+(ncores>1?'s':'')+' (click to zoom)</h3><div class=\"cores\">';
 cores.forEach((c,i)=>{const t=c.cur!=null?threads[c.cur]:null;
  h+='<div class=\"core\" data-core=\"'+i+'\"><div class=\"legend\">Core '+i+' · '+c.sw+' context switches</div><div class=\"big '+(t?'':'idle')+'\" style=\"background:'+(t?col(t):'')+'\">'+(t?lab(t)+'<div style=\"font-weight:400;font-size:12px\">▶ '+t.acts[t.pc%4]+'</div>':'idle')+'</div><div class=\"strip\">'+
  Array.from({length:32},(_,k)=>{const id=c.hist[c.hist.length-32+k];const tt=id!=null?threads[id]:null;return '<i style=\"'+(tt?'background:'+col(tt):'')+'\"></i>'}).join('')+'</div></div>'});
 h+='</div><h3>Ready queue (waiting for a core)</h3><div class=\"chips\">'+queue.map(id=>{const t=threads[id];return '<span class=\"chip\" style=\"background:'+col(t)+'\">'+P[t.p].e+' '+t.name+'</span>'}).join('')+'</div>';
 const bl=threads.filter(t=>t.st==='blocked');
 h+='<h3>Blocked: sleeping, using no CPU</h3><div class=\"chips\">'+bl.map(t=>'<span class=\"chip\" style=\"background:'+col(t)+';opacity:.55\">'+P[t.p].e+' '+t.name+' ⏳ '+t.why+'</span>').join('')+'</div>';
 h+='<h3>Processes: '+P.length+' programs, '+threads.length+' threads (click to zoom)</h3><div class=\"procs\">';
 P.forEach((p,pi)=>{h+='<div class=\"proc\" data-proc=\"'+pi+'\" style=\"border-color:'+p.c+'\"><b>'+p.e+' '+p.n+'</b><div class=\"t\">'+
  threads.filter(t=>t.p===pi).map(t=>'<span class=\"dot '+t.st+'\" style=\"border-color:'+p.c+';'+(t.st==='run'?'background:'+p.c:'')+'\">'+t.name+(t.st==='run'?' @core'+t.core:'')+'</span>').join('')+'</div></div>'});
 h+='</div><p class=\"legend\">Filled = running on a core · outline = ready, waiting · faint dotted = blocked. Try 1 core: still smooth, because slices are tiny, but only <i>concurrent</i>, never <i>parallel</i>.</p>';
 return h;
}
function coreV(){
 const c=cores[view.i]||cores[0];const t=c.cur!=null?threads[c.cur]:null;
 let h='<div class=\"cap\"><b>Zoomed into core '+view.i+'.</b> It has no idea what a \"program\" is. It runs one thread\\'s instructions, then the scheduler saves that thread\\'s registers and program counter and loads another\\'s (a <b>context switch</b>). Neighbouring blocks often belong to <b>different processes</b>, which is why processes aren\\'t pinned to cores.</div>';
 h+='<div class=\"panel\"><b>Now executing:</b><div class=\"big\" style=\"margin-top:8px;padding:12px;border-radius:8px;font-size:17px;font-weight:700;color:#111;background:'+(t?col(t):'#2a3050')+'\">'+(t?lab(t)+' → <span style=\"font-weight:400\">'+t.acts[t.pc%4]+'</span>':'idle: nothing ready')+'</div>'+
 (t?'<div class=\"legend\" style=\"margin-top:6px\">Program counter at \"'+t.acts[t.pc%4]+'\"; slice left: '+t.slice+' ticks; registers belong to this thread only.</div>':'')+'</div>';
 h+='<h3>Last 32 time slices on this core (oldest → newest)</h3><div class=\"tl\">'+
 Array.from({length:32},(_,k)=>{const id=c.hist[c.hist.length-32+k];const tt=id!=null?threads[id]:null;return '<div title=\"'+(tt?lab(tt):'idle')+'\" style=\"'+(tt?'background:'+col(tt):'background:#2a3050')+'\">'+(tt?P[tt.p].e:'')+'</div>'}).join('')+'</div>';
 const seen=[...new Set(c.hist.filter(x=>x!=null))];
 h+='<h3>Threads this core has run recently</h3><div class=\"chips\">'+seen.map(id=>{const t=threads[id];return '<span class=\"chip\" style=\"background:'+col(t)+'\">'+lab(t)+'</span>'}).join('')+'</div>';
 h+='<p class=\"legend\">Context switches here: '+c.sw+'. Each costs a little time, which is why threads are cheaper than processes to switch between: threads of one process keep the same memory mapping.</p>';
 return h;
}
function procV(){
 const p=P[view.i],ts=threads.filter(t=>t.p===view.i);
 const running=ts.filter(t=>t.st==='run');
 let h='<div class=\"cap\"><b>Zoomed into '+p.n+'.</b> One process = one private memory space (top) shared by all its threads, plus a separate program counter and stack per thread (below). '+(running.length>1?'<b>Right now '+running.length+' of its threads are running on different cores: true parallelism.</b>':running.length==1?'Right now one thread is running; the others wait or sleep.':'Right now none of its threads has a core.')+'</div>';
 h+='<div class=\"panel\" style=\"border-color:'+p.c+'\"><b>Shared memory (heap, code, globals):</b> every thread can read/write these<div class=\"mem\" style=\"margin-top:8px\">'+
 p.heap.map(o=>{const w=running.filter(t=>t.obj===o);return '<div class=\"obj\" style=\"'+(w.length?'border-color:'+p.c+';box-shadow:0 0 12px '+p.c+';background:#2a3566':'')+'\">📦 '+o+(w.length?'<div class=\"legend\">touched by '+w.map(t=>t.name).join(', ')+'</div>':'')+'</div>'}).join('')+
 '<div class=\"obj\">📜 game code</div></div><div class=\"legend\" style=\"margin-top:6px\">Two threads touching the same box at once is where race conditions come from. Other processes cannot see this memory at all.</div></div>';
 h+='<h3>Threads: private PC + stack each</h3><div class=\"threads\">'+ts.map(t=>{
  const a=t.acts[t.pc%4];
  return '<div class=\"th\" style=\"border-color:'+p.c+'\"><b>'+t.name+'</b> <span class=\"st\" style=\"color:'+(t.st==='run'?'#7ed957':t.st==='ready'?'#ffd54f':'#ff8a80')+'\">'+(t.st==='run'?'● running on core '+t.core:t.st==='ready'?'○ ready, waiting for a core':'⏳ blocked: '+t.why)+'</span>'+
  '<div class=\"stack\"><div>main()</div><div>'+t.name.toLowerCase().replace(/ /g,'_')+'_loop()</div><div class=\"pc\">▶ PC: '+a+'</div></div><div class=\"legend\">touches shared: '+t.obj+'</div></div>'}).join('')+'</div>';
 return h;
}
document.addEventListener('click',e=>{
 const g=e.target.closest('[data-go]'),c=e.target.closest('[data-core]'),p=e.target.closest('[data-proc]');
 if(g)go({t:'m'},'zout');else if(c)go({t:'c',i:+c.dataset.core},'zin');else if(p)go({t:'p',i:+p.dataset.proc},'zin');
});
document.getElementById('ncores').onchange=()=>{reset();view={t:'m'};render('zout')};
document.getElementById('pp').onclick=e=>{paused=!paused;e.target.textContent=paused?'Resume':'Pause'};
function loop(){clearTimeout(timer);const d=1100-document.getElementById('spd').value*100;timer=setTimeout(()=>{if(!paused)tick();loop()},d)}
reset();for(let i=0;i<5;i++)tick();render();loop();
</script></body></html>
"
 :AT "2026-11-15T15:15:21" :VERSION 1)
(:PINNED T :ID "minecraft-process-stacks-and-heap" :MAP "computers" :NODE "processes-threads" :TYPE
 "svg" :TITLE "Minecraft process: full memory map" :LANGUAGE NIL :CONTENT
 "<svg xmlns=\"http://www.w3.org/2000/svg\" viewBox=\"0 0 960 860\" font-family=\"system-ui,sans-serif\">
<rect width=\"960\" height=\"860\" fill=\"#0f1220\"/>
<rect x=\"15\" y=\"15\" width=\"930\" height=\"830\" rx=\"16\" fill=\"#161a30\" stroke=\"#3a4270\" stroke-width=\"2\"/>
<text x=\"35\" y=\"45\" font-size=\"18\" font-weight=\"700\" fill=\"#e8eaf6\">PROCESS: Minecraft — one private address space (other processes can't see in)</text>

<!-- Threads -->
<text x=\"35\" y=\"78\" font-size=\"14\" font-weight=\"700\" fill=\"#9aa3d0\">① THREADS — private per thread: own PC + own stack</text>

<g font-size=\"12\">
<rect x=\"35\" y=\"90\" width=\"210\" height=\"215\" rx=\"10\" fill=\"#0d1020\" stroke=\"#7ed957\" stroke-width=\"2\"/>
<text x=\"140\" y=\"110\" text-anchor=\"middle\" font-size=\"15\" font-weight=\"700\" fill=\"#7ed957\">Render thread</text>
<text x=\"140\" y=\"127\" text-anchor=\"middle\" fill=\"#9aa3d0\">stack (newest on top)</text>
<rect x=\"48\" y=\"135\" width=\"184\" height=\"30\" rx=\"4\" fill=\"#2c3566\" stroke=\"#fff\"/><text x=\"56\" y=\"154\" fill=\"#fff\">▶ drawBlock() x=3</text>
<rect x=\"48\" y=\"169\" width=\"184\" height=\"30\" rx=\"4\" fill=\"#1d2340\"/><text x=\"56\" y=\"188\" fill=\"#c5cbe8\">drawChunk() id=7</text>
<rect x=\"48\" y=\"203\" width=\"184\" height=\"30\" rx=\"4\" fill=\"#1d2340\"/><text x=\"56\" y=\"222\" fill=\"#c5cbe8\">renderFrame()</text>
<rect x=\"48\" y=\"237\" width=\"184\" height=\"30\" rx=\"4\" fill=\"#1d2340\"/><text x=\"56\" y=\"256\" fill=\"#c5cbe8\">main()</text>
<text x=\"140\" y=\"290\" text-anchor=\"middle\" fill=\"#9aa3d0\">▶ = PC (next line to run)</text>

<rect x=\"255\" y=\"90\" width=\"210\" height=\"215\" rx=\"10\" fill=\"#0d1020\" stroke=\"#ffd54f\" stroke-width=\"2\"/>
<text x=\"360\" y=\"110\" text-anchor=\"middle\" font-size=\"15\" font-weight=\"700\" fill=\"#ffd54f\">Chunk gen thread</text>
<text x=\"360\" y=\"127\" text-anchor=\"middle\" fill=\"#9aa3d0\">its own stack</text>
<rect x=\"268\" y=\"135\" width=\"184\" height=\"30\" rx=\"4\" fill=\"#2c3566\" stroke=\"#fff\"/><text x=\"276\" y=\"154\" fill=\"#fff\">▶ noise() x=40,z=9</text>
<rect x=\"268\" y=\"169\" width=\"184\" height=\"30\" rx=\"4\" fill=\"#1d2340\"/><text x=\"276\" y=\"188\" fill=\"#c5cbe8\">makeChunk()</text>
<rect x=\"268\" y=\"203\" width=\"184\" height=\"30\" rx=\"4\" fill=\"#1d2340\"/><text x=\"276\" y=\"222\" fill=\"#c5cbe8\">genLoop()</text>

<rect x=\"475\" y=\"90\" width=\"210\" height=\"215\" rx=\"10\" fill=\"#0d1020\" stroke=\"#ff9e40\" stroke-width=\"2\"/>
<text x=\"580\" y=\"110\" text-anchor=\"middle\" font-size=\"15\" font-weight=\"700\" fill=\"#ff9e40\">Game tick thread</text>
<text x=\"580\" y=\"127\" text-anchor=\"middle\" fill=\"#9aa3d0\">its own stack</text>
<rect x=\"488\" y=\"135\" width=\"184\" height=\"30\" rx=\"4\" fill=\"#2c3566\" stroke=\"#fff\"/><text x=\"496\" y=\"154\" fill=\"#fff\">▶ moveMob() id=2</text>
<rect x=\"488\" y=\"169\" width=\"184\" height=\"30\" rx=\"4\" fill=\"#1d2340\"/><text x=\"496\" y=\"188\" fill=\"#c5cbe8\">tick()</text>

<rect x=\"695\" y=\"90\" width=\"230\" height=\"215\" rx=\"10\" fill=\"#0d1020\" stroke=\"#b388ff\" stroke-width=\"2\"/>
<text x=\"810\" y=\"110\" text-anchor=\"middle\" font-size=\"15\" font-weight=\"700\" fill=\"#b388ff\">Audio thread</text>
<text x=\"810\" y=\"127\" text-anchor=\"middle\" fill=\"#9aa3d0\">its own stack</text>
<rect x=\"708\" y=\"135\" width=\"204\" height=\"30\" rx=\"4\" fill=\"#2c3566\" stroke=\"#fff\"/><text x=\"716\" y=\"154\" fill=\"#fff\">▶ mix()</text>
<rect x=\"708\" y=\"169\" width=\"204\" height=\"30\" rx=\"4\" fill=\"#1d2340\"/><text x=\"716\" y=\"188\" fill=\"#c5cbe8\">audioLoop()</text>
</g>

<text x=\"35\" y=\"328\" font-size=\"12\" fill=\"#9aa3d0\">Stack = locals, arguments, return addresses. Freed automatically when each function returns. Never shared unless you hand out a pointer.</text>

<!-- Shared -->
<rect x=\"25\" y=\"345\" width=\"910\" height=\"485\" rx=\"12\" fill=\"none\" stroke=\"#8fb4ff\" stroke-width=\"2\" stroke-dasharray=\"8 5\"/>
<text x=\"40\" y=\"368\" font-size=\"14\" font-weight=\"700\" fill=\"#8fb4ff\">SHARED BY ALL THREADS — one copy, every thread can reach it</text>

<!-- Code -->
<rect x=\"40\" y=\"385\" width=\"880\" height=\"95\" rx=\"10\" fill=\"#1d2a22\" stroke=\"#7ed957\" stroke-width=\"2\"/>
<text x=\"55\" y=\"408\" font-size=\"15\" font-weight=\"700\" fill=\"#7ed957\">② CODE (text segment) — read-only</text>
<text x=\"55\" y=\"430\" font-size=\"12\" fill=\"#c5cbe8\">The compiled instructions: drawBlock, noise, moveMob, mix … Loaded once from the program file.</text>
<text x=\"55\" y=\"450\" font-size=\"12\" fill=\"#c5cbe8\">Every thread's PC points into here. Two threads can run the same function at once, each with its own stack frame.</text>
<text x=\"55\" y=\"468\" font-size=\"12\" fill=\"#9aa3d0\">Lives: whole run · Size: fixed</text>

<!-- Globals -->
<rect x=\"40\" y=\"495\" width=\"880\" height=\"105\" rx=\"10\" fill=\"#2a2418\" stroke=\"#ffd54f\" stroke-width=\"2\"/>
<text x=\"55\" y=\"518\" font-size=\"15\" font-weight=\"700\" fill=\"#ffd54f\">③ GLOBALS / STATIC DATA (.data, .bss)</text>
<text x=\"55\" y=\"540\" font-size=\"12\" fill=\"#c5cbe8\">Named variables written in the source: static int frameCount;  World* theWorld;  const text like \"Creeper\".</text>
<rect x=\"55\" y=\"550\" width=\"150\" height=\"38\" rx=\"6\" fill=\"#3a3220\" stroke=\"#fff\"/><text x=\"130\" y=\"574\" text-anchor=\"middle\" font-size=\"13\" fill=\"#fff\">frameCount = 9041</text>
<rect x=\"220\" y=\"550\" width=\"150\" height=\"38\" rx=\"6\" fill=\"#3a3220\" stroke=\"#fff\"/><text x=\"295\" y=\"574\" text-anchor=\"middle\" font-size=\"13\" fill=\"#fff\">theWorld = 0x7f3a…</text>
<text x=\"390\" y=\"574\" font-size=\"12\" fill=\"#9aa3d0\">Lives: whole run · Size: fixed at compile time · Writes can race</text>

<!-- Heap -->
<rect x=\"40\" y=\"615\" width=\"880\" height=\"200\" rx=\"10\" fill=\"#1b2140\" stroke=\"#8fb4ff\" stroke-width=\"2.5\"/>
<text x=\"55\" y=\"638\" font-size=\"15\" font-weight=\"700\" fill=\"#8fb4ff\">④ HEAP — objects made at runtime with new / malloc</text>
<rect x=\"55\" y=\"652\" width=\"250\" height=\"70\" rx=\"8\" fill=\"#252b4a\" stroke=\"#fff\"/>
<text x=\"180\" y=\"679\" text-anchor=\"middle\" font-size=\"15\" font-weight=\"700\" fill=\"#fff\">World</text>
<text x=\"180\" y=\"702\" text-anchor=\"middle\" font-size=\"12\" fill=\"#c5cbe8\">chunks[], chunkCount</text>
<rect x=\"325\" y=\"652\" width=\"170\" height=\"70\" rx=\"8\" fill=\"#252b4a\" stroke=\"#fff\"/>
<text x=\"410\" y=\"679\" text-anchor=\"middle\" font-size=\"15\" font-weight=\"700\" fill=\"#fff\">Player</text>
<text x=\"410\" y=\"702\" text-anchor=\"middle\" font-size=\"12\" fill=\"#c5cbe8\">position, inventory</text>
<rect x=\"515\" y=\"652\" width=\"170\" height=\"70\" rx=\"8\" fill=\"#252b4a\" stroke=\"#fff\"/>
<text x=\"600\" y=\"679\" text-anchor=\"middle\" font-size=\"15\" font-weight=\"700\" fill=\"#fff\">Sounds</text>
<text x=\"600\" y=\"702\" text-anchor=\"middle\" font-size=\"12\" fill=\"#c5cbe8\">audio buffers</text>
<rect x=\"705\" y=\"652\" width=\"200\" height=\"70\" rx=\"8\" fill=\"#1b2140\" stroke=\"#8fb4ff\" stroke-dasharray=\"4 3\"/>
<text x=\"805\" y=\"684\" text-anchor=\"middle\" font-size=\"12\" fill=\"#8fb4ff\">+ thousands more chunks,</text>
<text x=\"805\" y=\"702\" text-anchor=\"middle\" font-size=\"12\" fill=\"#8fb4ff\">mobs, items…</text>
<text x=\"55\" y=\"750\" font-size=\"12\" fill=\"#c5cbe8\">Created while running, any size, freed when you say so (or a garbage collector does). Reached only through a pointer.</text>
<text x=\"55\" y=\"772\" font-size=\"12\" fill=\"#c5cbe8\">Pointers live in stacks or globals: theWorld (global) → World (heap). Render and Chunk gen both follow it.</text>
<text x=\"55\" y=\"800\" font-size=\"13\" font-weight=\"700\" fill=\"#ffb4c0\">⚠ Render + Chunk gen both write World at once → needs a lock. Globals and heap are the danger zones.</text>

<!-- arrows from stacks to shared (pointers) -->
<g fill=\"none\" stroke-width=\"2.2\" stroke-dasharray=\"6 4\">
<path d=\"M140 305 L140 640 L60 640\" stroke=\"#7ed957\" opacity=\"0\"/>
<path d=\"M120 305 Q 30 480 80 652\" stroke=\"#7ed957\"/>
<path d=\"M360 305 Q 320 500 230 652\" stroke=\"#ffd54f\"/>
<path d=\"M580 305 Q 560 480 410 652\" stroke=\"#ff9e40\"/>
<path d=\"M810 305 Q 790 500 620 652\" stroke=\"#b388ff\"/>
</g>
<text x=\"460\" y=\"340\" text-anchor=\"middle\" font-size=\"11\" fill=\"#9aa3d0\">dashed arrows = pointers from a stack into shared memory</text>
</svg>"
 :AT "2026-11-15T15:55:09" :VERSION 2)
(:PINNED T :ID "the-abstraction-ladder-so-far" :MAP "computers" :NODE "files" :TYPE "svg" :TITLE
 "The abstraction ladder so far" :LANGUAGE NIL :CONTENT
 "<svg xmlns=\"http://www.w3.org/2000/svg\" viewBox=\"0 0 900 640\" font-family=\"system-ui, sans-serif\">
<rect width=\"900\" height=\"640\" fill=\"#fafafa\"/>
<text x=\"450\" y=\"34\" text-anchor=\"middle\" font-size=\"20\" font-weight=\"bold\" fill=\"#222\">The abstraction ladder: each rung hides the one below</text>
<defs><marker id=\"a\" markerWidth=\"10\" markerHeight=\"10\" refX=\"5\" refY=\"5\" orient=\"auto\"><path d=\"M0,9 L5,0 L10,9 z\" fill=\"#555\"/></marker></defs>

<!-- rungs, bottom to top -->
<g>
<rect x=\"60\" y=\"520\" width=\"520\" height=\"70\" rx=\"10\" fill=\"#fde7c8\" stroke=\"#d98a1f\" stroke-width=\"2\"/>
<text x=\"80\" y=\"548\" font-size=\"17\" font-weight=\"bold\" fill=\"#7a4a00\">1. Transistors</text>
<text x=\"80\" y=\"574\" font-size=\"14\" fill=\"#5a3a00\">Switches: voltage in, on/off out</text>

<rect x=\"100\" y=\"425\" width=\"480\" height=\"70\" rx=\"10\" fill=\"#fff3b8\" stroke=\"#c9a800\" stroke-width=\"2\"/>
<text x=\"120\" y=\"453\" font-size=\"17\" font-weight=\"bold\" fill=\"#5e5000\">2. Gates, flip-flops, RAM, clock</text>
<text x=\"120\" y=\"479\" font-size=\"14\" fill=\"#5e5000\">Switches combine into logic and 1-bit memory</text>

<rect x=\"140\" y=\"330\" width=\"440\" height=\"70\" rx=\"10\" fill=\"#d9f2d0\" stroke=\"#4a9a35\" stroke-width=\"2\"/>
<text x=\"160\" y=\"358\" font-size=\"17\" font-weight=\"bold\" fill=\"#1f5a10\">3. Stored program: CPU + RAM</text>
<text x=\"160\" y=\"384\" font-size=\"14\" fill=\"#1f5a10\">Instructions are data; fetch, decode, execute</text>

<rect x=\"180\" y=\"235\" width=\"400\" height=\"70\" rx=\"10\" fill=\"#cfe9f7\" stroke=\"#2a85b8\" stroke-width=\"2\"/>
<text x=\"200\" y=\"263\" font-size=\"17\" font-weight=\"bold\" fill=\"#0d4a6b\">4. Processes, scheduling, virtual memory</text>
<text x=\"200\" y=\"289\" font-size=\"14\" fill=\"#0d4a6b\">Each program believes it owns the machine</text>

<rect x=\"220\" y=\"140\" width=\"360\" height=\"70\" rx=\"10\" fill=\"#e6d6f5\" stroke=\"#8a4fc0\" stroke-width=\"2\"/>
<text x=\"240\" y=\"168\" font-size=\"17\" font-weight=\"bold\" fill=\"#4a1f78\">5. Files (you are here)</text>
<text x=\"240\" y=\"194\" font-size=\"14\" fill=\"#4a1f78\">Named, persistent bytes; directories nest names</text>
</g>

<!-- arrow -->
<line x1=\"40\" y1=\"590\" x2=\"40\" y2=\"130\" stroke=\"#555\" stroke-width=\"3\" marker-end=\"url(#a)\"/>
<text x=\"22\" y=\"360\" font-size=\"13\" fill=\"#555\" transform=\"rotate(-90 22 360)\" text-anchor=\"middle\">more powerful, fewer details needed</text>

<!-- right side: what each rung lets you forget -->
<g font-size=\"13\" fill=\"#333\">
<text x=\"610\" y=\"110\" font-weight=\"bold\" font-size=\"14\">What you can forget at this rung</text>
<text x=\"610\" y=\"165\">Disk blocks, sectors, device drivers;</text><text x=\"610\" y=\"183\">\"file\" covers disks, pipes, sockets</text>
<text x=\"610\" y=\"260\">Other programs, physical RAM size,</text><text x=\"610\" y=\"278\">which core runs you</text>
<text x=\"610\" y=\"355\">Wiring: just run instructions</text><text x=\"610\" y=\"373\">from memory</text>
<text x=\"610\" y=\"450\">Voltages, transistor layout:</text><text x=\"610\" y=\"468\">just 0/1 and AND/OR/NOT</text>
<text x=\"610\" y=\"545\">Physics of silicon:</text><text x=\"610\" y=\"563\">just a switch</text>
</g>
<g stroke=\"#bbb\" stroke-dasharray=\"4 4\">
<line x1=\"585\" y1=\"175\" x2=\"605\" y2=\"175\"/><line x1=\"585\" y1=\"270\" x2=\"605\" y2=\"270\"/><line x1=\"585\" y1=\"365\" x2=\"605\" y2=\"365\"/><line x1=\"585\" y1=\"460\" x2=\"605\" y2=\"460\"/><line x1=\"585\" y1=\"555\" x2=\"605\" y2=\"555\"/>
</g>
<text x=\"450\" y=\"620\" text-anchor=\"middle\" font-size=\"13\" fill=\"#666\">Note the pyramid: each layer is built only from the one beneath it.</text>
</svg>"
 :AT "2026-11-15T16:13:01" :VERSION 1)
(:PINNED T :ID "hardware-vs-software-data-paths" :MAP "computers" :NODE "files" :TYPE "svg" :TITLE
 "Hardware vs software data paths" :LANGUAGE NIL :CONTENT
 "<svg xmlns=\"http://www.w3.org/2000/svg\" viewBox=\"0 0 1000 720\" font-family=\"system-ui, sans-serif\">
<rect width=\"1000\" height=\"720\" fill=\"#fafafa\"/>
<text x=\"500\" y=\"30\" text-anchor=\"middle\" font-size=\"20\" font-weight=\"bold\" fill=\"#222\">Data-transfer terms: wired hardware vs software labels</text>

<!-- Software -->
<rect x=\"30\" y=\"50\" width=\"940\" height=\"330\" rx=\"12\" fill=\"#e6d6f5\" stroke=\"#8a4fc0\" stroke-width=\"2\"/>
<text x=\"50\" y=\"78\" font-size=\"16\" font-weight=\"bold\" fill=\"#4a1f78\">SOFTWARE: kernel abstractions, changeable by code</text>
<g font-size=\"13\" fill=\"#2a1048\">
<rect x=\"50\" y=\"95\" width=\"210\" height=\"130\" rx=\"8\" fill=\"#fff\" stroke=\"#8a4fc0\"/>
<text x=\"62\" y=\"118\" font-weight=\"bold\" font-size=\"14\">File descriptor</text>
<text x=\"62\" y=\"140\">Small integer handle.</text><text x=\"62\" y=\"158\">read / write work on all</text><text x=\"62\" y=\"176\">of the ideas beside it.</text><text x=\"62\" y=\"200\" font-style=\"italic\">The common interface</text>

<rect x=\"275\" y=\"95\" width=\"210\" height=\"130\" rx=\"8\" fill=\"#fff\" stroke=\"#8a4fc0\"/>
<text x=\"287\" y=\"118\" font-weight=\"bold\" font-size=\"14\">Pipe</text>
<text x=\"287\" y=\"140\">One-way buffer in RAM</text><text x=\"287\" y=\"158\">between processes on</text><text x=\"287\" y=\"176\">the same machine.</text><text x=\"287\" y=\"200\" font-style=\"italic\">ls | grep foo</text>

<rect x=\"500\" y=\"95\" width=\"210\" height=\"130\" rx=\"8\" fill=\"#fff\" stroke=\"#8a4fc0\"/>
<text x=\"512\" y=\"118\" font-weight=\"bold\" font-size=\"14\">Socket</text>
<text x=\"512\" y=\"140\">One end of a two-way</text><text x=\"512\" y=\"158\">stream; can reach other</text><text x=\"512\" y=\"176\">machines (TCP/UDP).</text><text x=\"512\" y=\"200\" font-style=\"italic\">Unix socket: same machine</text>

<rect x=\"725\" y=\"95\" width=\"225\" height=\"130\" rx=\"8\" fill=\"#fff\" stroke=\"#8a4fc0\"/>
<text x=\"737\" y=\"118\" font-weight=\"bold\" font-size=\"14\">Port (network)</text>
<text x=\"737\" y=\"140\">16-bit number in an</text><text x=\"737\" y=\"158\">address: picks which</text><text x=\"737\" y=\"176\">socket gets the packet.</text><text x=\"737\" y=\"200\" font-style=\"italic\">Not a channel; a label</text>

<rect x=\"50\" y=\"245\" width=\"320\" height=\"115\" rx=\"8\" fill=\"#fff\" stroke=\"#8a4fc0\"/>
<text x=\"62\" y=\"268\" font-weight=\"bold\" font-size=\"14\">Others: signals, shared memory,</text>
<text x=\"62\" y=\"286\" font-weight=\"bold\" font-size=\"14\">message queues</text>
<text x=\"62\" y=\"310\">Other ways for processes to talk:</text><text x=\"62\" y=\"328\">a nudge, or RAM both can see.</text>

<rect x=\"385\" y=\"245\" width=\"270\" height=\"115\" rx=\"8\" fill=\"#fff\" stroke=\"#8a4fc0\"/>
<text x=\"397\" y=\"268\" font-weight=\"bold\" font-size=\"14\">Protocols: TCP, IP, HTTP</text>
<text x=\"397\" y=\"292\">Agreed rules for bytes on</text><text x=\"397\" y=\"310\">a wire. Code, not wire.</text>

<rect x=\"670\" y=\"245\" width=\"280\" height=\"115\" rx=\"8\" fill=\"#fff\" stroke=\"#8a4fc0\"/>
<text x=\"682\" y=\"268\" font-weight=\"bold\" font-size=\"14\">Device driver + pty</text>
<text x=\"682\" y=\"292\">Driver: kernel code that talks</text><text x=\"682\" y=\"310\">to one piece of hardware.</text><text x=\"682\" y=\"328\">pty: fake terminal wire.</text>
</g>

<!-- boundary -->
<line x1=\"30\" y1=\"400\" x2=\"970\" y2=\"400\" stroke=\"#333\" stroke-width=\"2\" stroke-dasharray=\"8 5\"/>
<text x=\"500\" y=\"396\" text-anchor=\"middle\" font-size=\"13\" fill=\"#333\">system calls and drivers: the boundary</text>
<text x=\"500\" y=\"418\" text-anchor=\"middle\" font-size=\"22\" fill=\"#333\">▲ ▼</text>

<!-- Hardware -->
<rect x=\"30\" y=\"435\" width=\"940\" height=\"260\" rx=\"12\" fill=\"#fde7c8\" stroke=\"#d98a1f\" stroke-width=\"2\"/>
<text x=\"50\" y=\"463\" font-size=\"16\" font-weight=\"bold\" fill=\"#7a4a00\">HARDWARE: physical wires and chips, fixed by the electronics</text>
<g font-size=\"13\" fill=\"#4a2a00\">
<rect x=\"50\" y=\"480\" width=\"210\" height=\"195\" rx=\"8\" fill=\"#fff\" stroke=\"#d98a1f\"/>
<text x=\"62\" y=\"503\" font-weight=\"bold\" font-size=\"14\">Buses</text>
<text x=\"62\" y=\"525\">Shared parallel wires</text><text x=\"62\" y=\"543\">+ electrical rules.</text><text x=\"62\" y=\"567\">Memory bus: CPU to RAM</text><text x=\"62\" y=\"585\">PCIe: CPU to GPU, SSD</text><text x=\"62\" y=\"603\">(PCIe is point-to-point</text><text x=\"62\" y=\"621\">lanes, bus-like)</text>

<rect x=\"275\" y=\"480\" width=\"210\" height=\"195\" rx=\"8\" fill=\"#fff\" stroke=\"#d98a1f\"/>
<text x=\"287\" y=\"503\" font-weight=\"bold\" font-size=\"14\">Physical ports</text>
<text x=\"287\" y=\"525\">Connectors + controllers:</text><text x=\"287\" y=\"543\">USB, HDMI, Ethernet jack.</text><text x=\"287\" y=\"567\">Same word as network</text><text x=\"287\" y=\"585\">port, unrelated idea.</text>

<rect x=\"500\" y=\"480\" width=\"210\" height=\"195\" rx=\"8\" fill=\"#fff\" stroke=\"#d98a1f\"/>
<text x=\"512\" y=\"503\" font-weight=\"bold\" font-size=\"14\">Links and radios</text>
<text x=\"512\" y=\"525\">Ethernet cable, Wi-Fi,</text><text x=\"512\" y=\"543\">fibre, serial line.</text><text x=\"512\" y=\"567\">Carry the bits that sockets</text><text x=\"512\" y=\"585\">eventually send.</text>

<rect x=\"725\" y=\"480\" width=\"225\" height=\"195\" rx=\"8\" fill=\"#fff\" stroke=\"#d98a1f\"/>
<text x=\"737\" y=\"503\" font-weight=\"bold\" font-size=\"14\">Controllers and devices</text>
<text x=\"737\" y=\"525\">NIC, disk controller,</text><text x=\"737\" y=\"543\">interrupt wires, DMA.</text><text x=\"737\" y=\"567\">Chips that move bits</text><text x=\"737\" y=\"585\">without the CPU copying.</text>
</g>
<text x=\"500\" y=\"712\" text-anchor=\"middle\" font-size=\"12\" fill=\"#666\">Rule of thumb: if you must unplug or resolder it, hardware. If code can create it, software.</text>
</svg>"
 :AT "2026-11-16T11:45:27" :VERSION 1)
(:PINNED T :ID "terminal-shell-bash-and-the-kernel" :MAP "computers" :NODE "files" :TYPE "svg"
 :TITLE "Onion of layers: keystroke to kernel" :LANGUAGE NIL :CONTENT
 "<svg xmlns=\"http://www.w3.org/2000/svg\" viewBox=\"0 0 1300 800\" font-family=\"system-ui, sans-serif\">
<rect width=\"1300\" height=\"800\" fill=\"#fafafa\"/>
<defs>
<marker id=\"in\" markerWidth=\"8\" markerHeight=\"8\" refX=\"7\" refY=\"4\" orient=\"auto\"><path d=\"M0,0 L8,4 L0,8 z\" fill=\"#c0392b\"/></marker>
<marker id=\"out\" markerWidth=\"8\" markerHeight=\"8\" refX=\"7\" refY=\"4\" orient=\"auto\"><path d=\"M0,0 L8,4 L0,8 z\" fill=\"#2a6db8\"/></marker>
<path id=\"sysarc\" d=\"M242.1,352.5 A168,168 0 0 1 342.5,252.1\" fill=\"none\"/>
</defs>

<!-- rings, outside to inside -->
<circle cx=\"400\" cy=\"410\" r=\"385\" fill=\"#ffe3e3\" stroke=\"#d04545\" stroke-width=\"2\"/>
<circle cx=\"400\" cy=\"410\" r=\"325\" fill=\"#e6d6f5\" stroke=\"#8a4fc0\" stroke-width=\"2\"/>
<circle cx=\"400\" cy=\"410\" r=\"270\" fill=\"#cfe9f7\" stroke=\"#2a85b8\" stroke-width=\"2\"/>
<circle cx=\"400\" cy=\"410\" r=\"210\" fill=\"#fff3b8\" stroke=\"#c9a800\" stroke-width=\"2\"/>
<circle cx=\"400\" cy=\"410\" r=\"160\" fill=\"#d9f2d0\" stroke=\"#333\" stroke-width=\"3\" stroke-dasharray=\"9 5\"/>
<circle cx=\"400\" cy=\"410\" r=\"60\" fill=\"#fde7c8\" stroke=\"#d98a1f\" stroke-width=\"2\"/>

<!-- ring labels -->
<g text-anchor=\"middle\">
<text x=\"400\" y=\"48\" font-size=\"14\" font-weight=\"bold\" fill=\"#7a1a1a\">YOU + I/O devices</text>
<text x=\"400\" y=\"67\" font-size=\"12\" fill=\"#7a1a1a\">keyboard, mouse, screen</text>

<text x=\"400\" y=\"106\" font-size=\"13\" font-weight=\"bold\" fill=\"#4a1f78\">Terminal emulator · GUI apps</text>
<text x=\"400\" y=\"125\" font-size=\"12\" fill=\"#4a1f78\">browser, editor, display server</text>

<text x=\"400\" y=\"160\" font-size=\"13\" font-weight=\"bold\" fill=\"#0d4a6b\">Shell + its programs</text>
<text x=\"400\" y=\"178\" font-size=\"12\" fill=\"#0d4a6b\">bash · ls · grep · python</text>

<text x=\"400\" y=\"222\" font-size=\"13\" font-weight=\"bold\" fill=\"#5e5000\">Libraries (libc)</text>
<text x=\"400\" y=\"240\" font-size=\"12\" fill=\"#5e5000\">wrap system calls</text>

<text x=\"400\" y=\"272\" font-size=\"14\" font-weight=\"bold\" fill=\"#1f5a10\">KERNEL</text>
<text x=\"400\" y=\"290\" font-size=\"12\" fill=\"#1f5a10\">files · processes · memory</text>
<text x=\"400\" y=\"306\" font-size=\"12\" fill=\"#1f5a10\">pipes · sockets · ptys · drivers</text>
<text x=\"400\" y=\"322\" font-size=\"12\" fill=\"#1f5a10\">permission checks</text>

<text x=\"400\" y=\"388\" font-size=\"12\" font-weight=\"bold\" fill=\"#7a4a00\">HARDWARE</text>
<text x=\"400\" y=\"404\" font-size=\"12\" fill=\"#7a4a00\">CPU · RAM</text>
<text x=\"400\" y=\"420\" font-size=\"12\" fill=\"#7a4a00\">disk · NIC</text>
</g>

<!-- system-call boundary label, bent along the kernel border at 10-11 o'clock -->
<text font-size=\"13\" font-weight=\"bold\" fill=\"#333\" letter-spacing=\"0.5\" stroke=\"#fff3b8\" stroke-width=\"3\" paint-order=\"stroke\">
<textPath href=\"#sysarc\" startOffset=\"50%\" text-anchor=\"middle\">system-call boundary</textPath>
</text>

<!-- journey segments, in the 1-2 o'clock wedge: step 1 nearest 1 o'clock, step 7 nearest 2 o'clock -->
<g stroke-width=\"2.5\" fill=\"none\">
<line x1=\"574\" y1=\"109.7\" x2=\"484\" y2=\"287\" stroke=\"#c0392b\" marker-end=\"url(#in)\"/>
<line x1=\"486.4\" y1=\"289.9\" x2=\"581.4\" y2=\"192.7\" stroke=\"#2a6db8\" marker-end=\"url(#out)\"/>
<line x1=\"583.2\" y1=\"192.9\" x2=\"503.9\" y2=\"303.3\" stroke=\"#c0392b\" marker-end=\"url(#in)\"/>
<line x1=\"506.1\" y1=\"307\" x2=\"572.3\" y2=\"263.7\" stroke=\"#2a6db8\" marker-end=\"url(#out)\"/>
<line x1=\"574\" y1=\"264.3\" x2=\"453.1\" y2=\"370.8\" stroke=\"#c0392b\" marker-end=\"url(#in)\"/>
<line x1=\"451.1\" y1=\"373.8\" x2=\"695.2\" y2=\"239.3\" stroke=\"#2a6db8\" marker-end=\"url(#out)\"/>
</g>
<g font-size=\"12\" font-weight=\"bold\" fill=\"#fff\" text-anchor=\"middle\">
<circle cx=\"580\" cy=\"98\" r=\"11\" fill=\"#333\"/><text x=\"580\" y=\"102\">1</text>
<circle cx=\"477.5\" cy=\"299.4\" r=\"11\" fill=\"#333\"/><text x=\"477.5\" y=\"303.4\">2</text>
<circle cx=\"591\" cy=\"182.5\" r=\"11\" fill=\"#333\"/><text x=\"591\" y=\"186.5\">3</text>
<circle cx=\"495.5\" cy=\"314.5\" r=\"11\" fill=\"#333\"/><text x=\"495.5\" y=\"318.5\">4</text>
<circle cx=\"583.8\" cy=\"255.7\" r=\"11\" fill=\"#333\"/><text x=\"583.8\" y=\"259.7\">5</text>
<circle cx=\"443\" cy=\"380\" r=\"11\" fill=\"#333\"/><text x=\"443\" y=\"384\">6</text>
<circle cx=\"707.4\" cy=\"232.5\" r=\"11\" fill=\"#333\"/><text x=\"707.4\" y=\"236.5\">7</text>
</g>

<!-- right panel -->
<text x=\"830\" y=\"40\" font-size=\"18\" font-weight=\"bold\" fill=\"#222\">One keystroke zigzags through the onion</text>
<text x=\"830\" y=\"62\" font-size=\"13\" fill=\"#666\">Press a key, then Enter on \"ls\": in, out, in, out</text>
<g font-size=\"12.5\" fill=\"#222\">
<text x=\"830\" y=\"100\" font-weight=\"bold\">1</text><text x=\"850\" y=\"100\">Key pressed. Keyboard hardware raises an</text><text x=\"850\" y=\"117\">interrupt, pulling control inward.</text>
<text x=\"830\" y=\"156\" font-weight=\"bold\">2</text><text x=\"850\" y=\"156\">Kernel keyboard driver reads the key and</text><text x=\"850\" y=\"173\">queues an input event.</text>
<text x=\"830\" y=\"212\" font-weight=\"bold\">3</text><text x=\"850\" y=\"212\">Display server gives the event to the terminal</text><text x=\"850\" y=\"229\">emulator: an ordinary program, outer ring.</text>
<text x=\"830\" y=\"268\" font-weight=\"bold\">4</text><text x=\"850\" y=\"268\">Terminal calls write() on the pty; the kernel</text><text x=\"850\" y=\"285\">carries the byte to the shell's end of it.</text>
<text x=\"830\" y=\"324\" font-weight=\"bold\">5</text><text x=\"850\" y=\"324\">Shell's read() returns the byte. On Enter it</text><text x=\"850\" y=\"341\">fork/execs ls, still in user space.</text>
<text x=\"830\" y=\"380\" font-weight=\"bold\">6</text><text x=\"850\" y=\"380\">ls open()s and read()s the directory: kernel</text><text x=\"850\" y=\"397\">file code asks the disk, in the hardware core.</text>
<text x=\"830\" y=\"436\" font-weight=\"bold\">7</text><text x=\"850\" y=\"436\">ls write()s the names to the pty; the terminal</text><text x=\"850\" y=\"453\">draws them and the screen shows pixels.</text>
</g>

<line x1=\"830\" y1=\"490\" x2=\"880\" y2=\"490\" stroke=\"#c0392b\" stroke-width=\"2.5\" marker-end=\"url(#in)\"/>
<text x=\"892\" y=\"494\" font-size=\"12.5\" fill=\"#222\">inward: system call or interrupt</text>
<line x1=\"830\" y1=\"514\" x2=\"880\" y2=\"514\" stroke=\"#2a6db8\" stroke-width=\"2.5\" marker-end=\"url(#out)\"/>
<text x=\"892\" y=\"518\" font-size=\"12.5\" fill=\"#222\">outward: result handed back up</text>

<text x=\"830\" y=\"560\" font-size=\"14\" font-weight=\"bold\" fill=\"#222\">How to read the rings</text>
<g font-size=\"12.5\" fill=\"#333\">
<text x=\"830\" y=\"584\">• A ring uses only the ring just inside it, through a</text><text x=\"840\" y=\"601\">fixed interface (system calls, pty, files).</text>
<text x=\"830\" y=\"627\">• Only the dashed ring holds hardware privilege.</text><text x=\"840\" y=\"644\">Everything outside it runs with your user's rights.</text>
<text x=\"830\" y=\"670\">• Rings can be skipped, not breached: a GUI file</text><text x=\"840\" y=\"687\">manager skips the shell, but still needs system calls.</text>
<text x=\"830\" y=\"713\">• bash, zsh, fish share one ring: same job, same rights.</text>
<text x=\"830\" y=\"739\">• Rights come from your user ID, checked in the kernel,</text><text x=\"840\" y=\"756\">not by the terminal or shell.</text>
</g>
</svg>"
 :AT "2026-11-16T12:46:27" :VERSION 4)
(:PINNED T :ID "client-network-cloud-vertical-stack" :MAP "computers" :NODE "files" :TYPE "svg"
 :TITLE "Client, Network, Cloud: vertical stack" :LANGUAGE NIL :CONTENT
 "<svg xmlns=\"http://www.w3.org/2000/svg\" viewBox=\"0 0 1000 790\" font-family=\"system-ui, sans-serif\">
<rect width=\"1000\" height=\"790\" fill=\"#fafafa\"/>
<text x=\"500\" y=\"30\" text-anchor=\"middle\" font-size=\"20\" font-weight=\"bold\" fill=\"#222\">Modern computing: applications on client, network and cloud</text>
<defs><marker id=\"ar\" markerWidth=\"8\" markerHeight=\"8\" refX=\"4\" refY=\"4\" orient=\"auto-start-reverse\"><path d=\"M0,0 L8,4 L0,8 z\" fill=\"#555\"/></marker></defs>

<rect x=\"40\" y=\"46\" width=\"920\" height=\"64\" rx=\"10\" fill=\"#ffe3e3\" stroke=\"#d04545\" stroke-width=\"2\"/>
<text x=\"60\" y=\"72\" font-size=\"16\" font-weight=\"bold\" fill=\"#7a1a1a\">APPLICATIONS: where economic value is made</text>
<text x=\"60\" y=\"94\" font-size=\"13\" fill=\"#7a1a1a\">Chat assistants, coding agents, search, shopping, banking, games, workflow tools: each is a client piece plus a cloud piece</text>
<line x1=\"500\" y1=\"112\" x2=\"500\" y2=\"126\" stroke=\"#555\" stroke-width=\"2\" marker-end=\"url(#ar)\" marker-start=\"url(#ar)\"/>

<rect x=\"40\" y=\"128\" width=\"920\" height=\"150\" rx=\"10\" fill=\"#f3ecfa\" stroke=\"#8a4fc0\" stroke-width=\"2\"/>
<text x=\"55\" y=\"152\" font-size=\"16\" font-weight=\"bold\" fill=\"#4a1f78\">CLIENT</text>
<text x=\"125\" y=\"152\" font-size=\"12.5\" fill=\"#666\">where the human and the sensors are</text>
<g font-size=\"12.5\" fill=\"#4a1f78\">
<rect x=\"55\" y=\"165\" width=\"205\" height=\"100\" rx=\"8\" fill=\"#e6d6f5\" stroke=\"#8a4fc0\"/>
<text x=\"67\" y=\"187\" font-weight=\"bold\">Hardware devices</text><text x=\"67\" y=\"208\">Phone, laptop, headset, car,</text><text x=\"67\" y=\"225\">watch, IoT. CPU + GPU + NPU,</text><text x=\"67\" y=\"242\">RAM, screen, sensors, battery</text>
<rect x=\"280\" y=\"165\" width=\"205\" height=\"100\" rx=\"8\" fill=\"#e6d6f5\" stroke=\"#8a4fc0\"/>
<text x=\"292\" y=\"187\" font-weight=\"bold\">Operating system</text><text x=\"292\" y=\"208\">Files, processes, permissions,</text><text x=\"292\" y=\"225\">sandbox, drivers,</text><text x=\"292\" y=\"242\">network stack</text>
<rect x=\"505\" y=\"165\" width=\"205\" height=\"100\" rx=\"8\" fill=\"#e6d6f5\" stroke=\"#8a4fc0\"/>
<text x=\"517\" y=\"187\" font-weight=\"bold\">Software on the OS</text><text x=\"517\" y=\"208\">Browser, native apps,</text><text x=\"517\" y=\"225\">local agents, on-device</text><text x=\"517\" y=\"242\">small models</text>
<rect x=\"730\" y=\"165\" width=\"205\" height=\"100\" rx=\"8\" fill=\"#e6d6f5\" stroke=\"#8a4fc0\"/>
<text x=\"742\" y=\"187\" font-weight=\"bold\">Local state</text><text x=\"742\" y=\"208\">Cache, offline files, keys,</text><text x=\"742\" y=\"225\">sessions</text>
</g>
<line x1=\"500\" y1=\"280\" x2=\"500\" y2=\"298\" stroke=\"#555\" stroke-width=\"2\" marker-end=\"url(#ar)\" marker-start=\"url(#ar)\"/>

<rect x=\"40\" y=\"300\" width=\"920\" height=\"100\" rx=\"10\" fill=\"#eeeeee\" stroke=\"#777\" stroke-width=\"2\"/>
<text x=\"55\" y=\"323\" font-size=\"16\" font-weight=\"bold\" fill=\"#444\">NETWORK</text>
<text x=\"140\" y=\"323\" font-size=\"12.5\" fill=\"#666\">shared protocols: the only thing both sides must agree on. All just bytes.</text>
<g font-size=\"12.5\" fill=\"#333\" text-anchor=\"middle\">
<rect x=\"70\" y=\"337\" width=\"164\" height=\"50\" rx=\"8\" fill=\"#fff\" stroke=\"#777\"/><text x=\"152\" y=\"358\" font-weight=\"bold\">HTTP / WebSocket</text><text x=\"152\" y=\"376\">gRPC, MCP</text>
<rect x=\"244\" y=\"337\" width=\"164\" height=\"50\" rx=\"8\" fill=\"#fff\" stroke=\"#777\"/><text x=\"326\" y=\"358\" font-weight=\"bold\">TLS</text><text x=\"326\" y=\"376\">encryption, certificates</text>
<rect x=\"418\" y=\"337\" width=\"164\" height=\"50\" rx=\"8\" fill=\"#fff\" stroke=\"#777\"/><text x=\"500\" y=\"358\" font-weight=\"bold\">TCP / QUIC</text><text x=\"500\" y=\"376\">reliable streams</text>
<rect x=\"592\" y=\"337\" width=\"164\" height=\"50\" rx=\"8\" fill=\"#fff\" stroke=\"#777\"/><text x=\"674\" y=\"358\" font-weight=\"bold\">IP + DNS</text><text x=\"674\" y=\"376\">addresses, names</text>
<rect x=\"766\" y=\"337\" width=\"164\" height=\"50\" rx=\"8\" fill=\"#fff\" stroke=\"#777\"/><text x=\"848\" y=\"358\" font-weight=\"bold\">Wi-Fi, 5G, fibre</text><text x=\"848\" y=\"376\">subsea cables</text>
</g>
<line x1=\"500\" y1=\"402\" x2=\"500\" y2=\"408\" stroke=\"#555\" stroke-width=\"2\"/>

<rect x=\"40\" y=\"410\" width=\"920\" height=\"350\" rx=\"10\" fill=\"#f4f9fc\" stroke=\"#2a85b8\" stroke-width=\"2\"/>
<text x=\"55\" y=\"432\" font-size=\"16\" font-weight=\"bold\" fill=\"#0d4a6b\">CLOUD (server)</text>
<text x=\"170\" y=\"432\" font-size=\"12.5\" fill=\"#666\">rented, shared, always on, in data centres</text>

<rect x=\"55\" y=\"444\" width=\"435\" height=\"26\" rx=\"6\" fill=\"#0d4a6b\"/>
<text x=\"272\" y=\"462\" text-anchor=\"middle\" font-size=\"13\" font-weight=\"bold\" fill=\"#fff\">RETRIEVAL computing</text>
<text x=\"272\" y=\"488\" text-anchor=\"middle\" font-size=\"12\" fill=\"#0d4a6b\">fetch what was stored: exact, cheap</text>
<g font-size=\"12.5\" fill=\"#0d4a6b\">
<rect x=\"55\" y=\"498\" width=\"435\" height=\"58\" rx=\"8\" fill=\"#cfe9f7\" stroke=\"#2a85b8\"/><text x=\"67\" y=\"519\" font-weight=\"bold\">Your service</text><text x=\"67\" y=\"538\">Auth, business logic, APIs, queues, payments, identity, email</text>
<rect x=\"55\" y=\"564\" width=\"435\" height=\"58\" rx=\"8\" fill=\"#cfe9f7\" stroke=\"#2a85b8\"/><text x=\"67\" y=\"585\" font-weight=\"bold\">Data stores</text><text x=\"67\" y=\"604\">SQL / NoSQL databases, object storage, search and vector indexes</text>
<rect x=\"55\" y=\"630\" width=\"435\" height=\"58\" rx=\"8\" fill=\"#cfe9f7\" stroke=\"#2a85b8\"/><text x=\"67\" y=\"651\" font-weight=\"bold\">Hosting</text><text x=\"67\" y=\"670\">Containers, Kubernetes, serverless, CDN, load balancers</text>
<rect x=\"55\" y=\"696\" width=\"435\" height=\"58\" rx=\"8\" fill=\"#cfe9f7\" stroke=\"#2a85b8\"/><text x=\"67\" y=\"717\" font-weight=\"bold\">Cloud machines</text><text x=\"67\" y=\"736\">CPU servers, SSDs, networking, data centres</text>
</g>

<rect x=\"510\" y=\"444\" width=\"435\" height=\"26\" rx=\"6\" fill=\"#1f5a10\"/>
<text x=\"727\" y=\"462\" text-anchor=\"middle\" font-size=\"13\" font-weight=\"bold\" fill=\"#fff\">GENERATIVE computing</text>
<text x=\"727\" y=\"488\" text-anchor=\"middle\" font-size=\"12\" fill=\"#1f5a10\">make new output: flexible, costly per token</text>
<g font-size=\"12.5\" fill=\"#1f5a10\">
<rect x=\"510\" y=\"498\" width=\"435\" height=\"58\" rx=\"8\" fill=\"#d9f2d0\" stroke=\"#4a9a35\"/><text x=\"522\" y=\"519\" font-weight=\"bold\">Model API</text><text x=\"522\" y=\"538\">Tokens in, tokens out, tool calls, structured output, prompt caching</text>
<rect x=\"510\" y=\"564\" width=\"435\" height=\"58\" rx=\"8\" fill=\"#d9f2d0\" stroke=\"#4a9a35\"/><text x=\"522\" y=\"585\" font-weight=\"bold\">Inference serving</text><text x=\"522\" y=\"604\">Batching, KV cache, routing, quantisation, speculative decoding</text>
<rect x=\"510\" y=\"630\" width=\"435\" height=\"58\" rx=\"8\" fill=\"#d9f2d0\" stroke=\"#4a9a35\"/><text x=\"522\" y=\"651\" font-weight=\"bold\">Trained model</text><text x=\"522\" y=\"670\">Weights from pretraining, then RL / alignment on human feedback</text>
<rect x=\"510\" y=\"696\" width=\"435\" height=\"58\" rx=\"8\" fill=\"#d9f2d0\" stroke=\"#4a9a35\"/><text x=\"522\" y=\"717\" font-weight=\"bold\">Accelerator clusters</text><text x=\"522\" y=\"736\">GPUs / TPUs, HBM, fast interconnect, power and cooling</text>
</g>
<line x1=\"492\" y1=\"720\" x2=\"508\" y2=\"720\" stroke=\"#555\" stroke-width=\"2\" marker-end=\"url(#ar)\" marker-start=\"url(#ar)\"/>
</svg>
"
 :AT "2026-11-16T17:01:34" :VERSION 2)
(:PINNED T :ID "race-condition-result-depends-on-timing" :MAP "computers" :NODE "concurrency-locks"
 :TYPE "html" :TITLE "Race condition: result depends on timing" :LANGUAGE NIL :CONTENT
 "<!DOCTYPE html><html><head><meta charset=\"utf-8\"><style>
body{font-family:system-ui,sans-serif;margin:0;padding:16px;background:#fafafa;color:#222}
h1{font-size:18px;margin:0 0 4px}
.def{font-size:14px;margin:0 0 12px;color:#444}
.stage{display:flex;align-items:center;justify-content:space-around;gap:8px}
.p{width:140px;border:2px solid #888;border-radius:10px;padding:8px;background:#fff;text-align:center;transition:.2s}
.p.A{border-color:#2b7bd6}.p.B{border-color:#d6772b}
.p h3{margin:0 0 4px;font-size:15px}
.note{font-size:13px;min-height:54px}
.box{width:120px;height:120px;border:4px solid #333;border-radius:8px;background:#fff;display:flex;flex-direction:column;align-items:center;justify-content:center}
.box.lock{border-color:#c0392b;background:#fdecea}
.val{font-size:48px;font-weight:700}
.lab{font-size:12px;color:#666}
.ctrl{margin:14px 0;display:flex;gap:12px;align-items:center;flex-wrap:wrap}
button{font-size:15px;padding:8px 16px;border-radius:8px;border:0;background:#333;color:#fff;cursor:pointer}
button:disabled{opacity:.5}
#res{font-size:15px;font-weight:600;min-height:22px}
.bad{color:#c0392b}.good{color:#1e8449}
#log{font-size:12px;font-family:monospace;background:#fff;border:1px solid #ddd;border-radius:6px;padding:6px;height:110px;overflow:auto}
.A-t{color:#2b7bd6}.B-t{color:#d6772b}
</style></head><body>
<h1>Race condition</h1>
<p class=\"def\">A race condition is when the result depends on the relative timing of threads that share data without coordination. Each person must read the box, add 1, and write it back. Start at 0, so the correct answer is 2.</p>
<div class=\"stage\">
<div class=\"p A\" id=\"pA\"><h3>Alice</h3><div class=\"note\" id=\"nA\">idle</div></div>
<div class=\"box\" id=\"box\"><div class=\"val\" id=\"val\">0</div><div class=\"lab\">shared box</div></div>
<div class=\"p B\" id=\"pB\"><h3>Bob</h3><div class=\"note\" id=\"nB\">idle</div></div>
</div>
<div class=\"ctrl\"><button id=\"go\">Play</button>
<label><input type=\"checkbox\" id=\"lk\"> Use a lock</label>
<span id=\"res\"></span></div>
<div id=\"tally\" style=\"font-size:13px;margin-bottom:8px\"></div>
<div id=\"log\"></div>
<script>
const $=id=>document.getElementById(id);
let box=0,held=false,queue=[],tally={ok:0,bad:0,okL:0,badL:0};
const sleep=ms=>new Promise(r=>setTimeout(r,ms));
const rnd=()=>300+Math.random()*1400;
function log(n,t){const d=document.createElement('div');d.className=n+'-t';d.textContent=n==='A'?'Alice: '+t:'Bob: '+t;$('log').prepend(d)}
function note(n,t){$('n'+n).textContent=t}
function setBox(v){box=v;$('val').textContent=v}
function acquire(){return new Promise(r=>{if(!held){held=true;$('box').classList.add('lock');r()}else queue.push(r)})}
function release(){if(queue.length)queue.shift()();else{held=false;$('box').classList.remove('lock')}}
async function person(n,useLock){
 await sleep(rnd()*0.6);
 if(useLock){note(n,'wants the box…');log(n,'asks for lock');await acquire();log(n,'got lock')}
 const v=box;note(n,'read '+v+'. Thinking…');log(n,'read '+v);
 await sleep(rnd());
 note(n,'writing '+(v+1));
 await sleep(200);
 setBox(v+1);log(n,'wrote '+(v+1));note(n,'done: wrote '+(v+1));
 if(useLock){release();log(n,'released lock')}
}
$('go').onclick=async()=>{
 const L=$('lk').checked;$('go').disabled=true;$('res').textContent='';$('log').innerHTML='';
 setBox(0);held=false;queue=[];$('box').classList.remove('lock');note('A','idle');note('B','idle');
 await Promise.all([person('A',L),person('B',L)]);
 const ok=box===2;
 $('res').innerHTML=ok?'<span class=\"good\">Result 2. Correct this time.</span>':'<span class=\"bad\">Result '+box+'. Lost update! One write overwrote the other.</span>';
 const k=L?(ok?'okL':'badL'):(ok?'ok':'bad');tally[k]++;
 $('tally').textContent='No lock: '+tally.ok+' correct, '+tally.bad+' lost updates. With lock: '+tally.okL+' correct, '+tally.badL+' lost updates.';
 $('go').disabled=false;
};
</script></body></html>"
 :AT "2026-11-16T17:05:40" :VERSION 1)
(:PINNED T :ID "heaven-and-hell-user-vs-kernel" :MAP "computers" :NODE "syscall-boundary" :TYPE
 "svg" :TITLE "Heaven and hell: user vs kernel" :LANGUAGE NIL :CONTENT
 "<svg xmlns=\"http://www.w3.org/2000/svg\" viewBox=\"0 0 800 640\" font-family=\"Arial, sans-serif\">
<defs>
<linearGradient id=\"sky\" x1=\"0\" y1=\"0\" x2=\"0\" y2=\"1\"><stop offset=\"0\" stop-color=\"#bfe3ff\"/><stop offset=\"1\" stop-color=\"#fff8e1\"/></linearGradient>
<linearGradient id=\"fire\" x1=\"0\" y1=\"0\" x2=\"0\" y2=\"1\"><stop offset=\"0\" stop-color=\"#5a0d0d\"/><stop offset=\"1\" stop-color=\"#c62800\"/></linearGradient>
</defs>
<rect width=\"800\" height=\"640\" fill=\"#222\"/>
<!-- heaven -->
<rect x=\"0\" y=\"0\" width=\"800\" height=\"280\" fill=\"url(#sky)\"/>
<g fill=\"#fff\" opacity=\"0.9\"><ellipse cx=\"90\" cy=\"60\" rx=\"60\" ry=\"20\"/><ellipse cx=\"130\" cy=\"48\" rx=\"40\" ry=\"18\"/><ellipse cx=\"690\" cy=\"80\" rx=\"70\" ry=\"20\"/><ellipse cx=\"650\" cy=\"68\" rx=\"40\" ry=\"16\"/></g>
<ellipse cx=\"400\" cy=\"28\" rx=\"50\" ry=\"9\" fill=\"none\" stroke=\"#e0b400\" stroke-width=\"4\"/>
<text x=\"400\" y=\"62\" text-anchor=\"middle\" font-size=\"24\" font-weight=\"bold\" fill=\"#1a4f7a\">USER MODE: heaven</text>
<text x=\"400\" y=\"84\" text-anchor=\"middle\" font-size=\"14\" fill=\"#1a4f7a\">Your apps. Every mistake stays inside its own walls.</text>
<!-- apps -->
<g font-size=\"13\" text-anchor=\"middle\" fill=\"#1a4f7a\">
<rect x=\"60\" y=\"110\" width=\"150\" height=\"80\" rx=\"14\" fill=\"#fff\" stroke=\"#6aa9d8\" stroke-width=\"2\"/>
<text x=\"135\" y=\"145\" font-weight=\"bold\">Browser</text><text x=\"135\" y=\"165\">crashes → only it dies</text>
<rect x=\"325\" y=\"110\" width=\"150\" height=\"80\" rx=\"14\" fill=\"#fff\" stroke=\"#6aa9d8\" stroke-width=\"2\"/>
<text x=\"400\" y=\"145\" font-weight=\"bold\">Your program</text><text x=\"400\" y=\"165\">bad pointer → segfault</text>
<rect x=\"590\" y=\"110\" width=\"150\" height=\"80\" rx=\"14\" fill=\"#fff\" stroke=\"#6aa9d8\" stroke-width=\"2\"/>
<text x=\"665\" y=\"145\" font-weight=\"bold\">Game</text><text x=\"665\" y=\"165\">restart and try again</text>
</g>
<text x=\"400\" y=\"228\" text-anchor=\"middle\" font-size=\"13\" fill=\"#1a4f7a\">Can only touch its own memory. Anything else must be asked for.</text>
<text x=\"400\" y=\"248\" text-anchor=\"middle\" font-size=\"13\" fill=\"#1a4f7a\">Consequence of failure: one process is killed.</text>
<!-- gate -->
<rect x=\"0\" y=\"280\" width=\"800\" height=\"80\" fill=\"#333\"/>
<rect x=\"250\" y=\"272\" width=\"300\" height=\"96\" rx=\"10\" fill=\"#f4d03f\" stroke=\"#7a5c00\" stroke-width=\"3\"/>
<text x=\"400\" y=\"300\" text-anchor=\"middle\" font-size=\"16\" font-weight=\"bold\" fill=\"#3a2a00\">THE SYSCALL GATE</text>
<text x=\"400\" y=\"320\" text-anchor=\"middle\" font-size=\"12\" fill=\"#3a2a00\">1. syscall instruction  2. mode flips to kernel</text>
<text x=\"400\" y=\"337\" text-anchor=\"middle\" font-size=\"12\" fill=\"#3a2a00\">3. jump to FIXED entry  4. number picks the job</text>
<text x=\"400\" y=\"354\" text-anchor=\"middle\" font-size=\"12\" fill=\"#3a2a00\">5. return, mode drops to user</text>
<!-- arrows -->
<g stroke=\"#fff\" stroke-width=\"4\" fill=\"#fff\">
<line x1=\"150\" y1=\"200\" x2=\"150\" y2=\"395\"/><polygon points=\"140,385 160,385 150,405\" />
<line x1=\"650\" y1=\"405\" x2=\"650\" y2=\"210\"/><polygon points=\"640,220 660,220 650,198\"/>
</g>
<text x=\"165\" y=\"300\" font-size=\"12\" fill=\"#fff\">request + number</text>
<text x=\"525\" y=\"300\" font-size=\"0\"></text>
<text x=\"665\" y=\"300\" font-size=\"12\" fill=\"#fff\">result</text>
<!-- hell -->
<rect x=\"0\" y=\"368\" width=\"800\" height=\"272\" fill=\"url(#fire)\"/>
<g fill=\"#ff9800\" opacity=\"0.85\">
<path d=\"M0 640 L30 570 L60 640Z\"/><path d=\"M80 640 L120 550 L160 640Z\"/><path d=\"M250 640 L285 575 L320 640Z\"/><path d=\"M480 640 L520 555 L560 640Z\"/><path d=\"M640 640 L680 570 L720 640Z\"/><path d=\"M740 640 L770 585 L800 640Z\"/>
</g>
<g fill=\"#ffd54f\" opacity=\"0.8\"><path d=\"M95 640 L120 590 L145 640Z\"/><path d=\"M495 640 L520 595 L545 640Z\"/><path d=\"M655 640 L680 600 L705 640Z\"/></g>
<text x=\"400\" y=\"400\" text-anchor=\"middle\" font-size=\"24\" font-weight=\"bold\" fill=\"#ffd9b0\">KERNEL MODE: hell</text>
<text x=\"400\" y=\"422\" text-anchor=\"middle\" font-size=\"14\" fill=\"#ffd9b0\">Full power over all memory and hardware. No safety net.</text>
<g font-size=\"13\" text-anchor=\"middle\" fill=\"#ffe0c0\">
<rect x=\"60\" y=\"445\" width=\"200\" height=\"70\" rx=\"6\" fill=\"#2b0505\" stroke=\"#ff5722\" stroke-width=\"2\"/>
<text x=\"160\" y=\"475\" font-weight=\"bold\">Drivers + memory manager</text><text x=\"160\" y=\"495\">one bad write corrupts all</text>
<rect x=\"300\" y=\"445\" width=\"200\" height=\"70\" rx=\"6\" fill=\"#2b0505\" stroke=\"#ff5722\" stroke-width=\"2\"/>
<text x=\"400\" y=\"475\" font-weight=\"bold\">Scheduler + file system</text><text x=\"400\" y=\"495\">one bug hangs everything</text>
<rect x=\"540\" y=\"445\" width=\"200\" height=\"70\" rx=\"6\" fill=\"#2b0505\" stroke=\"#ff5722\" stroke-width=\"2\"/>
<text x=\"640\" y=\"475\" font-weight=\"bold\">Raw hardware access</text><text x=\"640\" y=\"495\">disk, network, CPU control</text>
</g>
<text x=\"400\" y=\"560\" text-anchor=\"middle\" font-size=\"15\" font-weight=\"bold\" fill=\"#fff\">Consequence of failure: kernel panic / blue screen. The whole machine goes down.</text>
<text x=\"400\" y=\"584\" text-anchor=\"middle\" font-size=\"13\" fill=\"#ffd9b0\">So the kernel keeps its code small and checks every request from above.</text>
</svg>"
 :AT "2026-11-16T17:15:32" :VERSION 1)
(:PINNED T :ID "database-core-ideas" :MAP "computers" :NODE "databases" :TYPE "svg" :TITLE
 "Database core ideas" :LANGUAGE NIL :CONTENT
 "<svg viewBox=\"0 0 700 460\" xmlns=\"http://www.w3.org/2000/svg\" font-family=\"sans-serif\" font-size=\"14\">
<rect width=\"700\" height=\"460\" fill=\"#fff\"/>
<text x=\"350\" y=\"28\" text-anchor=\"middle\" font-size=\"18\" font-weight=\"bold\">Database = query language + engine over files</text>
<rect x=\"230\" y=\"45\" width=\"240\" height=\"50\" rx=\"8\" fill=\"#dbeafe\" stroke=\"#2563eb\"/>
<text x=\"350\" y=\"66\" text-anchor=\"middle\" font-weight=\"bold\">1. Declarative query (SQL)</text>
<text x=\"350\" y=\"85\" text-anchor=\"middle\" font-size=\"12\">say WHAT, not HOW</text>
<rect x=\"230\" y=\"120\" width=\"240\" height=\"50\" rx=\"8\" fill=\"#ede9fe\" stroke=\"#7c3aed\"/>
<text x=\"350\" y=\"141\" text-anchor=\"middle\" font-weight=\"bold\">2. Query planner</text>
<text x=\"350\" y=\"160\" text-anchor=\"middle\" font-size=\"12\">picks fastest way (uses indexes)</text>
<rect x=\"40\" y=\"200\" width=\"190\" height=\"110\" rx=\"8\" fill=\"#dcfce7\" stroke=\"#16a34a\"/>
<text x=\"135\" y=\"222\" text-anchor=\"middle\" font-weight=\"bold\">3. Relational model</text>
<text x=\"135\" y=\"244\" text-anchor=\"middle\" font-size=\"12\">tables of rows; keys link</text>
<text x=\"135\" y=\"262\" text-anchor=\"middle\" font-size=\"12\">tables (id → user_id)</text>
<text x=\"135\" y=\"284\" text-anchor=\"middle\" font-size=\"12\">schema enforces structure</text>
<rect x=\"255\" y=\"200\" width=\"190\" height=\"110\" rx=\"8\" fill=\"#fef9c3\" stroke=\"#ca8a04\"/>
<text x=\"350\" y=\"222\" text-anchor=\"middle\" font-weight=\"bold\">4. Indexes (B-tree)</text>
<text x=\"350\" y=\"244\" text-anchor=\"middle\" font-size=\"12\">sorted lookup: O(log n)</text>
<text x=\"350\" y=\"262\" text-anchor=\"middle\" font-size=\"12\">instead of scanning every</text>
<text x=\"350\" y=\"280\" text-anchor=\"middle\" font-size=\"12\">row</text>
<rect x=\"470\" y=\"200\" width=\"190\" height=\"110\" rx=\"8\" fill=\"#fee2e2\" stroke=\"#dc2626\"/>
<text x=\"565\" y=\"222\" text-anchor=\"middle\" font-weight=\"bold\">5. Transactions (ACID)</text>
<text x=\"565\" y=\"244\" text-anchor=\"middle\" font-size=\"12\">Atomic: all or nothing</text>
<text x=\"565\" y=\"262\" text-anchor=\"middle\" font-size=\"12\">Consistent · Isolated (locks)</text>
<text x=\"565\" y=\"280\" text-anchor=\"middle\" font-size=\"12\">Durable: log survives crash</text>
<rect x=\"230\" y=\"340\" width=\"240\" height=\"50\" rx=\"8\" fill=\"#f3f4f6\" stroke=\"#555\"/>
<text x=\"350\" y=\"361\" text-anchor=\"middle\" font-weight=\"bold\">6. Storage: pages in files</text>
<text x=\"350\" y=\"380\" text-anchor=\"middle\" font-size=\"12\">+ write-ahead log, cache</text>
<g stroke=\"#555\" stroke-width=\"2\" fill=\"none\"><path d=\"M350 95v25M350 170v30M350 310v30M135 310v10l215 20M565 310v10l-215 20M300 170l-165 30M400 170l165 30\"/></g>
<text x=\"350\" y=\"425\" text-anchor=\"middle\" font-size=\"12\" fill=\"#555\">Files give bytes; the database adds meaning, speed and safety on top.</text>
</svg>"
 :AT "2026-11-17T10:46:46" :VERSION 1)
(:PINNED T :ID "indexing-scan-vs-sorted-lookup" :MAP "computers" :NODE "databases" :TYPE "html"
 :TITLE "Indexing: scan vs sorted lookup" :LANGUAGE NIL :CONTENT
 "<!DOCTYPE html><html><head><meta charset=\"utf-8\"><style>
body{font-family:sans-serif;margin:14px;color:#222}
h2{margin:0 0 6px;font-size:18px}
.row{display:flex;flex-wrap:wrap;gap:3px;margin:6px 0 10px}
.c{width:34px;height:26px;font-size:11px;display:flex;align-items:center;justify-content:center;border:1px solid #bbb;border-radius:4px;background:#f8f8f8}
.c.x{background:#fecaca;border-color:#dc2626;color:#999}
.c.cur{background:#fde047;border-color:#ca8a04;font-weight:bold}
.c.hit{background:#4ade80;border-color:#16a34a;font-weight:bold}
.c.out{opacity:.25}
button,select{padding:6px 12px;margin-right:6px;font-size:14px}
.box{border:1px solid #ddd;border-radius:8px;padding:8px 12px;margin:8px 0}
.n{font-size:20px;font-weight:bold}
table{border-collapse:collapse;font-size:13px;margin-top:6px}td,th{border:1px solid #ccc;padding:4px 10px;text-align:right}
</style></head><body>
<h2>Find the row where id = <span id=\"t\"></span></h2>
<div>
<button onclick=\"run()\">▶ Run both</button>
<button onclick=\"pick()\">New random target</button>
</div>
<div class=\"box\"><b>No index: full scan</b> (check rows one by one) — checks: <span class=\"n\" id=\"n1\">0</span>
<div class=\"row\" id=\"a\"></div></div>
<div class=\"box\"><b>With sorted index</b> (look in the middle, discard half) — checks: <span class=\"n\" id=\"n2\">0</span>
<div class=\"row\" id=\"b\"></div>
<div style=\"font-size:12px;color:#555\">Grey = ruled out without looking. A real B-tree does this with wide nodes so each disk read rules out hundreds of rows.</div></div>
<b>Scaling (worst case checks)</b>
<table><tr><th>Rows</th><th>Scan</th><th>Index</th></tr>
<tr><td>64 (above)</td><td>64</td><td>6</td></tr><tr><td>1,000</td><td>1,000</td><td>10</td></tr>
<tr><td>1,000,000</td><td>1,000,000</td><td>20</td></tr>
<tr><td>1,000,000,000</td><td>1,000,000,000</td><td>30</td></tr></table>
<script>
const N=64;let keys=[],target,timer;
for(let i=0;i<N;i++)keys.push(10+i*7+(i*i)%5);
function build(){for(const id of['a','b']){const e=document.getElementById(id);e.innerHTML='';keys.forEach(k=>{const d=document.createElement('div');d.className='c';d.textContent=k;e.appendChild(d)})}
document.getElementById('t').textContent=target;n1.textContent=0;n2.textContent=0}
function pick(){clearInterval(timer);target=keys[Math.floor(Math.random()*N)];build()}
function run(){clearInterval(timer);build();const A=a.children,B=b.children;let i=0,lo=0,hi=N-1,s1=true,s2=true,c1=0,c2=0;
timer=setInterval(()=>{
if(s1){if(i>0)A[i-1].classList.replace('cur','x');A[i].classList.add('cur');c1++;n1.textContent=c1;if(keys[i]==target){A[i].classList.replace('cur','hit');s1=false}else i++}
if(s2){const m=(lo+hi)>>1;[...B].forEach(e=>e.classList.remove('cur'));B[m].classList.add('cur');c2++;n2.textContent=c2;
if(keys[m]==target){B[m].classList.replace('cur','hit');s2=false}
else{if(keys[m]<target){for(let j=lo;j<=m;j++)B[j].classList.add('out');lo=m+1}else{for(let j=m;j<=hi;j++)B[j].classList.add('out');hi=m-1}}}
if(!s1&&!s2)clearInterval(timer)},450)}
pick();
</script></body></html>"
 :AT "2026-11-17T11:10:37" :VERSION 1)
(:PINNED T :ID "usb-pulled-mid-save-corruption" :MAP "computers" :NODE "databases" :TYPE "html"
 :TITLE "USB pulled mid-save: corruption" :LANGUAGE NIL :CONTENT
 "<!DOCTYPE html><html><head><meta charset=\"utf-8\"><style>
body{font-family:Segoe UI,sans-serif;margin:14px;color:#222}
h2{margin:0 0 8px;font-size:18px}
button{padding:7px 14px;margin:0 6px 6px 0;font-size:14px;cursor:pointer}
button.red{background:#dc2626;color:#fff;border:0;border-radius:4px}
.lab{font-size:12px;color:#555;margin-top:8px}
.row{display:flex;gap:4px;margin:4px 0}
.b{width:44px;height:34px;border-radius:4px;display:flex;align-items:center;justify-content:center;font-size:12px;border:1px solid #888;background:#eee;color:#888}
.o{background:#bfdbfe;border-color:#2563eb;color:#1e3a8a}
.n{background:#bbf7d0;border-color:#16a34a;color:#14532d}
.m{width:auto;padding:0 10px}
.dirty{background:#fecaca;border-color:#dc2626;color:#7f1d1d}
.usb{border:2px solid #444;border-radius:8px;padding:8px 12px;background:#f9fafb;transition:transform .6s,opacity .6s}
.usb.out{transform:translateX(160px) rotate(8deg);opacity:.35}
#msg{min-height:38px;font-size:14px;margin:8px 0;padding:6px 10px;background:#fffbe6;border-left:4px solid #eab308}
#dlg{display:none;margin-top:10px;width:380px;border:1px solid #666;box-shadow:4px 4px 12px #0006;background:#fff;font-size:13px}
#dlg .t{background:#1e66c0;color:#fff;padding:5px 8px;display:flex;justify-content:space-between}
#dlg .bd{padding:14px;display:flex;gap:12px}
#dlg .ic{background:#dc2626;color:#fff;border-radius:50%;width:30px;height:30px;display:flex;align-items:center;justify-content:center;font-weight:bold;flex:none}
#dlg.show{display:block;animation:shake .5s}
@keyframes shake{20%{transform:translateX(-10px)}40%{transform:translateX(10px)}60%{transform:translateX(-6px)}80%{transform:translateX(6px)}}
#ok{display:none;margin-top:10px;padding:10px;background:#dcfce7;border:1px solid #16a34a;border-radius:6px;width:360px}
</style></head><body>
<h2>Saving report.docx (v1 → v2) to a USB stick</h2>
<button onclick=\"setMode('plain')\" id=\"bp\">Plain overwrite</button>
<button onclick=\"setMode('jour')\" id=\"bj\">Journaled (transaction)</button>
<div><button onclick=\"start()\" id=\"go\">💾 Save</button><button class=\"red\" onclick=\"pull()\">⏏ Pull the USB!</button><button onclick=\"plug()\" id=\"pl\" disabled>🔌 Plug back in</button><button onclick=\"reset()\">Reset</button></div>
<div id=\"msg\"></div>
<div class=\"usb\" id=\"usb\">
<div class=\"lab\">Journal (log area)</div><div class=\"row\" id=\"jr\"></div>
<div class=\"lab\">File data blocks (blue = v1 old, green = v2 new)</div><div class=\"row\" id=\"dt\"></div>
<div class=\"lab\">File metadata</div><div class=\"row\"><div class=\"b m\" id=\"meta\"></div></div>
</div>
<div id=\"dlg\"><div class=\"t\"><span>Location is not available</span><span>✕</span></div>
<div class=\"bd\"><div class=\"ic\">✕</div><div><b>E:\\ is not accessible.</b><br>The file or directory is corrupted and unreadable.<br><br>Some blocks hold v1, some hold v2, and the file size/records no longer match either version.<br><br><button onclick=\"dlg.classList.remove('show')\">OK</button></div></div></div>
<div id=\"ok\"></div>
<script>
let mode='plain',step=0,pulled=false,timer,B,J,commit,meta,cleared;
function reset(){clearInterval(timer);step=0;pulled=false;B=Array(8).fill('o');J=Array(4).fill(0);commit=false;cleared=false;meta='ok';
usb.classList.remove('out');dlg.classList.remove('show');ok.style.display='none';pl.disabled=true;go.disabled=false;
say(mode=='plain'?'Plain mode: the program overwrites the file in place, block by block, then updates the metadata. No log.':'Journaled mode: first write the new data to a log, then a commit marker, and only then copy it into place.');draw()}
function setMode(m){mode=m;reset()}
function say(s){msg.textContent=s}
function draw(){jr.innerHTML=J.map((v,i)=>`<div class=\"b ${v?'n':''}\">${v?'v2·'+(i+1):'–'}</div>`).join('')+`<div class=\"b m ${commit&&!cleared?'n':''}\">${commit&&!cleared?'COMMIT ✔':'no commit'}</div>`;
dt.innerHTML=B.map(v=>`<div class=\"b ${v}\">${v=='o'?'v1':'v2'}</div>`).join('');
meta.className='b m '+(meta=='dirty'?'dirty':'o');meta.textContent=meta=='dirty'?'size/checksum = INCONSISTENT':'consistent';
bp.style.fontWeight=mode=='plain'?'bold':'normal';bj.style.fontWeight=mode=='jour'?'bold':'normal'}
const total=()=>mode=='plain'?6:10;
function tick(){
if(mode=='plain'){
 if(step==0){meta='dirty';say('Marking file as being updated…')}
 else if(step<=4){B[2*step-2]='n';B[2*step-1]='n';say('Overwriting blocks '+(2*step-1)+'–'+(2*step)+' in place…')}
 else{meta='ok';say('Updating metadata… saved!')}
}else{
 if(step<4){J[step]=1;say('Writing new data to the journal ('+(step+1)+'/4)…')}
 else if(step==4){commit=true;say('Commit marker written. The change is now guaranteed.')}
 else if(step<9){const k=step-5;B[2*k]='n';B[2*k+1]='n';say('Copying from journal into place…')}
 else{cleared=true;J=Array(4).fill(0);say('Journal cleared. Saved!')}
}
step++;draw();if(step>=total()){clearInterval(timer);go.disabled=true;say('Finished saving safely. Pulling the USB now would be harmless.')}}
function start(){if(pulled||step>0)return;go.disabled=true;timer=setInterval(tick,900)}
function pull(){if(pulled||step>=total())return;clearInterval(timer);pulled=true;usb.classList.add('out');pl.disabled=false;go.disabled=true;say('⏏ Power gone mid-write, at step '+step+' of '+total()+'. Whatever reached the disk is all there is.')}
function plug(){usb.classList.remove('out');pl.disabled=true;
if(mode=='plain'){
 const mixed=B.includes('o')&&B.includes('n');
 if(step==0){ok.style.display='block';ok.textContent='Nothing was written yet: v1 is intact.'}
 else{dlg.classList.add('show');say('No log, so nothing knows what was half-done. The file is a mix of v1 and v2 with inconsistent metadata → corrupt.')}
}else{
 if(commit&&!cleared){B=Array(8).fill('n');J=Array(4).fill(0);cleared=true;draw();ok.style.display='block';ok.textContent='Recovery found a COMMIT in the journal and replayed it: file is cleanly v2.';say('Recovery: committed → replay journal → all-new.')}
 else{J=Array(4).fill(0);draw();ok.style.display='block';ok.textContent='Recovery found no COMMIT, discarded the journal: file is cleanly v1 (the save was lost, but nothing is broken).';say('Recovery: not committed → throw away journal → all-old.')}
}}
reset();
</script></body></html>"
 :AT "2026-11-17T11:10:56" :VERSION 1)
(:PINNED T :ID "sorting-and-searching-visualiser" :MAP "computers" :NODE "databases" :TYPE "html"
 :TITLE "Sorting and searching visualiser" :LANGUAGE NIL :CONTENT
 "<!DOCTYPE html><html><head><meta charset=\"utf-8\"><style>
body{font-family:sans-serif;margin:12px;color:#222}
h3{margin:4px 0}
.ctl{display:flex;flex-wrap:wrap;gap:8px;align-items:center;margin:6px 0}
button,select{padding:6px 10px;font-size:14px}
input[type=range]{width:110px}
#bars{display:flex;align-items:flex-end;height:260px;gap:1px;border:1px solid #ddd;padding:6px;border-radius:8px;background:#fafafa}
.bar{flex:1;background:#93c5fd;min-width:2px;position:relative}
.bar.cmp{background:#facc15}.bar.swp{background:#ef4444}.bar.done{background:#4ade80}
.bar.out{background:#e5e7eb}.bar.hit{background:#16a34a}.bar.rng{background:#bfdbfe}.bar.piv{background:#a855f7}
#stats{margin:8px 0;font-size:14px}
#info{font-size:13px;color:#444;background:#f3f4f6;padding:8px 10px;border-radius:6px}
.lab{font-size:12px;color:#555}
</style></head><body>
<h3>Sorting and searching visualiser</h3>
<div class=\"ctl\">
<select id=\"mode\"><option value=\"sort\">Sorting</option><option value=\"search\">Searching</option></select>
<select id=\"alg\"></select>
<label>Size <input type=\"range\" id=\"size\" min=\"8\" max=\"120\" value=\"40\"></label>
<label>Speed <input type=\"range\" id=\"speed\" min=\"1\" max=\"100\" value=\"60\"></label>
</div>
<div class=\"ctl\">
<button id=\"gen\">🔀 New data</button>
<button id=\"run\">▶ Run</button>
<button id=\"stop\">⏹ Stop</button>
<label><input type=\"checkbox\" id=\"snd\" checked> 🔊 Sound</label>
<label>Volume <input type=\"range\" id=\"vol\" min=\"0\" max=\"100\" value=\"50\"></label>
<span id=\"tgtbox\" style=\"display:none\">Target: <b id=\"tgt\"></b> <button id=\"newt\">New target</button></span>
</div>
<div id=\"bars\"></div>
<div class=\"lab\">Yellow = comparing · Red = swapping/writing · Purple = pivot · Green = sorted/found · Grey = ruled out</div>
<div class=\"lab\">Sound: each step plays the pitch of the bar being touched (low bar = low note, tall bar = high note, 4 octaves in semitones). A bell ping marks the end of each pass; a rising scale and chord mark the finish.</div>
<div id=\"stats\"></div>
<div id=\"info\"></div>
<script>
const $=id=>document.getElementById(id);
const SORTS={
bubble:['Bubble sort','O(n²) – repeatedly swap adjacent out-of-order pairs; the largest value bubbles to the end each pass.'],
selection:['Selection sort','O(n²) – find the minimum of the unsorted part, put it at the front. Few swaps, many comparisons.'],
insertion:['Insertion sort','O(n²), fast on nearly-sorted data – grow a sorted prefix by sliding each new item into place.'],
merge:['Merge sort','O(n log n) – split in halves, sort each, merge. Always n log n, needs extra memory.'],
quick:['Quick sort','O(n log n) average, O(n²) worst – partition around a pivot, recurse on both sides.'],
heap:['Heap sort','O(n log n) – build a max-heap, repeatedly move the root to the end.']};
const SEARCHES={
linear:['Linear search','O(n) – check each item in turn. Works on unsorted data.'],
binary:['Binary search','O(log n) – needs sorted data; check the middle, discard half. This is what an index exploits.'],
jump:['Jump search','O(√n) – needs sorted data; jump ahead in blocks of √n, then scan back linearly.'],
interp:['Interpolation search','O(log log n) on uniform data – guess where the target is by its value, like opening a phone book near the name.']};
let a=[],tgt,running=false,token=0,cmp=0,acc=0,t0=0;
const delay=()=>Math.max(1,(101-$('speed').value)**1.6/8);
const sleep=()=>new Promise(r=>setTimeout(r,delay()));

/* ---------- audio ---------- */
let ac=null,master=null,lastPing=0;
function audioOn(){
  if(!ac){const AC=window.AudioContext||window.webkitAudioContext;if(!AC)return false;ac=new AC();master=ac.createGain();
    const comp=ac.createDynamicsCompressor();master.connect(comp);comp.connect(ac.destination)}
  if(ac.state==='suspended')ac.resume();
  master.gain.value=($('vol').value/100)*0.8;
  return $('snd').checked;
}
const BASE=130.81, SPAN=48; /* C3 up 4 octaves, chromatic */
function freqOf(v){const mx=Math.max(a.length,2);const k=Math.round((v-1)/(mx-1)*SPAN);return BASE*Math.pow(2,k/12)}
function tone(f,dur,type,peak){
  const t=ac.currentTime,o=ac.createOscillator(),g=ac.createGain();
  o.type=type;o.frequency.value=f;
  g.gain.setValueAtTime(0.0001,t);
  g.gain.linearRampToValueAtTime(peak,t+0.006);
  g.gain.exponentialRampToValueAtTime(0.0001,t+dur);
  o.connect(g);g.connect(master);o.start(t);o.stop(t+dur+0.02);
}
function blip(c){
  if(!audioOn())return;
  const prio=['swp','cmp','hit','piv'];let idx=-1;
  for(const p of prio){for(const k in c){if(c[k]===p){idx=+k;break}}if(idx>=0)break}
  if(idx<0||a[idx]===undefined)return;
  const dur=Math.min(0.2,Math.max(0.05,delay()*1.3/1000));
  tone(freqOf(a[idx]),dur,'triangle',0.22);
}
/* bell ping at the end of each iteration */
function ping(freq=1318.5,big=false){
  if(!audioOn())return;
  const now=ac.currentTime;if(!big&&now-lastPing<0.07)return;lastPing=now;
  const d=big?1.2:0.55;
  tone(freq,d,'sine',0.3);
  tone(freq*2.0,d*0.7,'sine',0.12);
  tone(freq*3.0,d*0.4,'sine',0.05);
}
function fanfare(){ /* major chord ping */
  if(!audioOn())return;
  [523.25,659.25,783.99,1046.5].forEach((f,i)=>setTimeout(()=>ping(f,true),i*90));
}
/* ---------------------------- */

function fill(){const m=$('mode').value,S=m=='sort'?SORTS:SEARCHES;$('alg').innerHTML=Object.entries(S).map(([k,v])=>`<option value=\"${k}\">${v[0]}</option>`).join('');
$('tgtbox').style.display=m=='search'?'inline':'none';info()}
function info(){const m=$('mode').value,S=m=='sort'?SORTS:SEARCHES;$('info').textContent=S[$('alg').value][1]+(m=='search'&&$('alg').value!='linear'?' (data is sorted automatically for this algorithm.)':'')}
function gen(){token++;running=false;const n=+$('size').value;a=Array.from({length:n},(_,i)=>i+1);
if($('mode').value=='search'&&$('alg').value!='linear'){/* sorted */}else shuffle(a);
if($('mode').value=='search'){tgt=a[Math.floor(Math.random()*n)];$('tgt').textContent=tgt}
cmp=acc=0;draw();stats('Ready.')}
function shuffle(x){for(let i=x.length-1;i>0;i--){const j=Math.random()*(i+1)|0;[x[i],x[j]]=[x[j],x[i]]}}
function draw(c={}){const mx=Math.max(...a);$('bars').innerHTML=a.map((v,i)=>`<div class=\"bar ${c[i]||''}\" style=\"height:${v/mx*100}%\"></div>`).join('')}
function stats(s){$('stats').textContent=`${s}  Comparisons/checks: ${cmp}  ·  Writes/swaps: ${acc}`}
async function step(c,msg){draw(c);stats(msg||'');blip(c);if(msg&&msg.startsWith('Found'))fanfare();await sleep();if(!running)throw 0}
const sw=(i,j)=>{[a[i],a[j]]=[a[j],a[i]];acc++};
async function finish(){const c={};for(let i=0;i<a.length;i++){c[i]='done';draw(c);
  if(audioOn())tone(freqOf(a[i]),0.09,'triangle',0.2);
  await new Promise(r=>setTimeout(r,Math.max(8,Math.min(40,1800/a.length))))}
  fanfare()}
const algos={
async bubble(){const n=a.length;for(let i=0;i<n-1;i++){for(let j=0;j<n-1-i;j++){cmp++;const c={};for(let k=n-i;k<n;k++)c[k]='done';c[j]='cmp';c[j+1]='cmp';if(a[j]>a[j+1]){sw(j,j+1);c[j]='swp';c[j+1]='swp'}await step(c,'Bubbling…')}ping()}},
async selection(){const n=a.length;for(let i=0;i<n-1;i++){let m=i;for(let j=i+1;j<n;j++){cmp++;const c={};for(let k=0;k<i;k++)c[k]='done';c[m]='piv';c[j]='cmp';if(a[j]<a[m])m=j;await step(c,'Finding minimum…')}if(m!=i){sw(i,m)}ping()}},
async insertion(){const n=a.length;for(let i=1;i<n;i++){let j=i;while(j>0){cmp++;const c={};c[j]='cmp';c[j-1]='cmp';if(a[j-1]>a[j]){sw(j-1,j);c[j]='swp';c[j-1]='swp';await step(c,'Inserting…');j--}else{await step(c,'Inserting…');break}}ping()}},
async merge(){const n=a.length;async function ms(l,r){if(r-l<1)return;const m=(l+r)>>1;await ms(l,m);await ms(m+1,r);const L=a.slice(l,m+1),R=a.slice(m+1,r+1);let i=0,j=0,k=l;while(i<L.length||j<R.length){cmp++;if(j>=R.length||(i<L.length&&L[i]<=R[j]))a[k]=L[i++];else a[k]=R[j++];acc++;const c={};for(let x=l;x<=r;x++)c[x]='rng';c[k]='swp';await step(c,'Merging…');k++}ping(r-l+1>n/2?1760:1318.5)}await ms(0,n-1)},
async quick(){async function qs(l,r){if(l>=r)return;const p=a[r];let i=l;for(let j=l;j<r;j++){cmp++;const c={};c[r]='piv';c[j]='cmp';c[i]='swp';await step(c,'Partitioning…');if(a[j]<p){sw(i,j);i++}}sw(i,r);await step({[i]:'piv'},'Pivot placed');ping();await qs(l,i-1);await qs(i+1,r)}await qs(0,a.length-1)},
async heap(){const n=a.length;async function sift(s,e){let r=s;while(2*r+1<=e){let c=2*r+1;cmp++;if(c+1<=e&&a[c]<a[c+1])c++;const cl={};for(let k=e+1;k<n;k++)cl[k]='done';cl[r]='cmp';cl[c]='cmp';if(a[r]<a[c]){sw(r,c);cl[r]='swp';cl[c]='swp';await step(cl,'Heapifying…');r=c}else{await step(cl,'Heapifying…');return}}}
for(let s=(n>>1)-1;s>=0;s--)await sift(s,n-1);ping(1568);for(let e=n-1;e>0;e--){sw(0,e);await sift(0,e-1);ping()}},
async linear(){for(let i=0;i<a.length;i++){cmp++;if(a[i]==tgt){await step({[i]:'hit'},'Found at index '+i);return}const c={};for(let k=0;k<i;k++)c[k]='out';c[i]='cmp';await step(c,'Scanning…')}},
async binary(){let lo=0,hi=a.length-1;while(lo<=hi){const m=(lo+hi)>>1;cmp++;const c={};for(let k=0;k<a.length;k++)c[k]=(k<lo||k>hi)?'out':'rng';c[m]='cmp';await step(c,'Checking middle…');if(a[m]==tgt){await step({[m]:'hit'},'Found at index '+m);return}if(a[m]<tgt)lo=m+1;else hi=m-1;ping()}},
async jump(){const n=a.length,s=Math.floor(Math.sqrt(n));let prev=0,cur=s;while(prev<n){const idx=Math.min(cur,n)-1;cmp++;const c={};for(let k=0;k<prev;k++)c[k]='out';c[idx]='cmp';await step(c,'Jumping by '+s+'…');if(a[idx]>=tgt)break;prev=cur;cur+=s;ping()}
ping(1760);for(let i=prev;i<Math.min(cur,n);i++){cmp++;const c={};for(let k=0;k<prev;k++)c[k]='out';c[i]='cmp';await step(c,'Linear scan in block…');if(a[i]==tgt){await step({[i]:'hit'},'Found at index '+i);return}}},
async interp(){let lo=0,hi=a.length-1;while(lo<=hi&&tgt>=a[lo]&&tgt<=a[hi]){const p=a[hi]==a[lo]?lo:lo+Math.floor((tgt-a[lo])*(hi-lo)/(a[hi]-a[lo]));cmp++;const c={};for(let k=0;k<a.length;k++)c[k]=(k<lo||k>hi)?'out':'rng';c[p]='cmp';await step(c,'Guessing position by value…');if(a[p]==tgt){await step({[p]:'hit'},'Found at index '+p);return}if(a[p]<tgt)lo=p+1;else hi=p-1;ping()}}};
$('run').onclick=async()=>{if(running)return;audioOn();cmp=acc=0;running=true;try{await algos[$('alg').value]();if($('mode').value=='sort'){await finish()}stats('Done.')}catch(e){}running=false};
$('stop').onclick=()=>{running=false};
$('vol').oninput=()=>{if(master)master.gain.value=($('vol').value/100)*0.8};
$('gen').onclick=gen;$('size').oninput=gen;
$('newt').onclick=()=>{running=false;tgt=a[Math.random()*a.length|0];$('tgt').textContent=tgt;cmp=acc=0;draw();stats('Ready.')};
$('mode').onchange=()=>{fill();gen()};$('alg').onchange=()=>{info();gen()};
fill();gen();
</script></body></html>
"
 :AT "2026-11-17T15:27:26" :VERSION 2)
(:PINNED T :ID "at-cut-quartz-thickness-shear" :MAP "computers" :NODE "crystal-oscillator" :TYPE
 "html" :TITLE "AT-cut quartz: thickness-shear" :LANGUAGE NIL :CONTENT "<!DOCTYPE html>
<html lang=\"en\">
<head>
<meta charset=\"utf-8\">
<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">
<title>AT-cut quartz: thickness-shear vibration</title>
<style>
  :root{--bg:#0f1115;--panel:#171a21;--ink:#e8e8ec;--mute:#9aa0ab;--quartz:#8fd3ff;--gold:#f0c24b;--x:#ff6b6b;--y:#5be37b;--z:#6fa8ff;--warn:#ff9f43}
  *{box-sizing:border-box}
  body{margin:0;background:var(--bg);color:var(--ink);font:14px/1.4 system-ui,-apple-system,Segoe UI,Roboto,sans-serif}
  header{padding:14px 18px 6px}
  h1{margin:0;font-size:18px;font-weight:600}
  header p{margin:4px 0 0;color:var(--mute)}
  .controls{display:flex;flex-wrap:wrap;gap:14px 22px;padding:10px 18px;align-items:center;border-top:1px solid #23272f;border-bottom:1px solid #23272f}
  .controls label{display:flex;flex-direction:column;gap:3px;font-size:12px;color:var(--mute)}
  .controls input[type=range]{width:170px}
  .controls .val{color:var(--ink);font-weight:600;font-size:13px}
  .seg{display:inline-flex;border:1px solid #333a46;border-radius:6px;overflow:hidden}
  .seg button{background:transparent;color:var(--mute);border:0;padding:5px 10px;cursor:pointer;font-size:12px}
  .seg button.on{background:#2b3240;color:var(--ink)}
  button.plain{background:#2b3240;color:var(--ink);border:0;border-radius:6px;padding:6px 12px;cursor:pointer}
  .grid{display:grid;grid-template-columns:1fr 1fr;gap:12px;padding:12px 18px 18px}
  .panel{background:var(--panel);border:1px solid #23272f;border-radius:10px;padding:10px}
  .panel h2{margin:0 0 6px;font-size:13px;font-weight:600;color:var(--mute);text-transform:uppercase;letter-spacing:.04em}
  canvas{width:100%;height:auto;display:block;border-radius:6px}
  #cut{cursor:grab;touch-action:none;background:#0f1115}
  #cut.dragging{cursor:grabbing}
  .viewbar{display:flex;flex-wrap:wrap;gap:6px;margin-top:8px;align-items:center}
  .viewbar span{color:var(--mute);font-size:12px;margin-right:4px}
  .viewbar button{background:#2b3240;color:var(--ink);border:0;border-radius:6px;padding:4px 10px;cursor:pointer;font-size:12px}
  .viewbar button.on{background:#3b4a66}
  .wide{grid-column:1/-1}
  .readout{display:grid;grid-template-columns:repeat(auto-fit,minmax(150px,1fr));gap:8px;margin-top:8px}
  .readout div{background:#0f1115;border-radius:6px;padding:8px 10px}
  .readout b{display:block;font-size:18px;font-weight:600}
  .readout span{color:var(--mute);font-size:12px}
  .warn{color:var(--warn)}
  .note{color:var(--mute);font-size:12px;margin-top:6px}
  @media (max-width:760px){.grid{grid-template-columns:1fr}}
</style>
</head>
<body>
<header>
  <h1>AT-cut quartz plate: dimensions, shear axes, vibration</h1>
  <p>Thickness sets the frequency; the two faces slide in opposite directions (thickness-shear). Drag the thickness and watch the frequency and the standing wave change.</p>
</header>

<div class=\"controls\">
  <label>Thickness t <span class=\"val\" id=\"tVal\">170 µm</span>
    <input id=\"t\" type=\"range\" min=\"25\" max=\"210\" value=\"170\" step=\"1\"></label>
  <label>Mode
    <span class=\"seg\"><button id=\"n1\" class=\"on\">fundamental (N=1)</button><button id=\"n3\">3rd overtone (N=3)</button></span></label>
  <label>Shear exaggeration <span class=\"val\" id=\"aVal\">×1</span>
    <input id=\"amp\" type=\"range\" min=\"0\" max=\"2\" value=\"1\" step=\"0.05\"></label>
  <label>Animation speed <span class=\"val\" id=\"sVal\">1.0</span>
    <input id=\"spd\" type=\"range\" min=\"0\" max=\"3\" value=\"1\" step=\"0.1\"></label>
  <label>&nbsp;<button class=\"plain\" id=\"pause\">Pause</button></label>
</div>

<div class=\"grid\">
  <div class=\"panel\">
    <h2>1 · Where the slice comes from — drag to rotate</h2>
    <canvas id=\"cut\" width=\"560\" height=\"400\"></canvas>
    <div class=\"viewbar\">
      <span>views:</span>
      <button id=\"vDefault\">default</button>
      <button id=\"vAlongX\">along X (see the 35° tilt edge-on)</button>
      <button id=\"vDownZ\">down Z (optic axis)</button>
      <button id=\"vAlongY\">along Y</button>
      <button id=\"vSpin\">auto-spin</button>
      <label style=\"display:flex;align-items:center;gap:6px;font-size:12px;color:var(--mute)\"><input type=\"checkbox\" id=\"showBar\" checked> show bar</label>
    </div>
    <p class=\"note\">Quartz bar with crystal axes X, Y, Z. The AT plate is sliced about <b>35°15′</b> off the Z (optic) axis, rotated about X. The plate's own axes: <span style=\"color:var(--x)\">X</span> runs along the plate and is the <b>shear direction</b>; <span style=\"color:var(--y)\">Y′</span> is the <b>thickness</b> normal; <span style=\"color:var(--z)\">Z′</span> is the plate's long direction. Look along X and the plate is a thin line tilted 35° from Z — the whole cut is that one angle. It is what gives near-zero temperature drift at room temperature.</p>
  </div>

  <div class=\"panel\">
    <h2>2 · Frequency vs thickness</h2>
    <canvas id=\"graph\" width=\"560\" height=\"360\"></canvas>
    <div class=\"readout\">
      <div><b id=\"fOut\">9.76 MHz</b><span>f = N · 1660 / t(µm) MHz</span></div>
      <div><b id=\"lamOut\">340 µm</b><span>acoustic wavelength λ = 2t/N</span></div>
      <div><b id=\"ratioOut\">1 : 29</b><span>thickness : width (5 mm blank)</span></div>
      <div><b id=\"dfOut\">+0.59 %</b><span>Δf if 1 µm lapped off</span></div>
    </div>
    <p class=\"note\" id=\"warn\"></p>
  </div>

  <div class=\"panel wide\">
    <h2>3 · Cross-section (X–Y′ plane), shear motion zoomed</h2>
    <canvas id=\"shear\" width=\"1140\" height=\"420\"></canvas>
    <p class=\"note\">Top strip: the plate at true scale, 5 mm wide. Below: the same plate with its thickness blown up so you can see the motion. Vertical lines are material \"fibres\": the top face slides +X while the bottom slides −X, with a node (no motion) at mid-thickness for N=1, and three nodes for N=3. The bevelled edges and the mounting clips sit where the amplitude has died away (energy trapping), so the clamps do not damp the vibration. The piezoelectric voltage between the gold electrodes follows the shear.</p>
  </div>
</div>

<script>
(() => {
  const $ = id => document.getElementById(id);
  const state = { t:170, N:1, amp:1, spd:1, paused:false, phase:0, last:performance.now() };
  const WIDTH_UM = 5000; // 5 mm blank
  const K = 1660;        // MHz·µm for AT-cut thickness-shear

  // ---------- controls ----------
  $('t').oninput = e => { state.t = +e.target.value; updateReadouts(); drawGraph(); };
  $('amp').oninput = e => { state.amp = +e.target.value; $('aVal').textContent = '×' + state.amp.toFixed(2).replace(/\\.?0+$/,''); };
  $('spd').oninput = e => { state.spd = +e.target.value; $('sVal').textContent = state.spd.toFixed(1); };
  $('n1').onclick = () => setN(1); $('n3').onclick = () => setN(3);
  $('pause').onclick = () => { state.paused = !state.paused; $('pause').textContent = state.paused ? 'Play' : 'Pause'; };
  function setN(n){ state.N=n; $('n1').classList.toggle('on',n===1); $('n3').classList.toggle('on',n===3); updateReadouts(); drawGraph(); }

  const freq = (t,N) => N*K/t;
  function updateReadouts(){
    const {t,N} = state;
    const f = freq(t,N);
    $('tVal').textContent = t + ' µm';
    $('fOut').textContent = f.toFixed(2) + ' MHz';
    $('lamOut').textContent = (2*t/N).toFixed(0) + ' µm';
    $('ratioOut').textContent = '1 : ' + Math.round(WIDTH_UM/t);
    $('dfOut').textContent = '+' + (100*(freq(t-1,N)-f)/f).toFixed(2) + ' %';
    let w = '';
    if (t < 40) w = '⚠ Below ~40 µm the plate is too fragile to lap and handle. Real crystals above ~30–40 MHz use the 3rd overtone of a thicker plate, or an etched \"inverted mesa\" pocket in a thick rim.';
    else if (N===3 && f > 60) w = 'Overtone of a thin plate: possible, but usually one would just use a thicker plate at N=3.';
    $('warn').innerHTML = w ? '<span class=\"warn\">'+w+'</span>' : 'The lateral size does not set f; it only has to be many times t so the shear mode is clean and spurious modes stay away.';
  }

  // ---------- helpers ----------
  function arrow(ctx,x1,y1,x2,y2,color,w=2,head=8){
    ctx.strokeStyle=color; ctx.fillStyle=color; ctx.lineWidth=w;
    ctx.beginPath(); ctx.moveTo(x1,y1); ctx.lineTo(x2,y2); ctx.stroke();
    const a=Math.atan2(y2-y1,x2-x1);
    ctx.beginPath(); ctx.moveTo(x2,y2);
    ctx.lineTo(x2-head*Math.cos(a-0.45),y2-head*Math.sin(a-0.45));
    ctx.lineTo(x2-head*Math.cos(a+0.45),y2-head*Math.sin(a+0.45)); ctx.closePath(); ctx.fill();
  }
  function text(ctx,s,x,y,color='#e8e8ec',size=13,align='left',weight=''){
    ctx.fillStyle=color; ctx.font=`${weight} ${size}px system-ui,sans-serif`; ctx.textAlign=align; ctx.textBaseline='middle'; ctx.fillText(s,x,y);
  }

  // ---------- Panel 1: the cut, rotatable 3D ----------
  const view = { yaw:-0.55, pitch:0.38, spin:false, dragged:false, showBar:true };
  const VIEWS = {
    default:{yaw:-0.55,pitch:0.38},
    alongX:{yaw:-Math.PI/2,pitch:0},     // camera on +X looking toward −X: Y–Z plane face-on
    downZ:{yaw:-0.55,pitch:Math.PI/2-0.001},
    alongY:{yaw:0,pitch:0},
  };
  function setView(v){ view.yaw=v.yaw; view.pitch=v.pitch; view.spin=false; $('vSpin').classList.remove('on'); }
  $('vDefault').onclick=()=>setView(VIEWS.default);
  $('vAlongX').onclick=()=>setView(VIEWS.alongX);
  $('vDownZ').onclick=()=>setView(VIEWS.downZ);
  $('vAlongY').onclick=()=>setView(VIEWS.alongY);
  $('vSpin').onclick=()=>{ view.spin=!view.spin; $('vSpin').classList.toggle('on',view.spin); };
  $('showBar').onchange=e=>{ view.showBar=e.target.checked; };

  // pointer drag
  (() => {
    const c=$('cut'); let down=false, lx=0, ly=0;
    c.addEventListener('pointerdown',e=>{down=true;lx=e.clientX;ly=e.clientY;c.setPointerCapture(e.pointerId);c.classList.add('dragging');view.spin=false;$('vSpin').classList.remove('on');});
    c.addEventListener('pointermove',e=>{ if(!down)return; const dx=e.clientX-lx, dy=e.clientY-ly; lx=e.clientX; ly=e.clientY;
      view.yaw += dx*0.011; view.pitch = Math.max(-Math.PI/2+0.01, Math.min(Math.PI/2-0.01, view.pitch + dy*0.011)); view.dragged=true; });
    const up=e=>{down=false;c.classList.remove('dragging');};
    c.addEventListener('pointerup',up); c.addEventListener('pointercancel',up); c.addEventListener('pointerleave',()=>{ if(!down) c.classList.remove('dragging'); });
  })();

  // rotate crystal coords (x,y,z; Z up) into view space: returns [sx, sy, depth, viewVec]
  function makeProjector(W,H){
    const cy=Math.cos(view.yaw), sy=Math.sin(view.yaw), cp=Math.cos(view.pitch), sp=Math.sin(view.pitch);
    const ox=W/2, oy=H/2+10, S=1.0;
    const rot=(x,y,z)=>{ const x1=x*cy - y*sy, y1=x*sy + y*cy; const y2=y1*cp - z*sp, z2=y1*sp + z*cp; return [x1,y2,z2]; };
    const P=(x,y,z)=>{ const [a,d,b]=rot(x,y,z); return [ox+a*S, oy-b*S, d]; };
    return {P,rot};
  }

  function drawCut(){
    const c=$('cut'), ctx=c.getContext('2d'); const W=c.width,H=c.height;
    ctx.clearRect(0,0,W,H);
    const {P,rot}=makeProjector(W,H);
    const th=35.25*Math.PI/180;

    // geometry
    const R=66, hTop=125, hBot=-125;
    const hex=[];for(let i=0;i<6;i++){const a=Math.PI/6+i*Math.PI/3;hex.push([R*Math.cos(a),R*Math.sin(a)]);}
    const halfL=54, halfW=50, thick=6;
    const Zp=[0, Math.sin(th), Math.cos(th)];   // plate long axis, Z tilted toward Y
    const Yp=[0, Math.cos(th), -Math.sin(th)];  // plate normal (thickness)
    const pt=(x,s,n)=>[x, s*Zp[1]+n*Yp[1], s*Zp[2]+n*Yp[2]];

    // polygon list with depth + normal for shading
    const polys=[];
    function addPoly(pts3,fill,stroke,group,lw=1.5){
      const proj=pts3.map(p=>P(...p));
      const depth=proj.reduce((s,p)=>s+p[2],0)/proj.length;
      // normal via cross product in view space
      const a=rot(...pts3[0]),b=rot(...pts3[1]),d=rot(...pts3[2]);
      const u=[b[0]-a[0],b[1]-a[1],b[2]-a[2]], v=[d[0]-a[0],d[1]-a[1],d[2]-a[2]];
      const n=[u[1]*v[2]-u[2]*v[1], u[2]*v[0]-u[0]*v[2], u[0]*v[1]-u[1]*v[0]];
      const len=Math.hypot(...n)||1; const nz=Math.abs(n[1]/len); // |component toward viewer|
      const nl=Math.abs((n[0]*(-0.4)+n[1]*(-0.7)+n[2]*0.6)/len);
      polys.push({proj,depth,fill,stroke,group,shade:0.55+0.45*nl,facing:nz,lw});
    }
    const rgba=(r,g,b,a)=>`rgba(${r},${g},${b},${a})`;

    if(view.showBar){
      for(let i=0;i<6;i++){const a=hex[i],b=hex[(i+1)%6];
        addPoly([[a[0],a[1],hBot],[b[0],b[1],hBot],[b[0],b[1],hTop],[a[0],a[1],hTop]],'bar','bar','bar');}
      addPoly(hex.map(h=>[h[0],h[1],hTop]),'bar','bar','bar');
      addPoly(hex.map(h=>[h[0],h[1],hBot]),'bar','bar','bar');
    }
    // plate: 6 faces
    const c8=(n)=>[pt(-halfL,-halfW,n),pt(halfL,-halfW,n),pt(halfL,halfW,n),pt(-halfL,halfW,n)];
    const lo=c8(-thick/2), hi=c8(thick/2);
    addPoly(hi,'plate','plate','plate'); addPoly(lo,'plate','plate','plate');
    for(let i=0;i<4;i++){const j=(i+1)%4; addPoly([lo[i],lo[j],hi[j],hi[i]],'plate','plate','plate');}

    // draw order: bar faces behind (depth > 0 = far), plate, bar faces in front (translucent)
    const far=polys.filter(p=>p.group==='bar'&&p.depth>=0).sort((a,b)=>b.depth-a.depth);
    const near=polys.filter(p=>p.group==='bar'&&p.depth<0).sort((a,b)=>b.depth-a.depth);
    const plate=polys.filter(p=>p.group==='plate').sort((a,b)=>b.depth-a.depth);
    function paint(p,alphaMul=1){
      ctx.beginPath(); p.proj.forEach((q,i)=>i?ctx.lineTo(q[0],q[1]):ctx.moveTo(q[0],q[1])); ctx.closePath();
      if(p.group==='bar'){ ctx.fillStyle=rgba(143,211,255,0.10*alphaMul*p.shade*1.4); ctx.strokeStyle=rgba(143,211,255,0.5); }
      else { const s=p.shade; ctx.fillStyle=rgba(Math.round(240*s),Math.round(194*s),Math.round(75*s),0.92); ctx.strokeStyle='#f6d47a'; }
      ctx.lineWidth=p.lw; ctx.fill(); ctx.stroke();
    }
    far.forEach(p=>paint(p,1)); plate.forEach(p=>paint(p)); near.forEach(p=>paint(p,0.8));

    // crystal axes (grey) and plate axes (coloured) drawn on top
    const o=P(0,0,0);
    const lab=(s,p,color,dx=0,dy=0,al='center')=>text(ctx,s,p[0]+dx,p[1]+dy,color,13,al,'600');
    const ax=(v,len,color,w,label,pad)=>{ const e=P(v[0]*len,v[1]*len,v[2]*len); arrow(ctx,o[0],o[1],e[0],e[1],color,w); const l=P(v[0]*(len+pad),v[1]*(len+pad),v[2]*(len+pad)); return l; };
    lab('X', ax([1,0,0],150,'#c6c9d1',1.5,'X',14),'#c6c9d1');
    lab('Y', ax([0,1,0],150,'#c6c9d1',1.5,'Y',14),'#c6c9d1');
    lab('Z (optic axis)', ax([0,0,1],170,'#c6c9d1',1.5,'Z',16),'#c6c9d1',0,-4);
    lab('Z′', ax(Zp,120,'#6fa8ff',2,'Z′',14),'#6fa8ff');
    lab('Y′ thickness', ax(Yp,80,'#5be37b',2,'Y′',16),'#5be37b',0,0);
    lab('X  shear', ax([1,0,0],118,'#ff6b6b',2.5,'X',0),'#ff6b6b',0,16);

    // angle arc between Z and Z′ in the Y–Z plane
    ctx.strokeStyle='#ffffff';ctx.lineWidth=1.2;ctx.beginPath();
    for(let a=0;a<=th+1e-6;a+=0.02){const p=P(0,95*Math.sin(a),95*Math.cos(a));a?ctx.lineTo(p[0],p[1]):ctx.moveTo(p[0],p[1]);}
    ctx.stroke();
    const am=P(0,112*Math.sin(th/2),112*Math.cos(th/2)); text(ctx,'35°15′',am[0],am[1],'#fff',13,'center','600');

    const pl=P(...pt(0,-halfW-16,0)); text(ctx,'AT plate',pl[0],pl[1],'#f0c24b',13,'center','600');
    if(view.showBar){ const bl=P(0,0,hBot-16); text(ctx,'quartz bar',bl[0],bl[1],'#8fd3ff',12,'center'); }

    // view readout + hint
    const deg=r=>((r*180/Math.PI)%360+360)%360;
    text(ctx,`yaw ${deg(view.yaw).toFixed(0)}°  pitch ${(view.pitch*180/Math.PI).toFixed(0)}°`,W-10,H-12,'#6b7280',11,'right');
    if(!view.dragged) text(ctx,'↔ drag to rotate',10,14,'#9aa0ab',12,'left');
    // eye direction hint: which axis you look along
    const d=rot(1,0,0)[1], dy=rot(0,1,0)[1], dz=rot(0,0,1)[1];
    const best=[['X',d],['Y',dy],['Z',dz]].sort((a,b)=>Math.abs(b[1])-Math.abs(a[1]))[0];
    if(Math.abs(best[1])>0.97) text(ctx,`looking along ${best[1]>0?'+':'−'}${best[0]}`,10,H-12,'#9aa0ab',11,'left');
  }

  // ---------- Panel 2: graph ----------
  function drawGraph(){
    const c=$('graph'), ctx=c.getContext('2d'); const W=c.width,H=c.height;
    ctx.clearRect(0,0,W,H);
    const L=56,R=20,T=18,B=44; const gw=W-L-R, gh=H-T-B;
    const tmin=20,tmax=220,fmin=0,fmax=80;
    const X=t=>L+(t-tmin)/(tmax-tmin)*gw, Y=f=>T+gh-(f-fmin)/(fmax-fmin)*gh;
    ctx.strokeStyle='#2a2f3a';ctx.lineWidth=1;
    for(let f=0;f<=fmax;f+=10){ctx.beginPath();ctx.moveTo(L,Y(f));ctx.lineTo(W-R,Y(f));ctx.stroke();text(ctx,f,L-8,Y(f),'#9aa0ab',11,'right');}
    for(let t=20;t<=220;t+=40){ctx.beginPath();ctx.moveTo(X(t),T);ctx.lineTo(X(t),T+gh);ctx.stroke();text(ctx,t,X(t),T+gh+14,'#9aa0ab',11,'center');}
    text(ctx,'thickness t (µm)',L+gw/2,H-10,'#9aa0ab',12,'center');
    ctx.save();ctx.translate(14,T+gh/2);ctx.rotate(-Math.PI/2);text(ctx,'frequency (MHz)',0,0,'#9aa0ab',12,'center');ctx.restore();
    ctx.fillStyle='rgba(255,159,67,0.12)';ctx.fillRect(X(tmin),T,X(40)-X(tmin),gh);
    text(ctx,'too thin',X(30),T+12,'#ff9f43',11,'center');
    const curve=(N,color,dash)=>{ctx.setLineDash(dash);ctx.strokeStyle=color;ctx.lineWidth=2;ctx.beginPath();let first=true;
      for(let t=tmin;t<=tmax;t+=1){const f=freq(t,N);if(f>fmax)continue;const x=X(t),y=Y(f);first?ctx.moveTo(x,y):ctx.lineTo(x,y);first=false;}ctx.stroke();ctx.setLineDash([]);};
    curve(1,'#8fd3ff',[]); curve(3,'#f0c24b',[6,4]);
    text(ctx,'N=1 fundamental',X(150),Y(freq(150,1))-14,'#8fd3ff',12,'left');
    text(ctx,'N=3 overtone',X(120),Y(freq(120,3))-14,'#f0c24b',12,'left');
    [[8,'8'],[16,'16'],[32,'32'],[50,'50']].forEach(([f])=>{const t=K/f;if(t>=tmin&&t<=tmax){ctx.fillStyle='#8fd3ff';ctx.beginPath();ctx.arc(X(t),Y(f),3,0,7);ctx.fill();}});
    const f=freq(state.t,state.N); if(f<=fmax){
      ctx.strokeStyle='#ffffff';ctx.setLineDash([3,3]);ctx.beginPath();ctx.moveTo(X(state.t),Y(f));ctx.lineTo(X(state.t),T+gh);ctx.moveTo(X(state.t),Y(f));ctx.lineTo(L,Y(f));ctx.stroke();ctx.setLineDash([]);
      ctx.fillStyle='#fff';ctx.beginPath();ctx.arc(X(state.t),Y(f),6,0,7);ctx.fill();
      text(ctx,`${state.t} µm → ${f.toFixed(1)} MHz`,X(state.t)+10,Y(f)-12,'#fff',12,'left','600');
    } else text(ctx,`${f.toFixed(0)} MHz (off scale)`,W-R-6,T+14,'#fff',12,'right');
  }

  // ---------- Panel 3: shear animation ----------
  const trace=[]; const TRACE_LEN=260;
  function drawShear(){
    const c=$('shear'), ctx=c.getContext('2d'); const W=c.width,H=c.height;
    ctx.clearRect(0,0,W,H);
    const {t,N,amp,phase}=state;
    const s=Math.sin(phase);
    const mainW=820; const left=40;

    const scale=mainW/WIDTH_UM;
    const tsY=28, tsH=Math.max(1,t*scale);
    text(ctx,'true scale, 5 mm wide:',left,tsY-14,'#9aa0ab',12,'left');
    ctx.fillStyle='#8fd3ff';ctx.fillRect(left,tsY,mainW,tsH);
    text(ctx,`t = ${t} µm = ${(t/1000).toFixed(3)} mm`,left+mainW+10,tsY+tsH/2,'#9aa0ab',12,'left');

    const top=90, plateH=200, bottom=top+plateH;
    const cx=left+mainW/2;
    const A=amp*34;
    const env=x=>{const u=(x-cx)/(mainW/2);return Math.exp(-6*u*u);};
    const u=(x,v)=>A*env(x)*Math.cos(N*Math.PI*v)*s;

    const bev=40;
    ctx.beginPath();
    ctx.moveTo(left+u(left,0)+0,top+bev*0.35);
    ctx.lineTo(left+bev+u(left+bev,0),top);
    ctx.lineTo(left+mainW-bev+u(left+mainW-bev,0),top);
    ctx.lineTo(left+mainW+u(left+mainW,0),top+bev*0.35);
    ctx.lineTo(left+mainW+u(left+mainW,1),bottom-bev*0.35);
    ctx.lineTo(left+mainW-bev+u(left+mainW-bev,1),bottom);
    ctx.lineTo(left+bev+u(left+bev,1),bottom);
    ctx.lineTo(left+u(left,1),bottom-bev*0.35);
    ctx.closePath();
    ctx.fillStyle='rgba(143,211,255,0.14)';ctx.fill();ctx.strokeStyle='#8fd3ff';ctx.lineWidth=1.5;ctx.stroke();

    const nF=33; const steps=40;
    for(let i=0;i<=nF;i++){
      const x=left+bev*0.6+(mainW-bev*1.2)*i/nF;
      const inElectrode=Math.abs(x-cx)<mainW*0.22;
      ctx.strokeStyle=inElectrode?'rgba(232,232,236,0.75)':'rgba(232,232,236,0.3)';ctx.lineWidth=1.2;
      ctx.beginPath();
      for(let k=0;k<=steps;k++){const v=k/steps;const px=x+u(x,v),py=top+v*plateH;k?ctx.lineTo(px,py):ctx.moveTo(px,py);}
      ctx.stroke();
    }
    ctx.setLineDash([4,4]);ctx.strokeStyle='rgba(91,227,123,0.6)';ctx.lineWidth=1;
    for(let m=0;m<N;m++){const v=(m+0.5)/N;const y=top+v*plateH;ctx.beginPath();ctx.moveTo(left+10,y);ctx.lineTo(left+mainW-10,y);ctx.stroke();}
    ctx.setLineDash([]);
    text(ctx,N===1?'node (no motion)':'nodes',left+mainW-14,top+(0.5/N)*plateH-10,'#5be37b',11,'right');

    const eW=mainW*0.44;
    ctx.fillStyle='#f0c24b';
    ctx.fillRect(cx-eW/2+u(cx,0),top-6,eW,6);
    ctx.fillRect(cx-eW/2+u(cx,1),bottom,eW,6);
    text(ctx,'gold electrode (~100 nm)',cx+eW/2+8+u(cx,0),top-3,'#f0c24b',11,'left');

    ctx.fillStyle='#6b7280';
    ctx.fillRect(left-10,top+plateH*0.3,14,plateH*0.4);
    ctx.fillRect(left+mainW-4,top+plateH*0.3,14,plateH*0.4);
    text(ctx,'mount',left-3,bottom+16,'#9aa0ab',11,'center');
    text(ctx,'mount',left+mainW+3,bottom+16,'#9aa0ab',11,'center');

    const d=u(cx,0);
    if(Math.abs(s)>0.15){
      const dir=Math.sign(d);
      arrow(ctx,cx-60*dir,top-22,cx+60*dir,top-22,'#ff6b6b',3,10);
      arrow(ctx,cx+60*dir,bottom+22,cx-60*dir,bottom+22,'#ff6b6b',3,10);
    }
    text(ctx,'top face  → +X',cx-eW/2-10,top-22,'#ff6b6b',12,'right','600');
    text(ctx,'bottom face → −X',cx-eW/2-10,bottom+22,'#ff6b6b',12,'right','600');

    arrow(ctx,left,bottom+60,left+70,bottom+60,'#ff6b6b',2); text(ctx,'X (shear)',left+78,bottom+60,'#ff6b6b',12,'left','600');
    arrow(ctx,left+180,bottom+80,left+180,bottom+40,'#5be37b',2); text(ctx,\"Y′ (thickness, not to scale)\",left+190,bottom+60,'#5be37b',12,'left','600');
    arrow(ctx,left+mainW+30,top+plateH/2,left+mainW+30,top,'#5be37b',1.5,7);
    arrow(ctx,left+mainW+30,top+plateH/2,left+mainW+30,bottom,'#5be37b',1.5,7);
    text(ctx,`t = ${t} µm`,left+mainW+40,top+plateH/2-10,'#5be37b',12,'left','600');
    text(ctx,`λ/2 × ${N}`,left+mainW+40,top+plateH/2+10,'#9aa0ab',12,'left');

    const vx=left+mainW+40, vy=bottom+40, vw=W-vx-20, vh=70;
    ctx.strokeStyle='#2a2f3a';ctx.strokeRect(vx,vy,vw,vh);
    text(ctx,'piezo voltage across electrodes',vx,vy-10,'#9aa0ab',11,'left');
    ctx.strokeStyle='#f0c24b';ctx.lineWidth=2;ctx.beginPath();
    for(let i=0;i<trace.length;i++){const px=vx+vw*(i/(TRACE_LEN-1));const py=vy+vh/2-trace[i]*(vh/2-6);i?ctx.lineTo(px,py):ctx.moveTo(px,py);}
    ctx.stroke();
    ctx.fillStyle='#fff';ctx.beginPath();ctx.arc(vx+vw*((trace.length-1)/(TRACE_LEN-1)),vy+vh/2-s*(vh/2-6),3,0,7);ctx.fill();
    text(ctx,`${freq(t,N).toFixed(2)} MHz — shown ~10⁷× slowed`,vx,vy+vh+14,'#9aa0ab',11,'left');
  }

  // ---------- loop ----------
  function frame(now){
    const dt=(now-state.last)/1000; state.last=now;
    if(!state.paused){
      state.phase += dt*state.spd*2*Math.PI*0.8;
      trace.push(Math.sin(state.phase)); if(trace.length>TRACE_LEN) trace.shift();
    }
    if(view.spin) view.yaw += dt*0.5;
    drawCut();
    drawShear();
    requestAnimationFrame(frame);
  }

  updateReadouts(); drawGraph(); requestAnimationFrame(frame);
})();
</script>
</body>
</html>
"
 :AT "2026-11-18T10:36:48" :VERSION 2)
(:PINNED T :ID "reset-circuit-forcing-the-first-fetch" :MAP "computers" :NODE
 "reset-vector-bootstrap" :TYPE "svg" :TITLE "Reset circuit forcing the first fetch" :LANGUAGE NIL
 :CONTENT
 "<svg viewBox=\"0 0 900 730\" xmlns=\"http://www.w3.org/2000/svg\" font-family=\"system-ui,sans-serif\">
<style>
.a1{animation:k1 32s linear infinite}
.a2{animation:k2 32s linear infinite}
.a3{animation:k3 32s linear infinite}
.a4{animation:k4 32s linear infinite}
.a5{animation:k5 32s linear infinite}
.a6{animation:k6 32s linear infinite}
.a7{animation:k7 32s linear infinite}
.aL{animation:kL 32s linear infinite}
.aH{animation:kH 32s linear infinite}
.aG{animation:kG 32s linear infinite}
.aF{animation:kF 32s linear infinite}
.aFz{animation:kFz 32s linear infinite}
.a56{animation:k56 32s linear infinite}
.fl{fill:none;stroke-dasharray:10 8;stroke-linecap:round;animation:flow .7s linear infinite}
.vbar{transform-box:fill-box;transform-origin:0 50%;animation:vcc 32s linear infinite}
.cbar{transform-box:fill-box;transform-origin:0 50%;animation:cap 32s linear infinite}
.cur{animation:cur 32s linear infinite}
@keyframes flow{to{stroke-dashoffset:-18}}
@keyframes cur{from{transform:translateX(0)}to{transform:translateX(210px)}}
@keyframes vcc{0%{transform:scaleX(0)}15%,100%{transform:scaleX(1)}}
@keyframes cap{0%,15%{transform:scaleX(0)}52%,100%{transform:scaleX(1)}}
@keyframes k1{0%,14.5%{opacity:1}15%,100%{opacity:0}}
@keyframes k2{0%,15%{opacity:0}15.5%,36.5%{opacity:1}37%,100%{opacity:0}}
@keyframes k3{0%,37%{opacity:0}37.5%,51.5%{opacity:1}52%,100%{opacity:0}}
@keyframes k4{0%,52%{opacity:0}52.5%,64.5%{opacity:1}65%,100%{opacity:0}}
@keyframes k5{0%,65%{opacity:0}65.5%,77.5%{opacity:1}78%,100%{opacity:0}}
@keyframes k6{0%,78%{opacity:0}78.5%,89.5%{opacity:1}90%,100%{opacity:0}}
@keyframes k7{0%,90%{opacity:0}90.5%,99.5%{opacity:1}100%{opacity:0}}
@keyframes kL{0%,15%{opacity:0}15.5%,51.5%{opacity:1}52%,100%{opacity:0}}
@keyframes kH{0%,52%{opacity:0}52.5%,100%{opacity:1}}
@keyframes kG{0%,36.5%{opacity:1}37%,100%{opacity:0}}
@keyframes kF{0%,37%{opacity:0}37.5%,89.5%{opacity:1}90%,100%{opacity:0}}
@keyframes kFz{0%,51.5%{opacity:1}52%,100%{opacity:0}}
@keyframes k56{0%,65%{opacity:0}65.5%,89.5%{opacity:1}90%,100%{opacity:0}}
</style>
<rect width=\"900\" height=\"730\" fill=\"#fff\"/>
<text x=\"450\" y=\"30\" font-size=\"20\" font-weight=\"bold\" text-anchor=\"middle\">Power-on: how a wire forces the first fetch</text>
<text x=\"450\" y=\"48\" font-size=\"12\" text-anchor=\"middle\" fill=\"#666\">animated loop, 32 s. Moving dashes show current/logic flow; colour shows what the wire is doing.</text>

<!-- ===== static base wires ===== -->
<g fill=\"none\" stroke=\"#ccc\" stroke-width=\"4\">
<path d=\"M160 105 L230 105\"/>
<path d=\"M60 140 L60 270 L330 270\"/>
<path d=\"M400 105 L520 105 L520 250\"/>
<path d=\"M520 235 L445 235 L445 295\"/>
<path d=\"M520 235 L655 235 L655 295\"/>
<path d=\"M160 330 L330 330\" stroke-dasharray=\"6 4\"/>
<path d=\"M445 520 L445 560 L425 560\"/>
<path d=\"M350 560 L330 560\"/>
<path d=\"M200 520 L200 480 L330 480 L330 455 L350 455\"/>
</g>
<circle cx=\"520\" cy=\"235\" r=\"5\" fill=\"#ccc\"/>

<!-- Power supply -->
<rect x=\"20\" y=\"70\" width=\"140\" height=\"70\" rx=\"8\" fill=\"#fdecea\" stroke=\"#c0392b\" stroke-width=\"2\"/>
<text x=\"90\" y=\"92\" font-size=\"14\" text-anchor=\"middle\" font-weight=\"bold\">Power supply</text>
<text x=\"90\" y=\"110\" font-size=\"12\" text-anchor=\"middle\">rails ramp 0 → 3.3 V</text>
<rect x=\"35\" y=\"120\" width=\"110\" height=\"9\" fill=\"#eee\" stroke=\"#c0392b\" stroke-width=\"0.5\"/>
<rect class=\"vbar\" x=\"35\" y=\"120\" width=\"110\" height=\"9\" fill=\"#c0392b\"/>
<text x=\"62\" y=\"158\" font-size=\"11\" fill=\"#c0392b\" text-anchor=\"start\">VCC to CPU and ROM</text>

<!-- Reset generator -->
<rect x=\"230\" y=\"60\" width=\"170\" height=\"110\" rx=\"8\" fill=\"#fff4e0\" stroke=\"#e67e22\" stroke-width=\"2\"/>
<text x=\"315\" y=\"80\" font-size=\"14\" text-anchor=\"middle\" font-weight=\"bold\">Reset generator</text>
<text x=\"315\" y=\"97\" font-size=\"12\" text-anchor=\"middle\">supervisor chip, or R + C delay:</text>
<text x=\"315\" y=\"112\" font-size=\"12\" text-anchor=\"middle\">holds RESET# low until VCC</text>
<text x=\"315\" y=\"127\" font-size=\"12\" text-anchor=\"middle\">and clock are stable</text>
<rect x=\"240\" y=\"137\" width=\"150\" height=\"9\" fill=\"#eee\" stroke=\"#e67e22\" stroke-width=\"0.5\"/>
<rect class=\"cbar\" x=\"240\" y=\"137\" width=\"150\" height=\"9\" fill=\"#e67e22\"/>
<text x=\"315\" y=\"162\" font-size=\"11\" text-anchor=\"middle\" fill=\"#a85a10\">capacitor charging toward threshold</text>

<!-- Reset button -->
<rect x=\"230\" y=\"185\" width=\"170\" height=\"36\" rx=\"6\" fill=\"#f3f3f3\" stroke=\"#888\"/>
<text x=\"315\" y=\"208\" font-size=\"12\" text-anchor=\"middle\">manual reset button → GND</text>
<line x1=\"315\" y1=\"185\" x2=\"315\" y2=\"170\" stroke=\"#888\" stroke-width=\"2\"/>

<!-- Waveform panel -->
<rect x=\"640\" y=\"60\" width=\"240\" height=\"145\" rx=\"6\" fill=\"#f8faff\" stroke=\"#bbb\"/>
<text x=\"760\" y=\"78\" font-size=\"12\" text-anchor=\"middle\" font-weight=\"bold\">VCC and RESET# vs time</text>
<line x1=\"655\" y1=\"185\" x2=\"865\" y2=\"185\" stroke=\"#999\"/>
<polyline points=\"655,185 687,100 865,100\" fill=\"none\" stroke=\"#c0392b\" stroke-width=\"3\"/>
<polyline points=\"655,185 764,185 764,125 865,125\" fill=\"none\" stroke=\"#2b5fd9\" stroke-width=\"3\"/>
<text x=\"800\" y=\"94\" font-size=\"11\" fill=\"#c0392b\">VCC</text>
<text x=\"800\" y=\"119\" font-size=\"11\" fill=\"#2b5fd9\">RESET#</text>
<text x=\"710\" y=\"200\" font-size=\"11\" text-anchor=\"middle\" fill=\"#2b5fd9\">LOW: CPU frozen</text>
<text x=\"815\" y=\"200\" font-size=\"11\" text-anchor=\"middle\" fill=\"#2b5fd9\">HIGH: runs</text>
<line class=\"cur\" x1=\"655\" y1=\"88\" x2=\"655\" y2=\"185\" stroke=\"#222\" stroke-width=\"2\" stroke-dasharray=\"3 3\"/>

<!-- CPU -->
<rect x=\"330\" y=\"250\" width=\"440\" height=\"270\" rx=\"10\" fill=\"#eef3ff\" stroke=\"#2b5fd9\" stroke-width=\"3\"/>
<text x=\"550\" y=\"275\" font-size=\"16\" text-anchor=\"middle\" font-weight=\"bold\">CPU</text>

<rect x=\"350\" y=\"295\" width=\"190\" height=\"90\" rx=\"6\" fill=\"#fff\" stroke=\"#2b5fd9\"/>
<text x=\"445\" y=\"316\" font-size=\"13\" text-anchor=\"middle\" font-weight=\"bold\">Program counter (PC)</text>
<text x=\"445\" y=\"335\" font-size=\"12\" text-anchor=\"middle\">flip-flops with a reset input.</text>
<text x=\"445\" y=\"351\" font-size=\"12\" text-anchor=\"middle\">RESET# low → bits forced to:</text>
<text class=\"aG\" x=\"445\" y=\"374\" font-size=\"15\" text-anchor=\"middle\" font-family=\"monospace\" fill=\"#999\">0x???????? (garbage)</text>
<text class=\"aF\" x=\"445\" y=\"374\" font-size=\"15\" text-anchor=\"middle\" font-family=\"monospace\" font-weight=\"bold\" fill=\"#2b5fd9\">0xFFFFFFF0</text>
<text class=\"a7\" x=\"445\" y=\"374\" font-size=\"14\" text-anchor=\"middle\" font-family=\"monospace\" font-weight=\"bold\" fill=\"#27ae60\">next: 0xFFFFFFF0 + n</text>

<rect x=\"560\" y=\"295\" width=\"190\" height=\"90\" rx=\"6\" fill=\"#fff\" stroke=\"#2b5fd9\"/>
<text x=\"655\" y=\"316\" font-size=\"13\" text-anchor=\"middle\" font-weight=\"bold\">Control unit</text>
<text x=\"655\" y=\"335\" font-size=\"12\" text-anchor=\"middle\">reset: caches off, interrupts</text>
<text x=\"655\" y=\"351\" font-size=\"12\" text-anchor=\"middle\">masked, registers known</text>
<text class=\"aG\" x=\"655\" y=\"374\" font-size=\"13\" text-anchor=\"middle\" fill=\"#999\">state: unknown</text>
<text class=\"aF\" x=\"655\" y=\"374\" font-size=\"13\" text-anchor=\"middle\" font-weight=\"bold\" fill=\"#2b5fd9\">state: FETCH</text>
<text class=\"a7\" x=\"655\" y=\"374\" font-size=\"13\" text-anchor=\"middle\" font-weight=\"bold\" fill=\"#27ae60\">state: DECODE → EXECUTE</text>

<rect x=\"350\" y=\"405\" width=\"400\" height=\"95\" rx=\"6\" fill=\"#fff\" stroke=\"#27ae60\" stroke-width=\"2\"/>
<text x=\"550\" y=\"425\" font-size=\"13\" text-anchor=\"middle\" font-weight=\"bold\">Fetch → Decode → Execute loop</text>
<g font-size=\"13\" text-anchor=\"middle\">
<rect x=\"370\" y=\"438\" width=\"105\" height=\"28\" rx=\"5\" fill=\"#eee\"/><text x=\"422\" y=\"457\" fill=\"#666\">FETCH</text>
<rect x=\"487\" y=\"438\" width=\"105\" height=\"28\" rx=\"5\" fill=\"#eee\"/><text x=\"539\" y=\"457\" fill=\"#666\">DECODE</text>
<rect x=\"604\" y=\"438\" width=\"105\" height=\"28\" rx=\"5\" fill=\"#eee\"/><text x=\"656\" y=\"457\" fill=\"#666\">EXECUTE</text>
<g class=\"a56\"><rect x=\"370\" y=\"438\" width=\"105\" height=\"28\" rx=\"5\" fill=\"#27ae60\"/><text x=\"422\" y=\"457\" fill=\"#fff\" font-weight=\"bold\">FETCH</text></g>
<g class=\"a7\"><rect x=\"487\" y=\"438\" width=\"105\" height=\"28\" rx=\"5\" fill=\"#27ae60\"/><text x=\"539\" y=\"457\" fill=\"#fff\" font-weight=\"bold\">DECODE</text>
<rect x=\"604\" y=\"438\" width=\"105\" height=\"28\" rx=\"5\" fill=\"#27ae60\"/><text x=\"656\" y=\"457\" fill=\"#fff\" font-weight=\"bold\">EXECUTE</text></g>
</g>
<text class=\"aFz\" x=\"550\" y=\"488\" font-size=\"12\" text-anchor=\"middle\" fill=\"#c0392b\" font-weight=\"bold\">FROZEN: RESET# low, no cycle runs</text>
<text class=\"aH\" x=\"550\" y=\"488\" font-size=\"12\" text-anchor=\"middle\" fill=\"#27ae60\">RUNNING: each clock edge steps the cycle, PC += length</text>

<!-- Clock -->
<rect x=\"20\" y=\"300\" width=\"140\" height=\"60\" rx=\"8\" fill=\"#f3f3f3\" stroke=\"#888\"/>
<text x=\"90\" y=\"325\" font-size=\"13\" text-anchor=\"middle\" font-weight=\"bold\">Crystal + clock</text>
<text x=\"90\" y=\"343\" font-size=\"12\" text-anchor=\"middle\">steps the cycle</text>
<text class=\"aL\" x=\"245\" y=\"322\" font-size=\"11\" text-anchor=\"middle\" fill=\"#0d2a8a\">ticking, but ignored</text>
<text class=\"aH\" x=\"245\" y=\"322\" font-size=\"11\" text-anchor=\"middle\" fill=\"#27ae60\">clock now steps CPU</text>

<!-- Address decoder -->
<rect x=\"350\" y=\"535\" width=\"75\" height=\"50\" rx=\"6\" fill=\"#f4ecf7\" stroke=\"#8e44ad\" stroke-width=\"2\"/>
<text x=\"387\" y=\"557\" font-size=\"11\" text-anchor=\"middle\" fill=\"#6c3483\">address</text>
<text x=\"387\" y=\"571\" font-size=\"11\" text-anchor=\"middle\" fill=\"#6c3483\">decoder</text>
<text x=\"350\" y=\"602\" font-size=\"11\" fill=\"#6c3483\">top addresses → ROM chip-select</text>
<text x=\"458\" y=\"548\" font-size=\"12\" fill=\"#8e44ad\">address bus: PC value</text>

<!-- ROM -->
<rect x=\"60\" y=\"520\" width=\"270\" height=\"90\" rx=\"8\" fill=\"#f4ecf7\" stroke=\"#8e44ad\" stroke-width=\"2\"/>
<text x=\"195\" y=\"545\" font-size=\"14\" text-anchor=\"middle\" font-weight=\"bold\">Boot ROM / flash</text>
<text x=\"195\" y=\"565\" font-size=\"12\" text-anchor=\"middle\">decoder maps the top of the</text>
<text x=\"195\" y=\"581\" font-size=\"12\" text-anchor=\"middle\">address space to this chip, so the</text>
<text x=\"195\" y=\"597\" font-size=\"12\" text-anchor=\"middle\">first instruction is already there</text>
<text x=\"218\" y=\"502\" font-size=\"11\" fill=\"#b9590c\">data bus: instruction</text>
<text x=\"218\" y=\"515\" font-size=\"11\" fill=\"#b9590c\">word returns</text>

<!-- ===== animated overlays ===== -->
<!-- step 1: power -->
<g class=\"a1\">
<path class=\"fl\" d=\"M160 105 L230 105\" stroke=\"#c0392b\" stroke-width=\"5\"/>
<path class=\"fl\" d=\"M60 140 L60 270 L330 270\" stroke=\"#c0392b\" stroke-width=\"5\"/>
<rect x=\"20\" y=\"70\" width=\"140\" height=\"70\" rx=\"8\" fill=\"none\" stroke=\"#c0392b\" stroke-width=\"4\"/>
<text x=\"195\" y=\"96\" font-size=\"11\" fill=\"#c0392b\" text-anchor=\"middle\">power-good?</text>
</g>
<!-- RESET low -->
<g class=\"aL\">
<path class=\"fl\" d=\"M400 105 L520 105 L520 250\" stroke=\"#0d2a8a\" stroke-width=\"5\"/>
<path class=\"fl\" d=\"M520 235 L445 235 L445 295\" stroke=\"#0d2a8a\" stroke-width=\"5\"/>
<path class=\"fl\" d=\"M520 235 L655 235 L655 295\" stroke=\"#0d2a8a\" stroke-width=\"5\"/>
<text x=\"462\" y=\"95\" font-size=\"13\" font-weight=\"bold\" fill=\"#0d2a8a\" text-anchor=\"middle\">RESET# = LOW (0 V)</text>
</g>
<g class=\"a2\"><rect x=\"230\" y=\"60\" width=\"170\" height=\"110\" rx=\"8\" fill=\"none\" stroke=\"#e67e22\" stroke-width=\"4\"/></g>
<g class=\"a3\">
<rect x=\"350\" y=\"295\" width=\"190\" height=\"90\" rx=\"6\" fill=\"none\" stroke=\"#0d2a8a\" stroke-width=\"4\"/>
<rect x=\"560\" y=\"295\" width=\"190\" height=\"90\" rx=\"6\" fill=\"none\" stroke=\"#0d2a8a\" stroke-width=\"4\"/>
</g>
<!-- RESET high -->
<g class=\"aH\">
<path class=\"fl\" d=\"M400 105 L520 105 L520 250\" stroke=\"#27ae60\" stroke-width=\"5\"/>
<path class=\"fl\" d=\"M520 235 L445 235 L445 295\" stroke=\"#27ae60\" stroke-width=\"5\"/>
<path class=\"fl\" d=\"M520 235 L655 235 L655 295\" stroke=\"#27ae60\" stroke-width=\"5\"/>
<text x=\"462\" y=\"95\" font-size=\"13\" font-weight=\"bold\" fill=\"#27ae60\" text-anchor=\"middle\">RESET# = HIGH (3.3 V)</text>
<path class=\"fl\" d=\"M160 330 L330 330\" stroke=\"#27ae60\" stroke-width=\"5\"/>
</g>
<g class=\"a4\"><rect x=\"230\" y=\"60\" width=\"170\" height=\"110\" rx=\"8\" fill=\"none\" stroke=\"#27ae60\" stroke-width=\"4\"/></g>
<!-- low: clock ticking but ignored -->
<g class=\"aL\"><path class=\"fl\" d=\"M160 330 L330 330\" stroke=\"#999\" stroke-width=\"3\"/></g>
<!-- step 5: address -->
<g class=\"a5\">
<path class=\"fl\" d=\"M445 520 L445 560 L425 560\" stroke=\"#8e44ad\" stroke-width=\"5\"/>
<path class=\"fl\" d=\"M350 560 L330 560\" stroke=\"#8e44ad\" stroke-width=\"5\"/>
<rect x=\"350\" y=\"535\" width=\"75\" height=\"50\" rx=\"6\" fill=\"none\" stroke=\"#8e44ad\" stroke-width=\"4\"/>
</g>
<!-- step 6: data -->
<g class=\"a6\">
<path class=\"fl\" d=\"M200 520 L200 480 L330 480 L330 455 L350 455\" stroke=\"#e67e22\" stroke-width=\"5\"/>
<rect x=\"60\" y=\"520\" width=\"270\" height=\"90\" rx=\"8\" fill=\"none\" stroke=\"#e67e22\" stroke-width=\"4\"/>
</g>
<!-- step 7 -->
<g class=\"a7\"><rect x=\"350\" y=\"405\" width=\"400\" height=\"95\" rx=\"6\" fill=\"none\" stroke=\"#27ae60\" stroke-width=\"4\"/></g>

<!-- step badges -->
<g font-size=\"13\" font-weight=\"bold\" text-anchor=\"middle\" fill=\"#fff\">
<g class=\"a1\"><circle cx=\"20\" cy=\"70\" r=\"12\" fill=\"#c0392b\"/><text x=\"20\" y=\"75\">1</text></g>
<g class=\"a2\"><circle cx=\"230\" cy=\"60\" r=\"12\" fill=\"#e67e22\"/><text x=\"230\" y=\"65\">2</text></g>
<g class=\"a3\"><circle cx=\"350\" cy=\"295\" r=\"12\" fill=\"#0d2a8a\"/><text x=\"350\" y=\"300\">3</text><circle cx=\"560\" cy=\"295\" r=\"12\" fill=\"#0d2a8a\"/><text x=\"560\" y=\"300\">3</text></g>
<g class=\"a4\"><circle cx=\"520\" cy=\"150\" r=\"12\" fill=\"#27ae60\"/><text x=\"520\" y=\"155\">4</text></g>
<g class=\"a5\"><circle cx=\"350\" cy=\"535\" r=\"12\" fill=\"#8e44ad\"/><text x=\"350\" y=\"540\">5</text></g>
<g class=\"a6\"><circle cx=\"200\" cy=\"500\" r=\"12\" fill=\"#e67e22\"/><text x=\"200\" y=\"505\">6</text></g>
<g class=\"a7\"><circle cx=\"350\" cy=\"405\" r=\"12\" fill=\"#27ae60\"/><text x=\"350\" y=\"410\">7</text></g>
</g>

<!-- caption box -->
<rect x=\"20\" y=\"624\" width=\"860\" height=\"66\" rx=\"8\" fill=\"#fffbea\" stroke=\"#d4ac0d\"/>
<g font-size=\"13\">
<g class=\"a1\"><text x=\"34\" y=\"645\" font-size=\"15\" font-weight=\"bold\">1 · Power rises: voltage is not yet trustworthy</text>
<text x=\"34\" y=\"663\">The supply ramps 0 → 3.3 V. While it climbs, flip-flops power up in random states, so nothing may run yet.</text>
<text x=\"34\" y=\"679\">The same rail feeds the CPU, the ROM and the reset generator.</text></g>
<g class=\"a2\"><text x=\"34\" y=\"645\" font-size=\"15\" font-weight=\"bold\">2 · The reset generator holds RESET# low</text>
<text x=\"34\" y=\"663\">A supervisor chip (or capacitor C charging through resistor R) keeps RESET# at 0 V until VCC passes its threshold.</text>
<text x=\"34\" y=\"679\">The crystal ticks meanwhile but the CPU ignores it. The button can pull the same wire to ground.</text></g>
<g class=\"a3\"><text x=\"34\" y=\"645\" font-size=\"15\" font-weight=\"bold\">3 · RESET# low forces a known state</text>
<text x=\"34\" y=\"663\">The wire drives the reset pins of the PC's flip-flops. Their reset value is fixed in silicon (0xFFFFFFF0 on x86).</text>
<text x=\"34\" y=\"679\">It also puts the control unit in FETCH, masks interrupts, clears caches: garbage becomes a defined start.</text></g>
<g class=\"a4\"><text x=\"34\" y=\"645\" font-size=\"15\" font-weight=\"bold\">4 · Threshold crossed: RESET# released</text>
<text x=\"34\" y=\"663\">VCC and the clock are stable, so the generator lets RESET# go high, after a guaranteed delay, on every power-on.</text>
<text x=\"34\" y=\"679\">That fixed delay is why the start is repeatable. Now each clock edge advances the cycle.</text></g>
<g class=\"a5\"><text x=\"34\" y=\"645\" font-size=\"15\" font-weight=\"bold\">5 · Fetch: the PC value goes on the address bus</text>
<text x=\"34\" y=\"663\">The address decoder sees a top-of-memory address and asserts the ROM's chip-select, so the boot ROM/flash answers.</text>
<text x=\"34\" y=\"679\">The memory map is wired so that ROM is what lives at the reset address.</text></g>
<g class=\"a6\"><text x=\"34\" y=\"645\" font-size=\"15\" font-weight=\"bold\">6 · The ROM puts the instruction word on the data bus</text>
<text x=\"34\" y=\"663\">The word stored at the reset address travels back to the CPU.</text>
<text x=\"34\" y=\"679\">It is the first instruction of the first loader.</text></g>
<g class=\"a7\"><text x=\"34\" y=\"645\" font-size=\"15\" font-weight=\"bold\">7 · Decode, execute, PC += length, repeat</text>
<text x=\"34\" y=\"663\">The control unit decodes and executes the word, then advances the PC. From here it is the ordinary FDE loop,</text>
<text x=\"34\" y=\"679\">only started at an address chosen by wiring, not by software. The animation now loops.</text></g>
</g>

<!-- step progress pills -->
<g font-size=\"12\" text-anchor=\"middle\">
<rect x=\"20\" y=\"698\" width=\"116\" height=\"24\" rx=\"12\" fill=\"#eee\"/><text x=\"78\" y=\"714\" fill=\"#555\">1 Power rises</text>
<rect x=\"144\" y=\"698\" width=\"116\" height=\"24\" rx=\"12\" fill=\"#eee\"/><text x=\"202\" y=\"714\" fill=\"#555\">2 Hold RESET#</text>
<rect x=\"268\" y=\"698\" width=\"116\" height=\"24\" rx=\"12\" fill=\"#eee\"/><text x=\"326\" y=\"714\" fill=\"#555\">3 Force PC</text>
<rect x=\"392\" y=\"698\" width=\"116\" height=\"24\" rx=\"12\" fill=\"#eee\"/><text x=\"450\" y=\"714\" fill=\"#555\">4 Release</text>
<rect x=\"516\" y=\"698\" width=\"116\" height=\"24\" rx=\"12\" fill=\"#eee\"/><text x=\"574\" y=\"714\" fill=\"#555\">5 Fetch</text>
<rect x=\"640\" y=\"698\" width=\"116\" height=\"24\" rx=\"12\" fill=\"#eee\"/><text x=\"698\" y=\"714\" fill=\"#555\">6 ROM answers</text>
<rect x=\"764\" y=\"698\" width=\"116\" height=\"24\" rx=\"12\" fill=\"#eee\"/><text x=\"822\" y=\"714\" fill=\"#555\">7 Decode/exec</text>
<g fill=\"#fff\" font-weight=\"bold\">
<g class=\"a1\"><rect x=\"20\" y=\"698\" width=\"116\" height=\"24\" rx=\"12\" fill=\"#c0392b\"/><text x=\"78\" y=\"714\">1 Power rises</text></g>
<g class=\"a2\"><rect x=\"144\" y=\"698\" width=\"116\" height=\"24\" rx=\"12\" fill=\"#e67e22\"/><text x=\"202\" y=\"714\">2 Hold RESET#</text></g>
<g class=\"a3\"><rect x=\"268\" y=\"698\" width=\"116\" height=\"24\" rx=\"12\" fill=\"#0d2a8a\"/><text x=\"326\" y=\"714\">3 Force PC</text></g>
<g class=\"a4\"><rect x=\"392\" y=\"698\" width=\"116\" height=\"24\" rx=\"12\" fill=\"#27ae60\"/><text x=\"450\" y=\"714\">4 Release</text></g>
<g class=\"a5\"><rect x=\"516\" y=\"698\" width=\"116\" height=\"24\" rx=\"12\" fill=\"#8e44ad\"/><text x=\"574\" y=\"714\">5 Fetch</text></g>
<g class=\"a6\"><rect x=\"640\" y=\"698\" width=\"116\" height=\"24\" rx=\"12\" fill=\"#e67e22\"/><text x=\"698\" y=\"714\">6 ROM answers</text></g>
<g class=\"a7\"><rect x=\"764\" y=\"698\" width=\"116\" height=\"24\" rx=\"12\" fill=\"#27ae60\"/><text x=\"822\" y=\"714\">7 Decode/exec</text></g>
</g>
</g>
</svg>"
 :AT "2026-11-18T10:57:53" :VERSION 2)
(:PINNED T :ID "linking-and-loading-step-through" :MAP "computers" :NODE "linking-loading" :TYPE
 "html" :TITLE "Linking and loading: step through" :LANGUAGE NIL :CONTENT
 "<!DOCTYPE html><html><head><meta charset=\"utf-8\"><style>
body{font-family:system-ui,sans-serif;margin:0;padding:14px;background:#0f172a;color:#e2e8f0}
h3{margin:0 0 6px;font-size:15px}
.row{display:flex;gap:12px;flex-wrap:wrap}
.box{background:#1e293b;border:2px solid #475569;border-radius:8px;padding:8px;min-width:140px;transition:all .5s}
.box.hl{border-color:#fbbf24;box-shadow:0 0 12px #fbbf2466}
.cell{font-family:monospace;font-size:12px;padding:3px 6px;margin:2px 0;border-radius:4px;background:#334155;transition:all .5s}
.unres{background:#7f1d1d}.res{background:#166534}.pc{outline:2px solid #38bdf8}
.mem .cell{height:16px;background:#1e293b;border:1px dashed #475569}
.mem .cell.f{background:#1d4ed8;border:1px solid #60a5fa}.mem .cell.d{background:#7c3aed;border:1px solid #c4b5fd}.mem .cell.l{background:#0f766e;border:1px solid #5eead4}
button{background:#38bdf8;border:0;border-radius:6px;padding:8px 14px;font-weight:600;cursor:pointer;margin-right:6px}
#msg{margin:12px 0;padding:10px;background:#1e293b;border-left:4px solid #fbbf24;min-height:44px;font-size:14px}
.arrow{align-self:center;font-size:24px;opacity:.5}
</style></head><body>
<div id=\"msg\"></div>
<div><button onclick=\"prev()\">◀ Back</button><button onclick=\"next()\">Next ▶</button><button onclick=\"play()\">▶ Auto</button> <span id=\"st\"></span></div>
<br>
<div class=\"row\">
<div class=\"box\" id=\"A\"><h3>main.o</h3>
<div class=\"cell\">0: main code</div><div class=\"cell unres\" id=\"c1\">call print → ???</div><div class=\"cell\">data: \"hi\"</div></div>
<div class=\"box\" id=\"B\"><h3>print.o</h3><div class=\"cell\">0: print code</div><div class=\"cell\">symbol: print</div></div>
<div class=\"box\" id=\"L\"><h3>libc.so (shared)</h3><div class=\"cell\">write()</div><div class=\"cell\">symbol: write</div></div>
<div class=\"arrow\">→</div>
<div class=\"box\" id=\"E\"><h3>executable</h3>
<div class=\"cell\" id=\"h\">header: entry=?</div>
<div class=\"cell\" id=\"e1\">code @ ?</div><div class=\"cell\" id=\"e2\">call → ???</div><div class=\"cell\" id=\"e3\">data @ ?</div></div>
<div class=\"arrow\">→</div>
<div class=\"box mem\" id=\"M\"><h3>memory</h3>
<div id=\"mem\"></div><div class=\"cell\" id=\"pc\" style=\"background:none;border:0;color:#38bdf8;margin-top:6px\">PC = —</div></div>
</div>
<script>
const mem=document.getElementById('mem');
for(let i=0;i<8;i++){mem.innerHTML+=`<div class=\"cell\" id=\"m${i}\">0x${(0x400000+i*0x10).toString(16)}</div>`}
const $=id=>document.getElementById(id);
const steps=[
[\"Start: separate object files. main.o calls print, but doesn't know where print lives — an unresolved reference.\",()=>{}],
[\"LINKER: collects the pieces and lays them out one after another. Each section gets an address.\",()=>{$('A').classList.add('hl');$('B').classList.add('hl');$('e1').textContent='code @ 0x400000';$('e3').textContent='data @ 0x400030'}],
[\"LINKER: resolves the name 'print' to its new address 0x400020 and patches the call. The libc reference is left for load time (dynamic linking).\",()=>{$('c1').className='cell res';$('c1').textContent='call print → 0x400020';$('e2').textContent='call → 0x400020';$('e2').className='cell res';$('h').textContent='header: entry=0x400000'}],
[\"Executable written to disk: a header (where things go, entry point) plus code and data.\",()=>{['A','B'].forEach(i=>$(i).classList.remove('hl'));$('E').classList.add('hl')}],
[\"LOADER: reads the header and copies code and data into memory at the stated addresses.\",()=>{[0,1,2,3].forEach(i=>$('m'+i).className='cell f');[4].forEach(i=>$('m'+i).className='cell d');$('m0').textContent='code main';$('m1').textContent='code main';$('m2').textContent='code print';$('m3').textContent='code print';$('m4').textContent='data \"hi\"'}],
[\"LOADER (dynamic linking): maps the shared libc once and fixes up the call to write() so it points at the shared copy.\",()=>{$('L').classList.add('hl');$('m6').className='cell l';$('m6').textContent='libc write (shared)'}],
[\"LOADER: sets the PC to the entry point from the header and jumps. The program runs.\",()=>{$('L').classList.remove('hl');$('E').classList.remove('hl');$('pc').textContent='PC = 0x400000 ▶ running';$('m0').classList.add('pc')}]
];
let i=0,t=null;
function show(){$('msg').textContent=(i+1)+'/'+steps.length+'  '+steps[i][0];}
function reset(){location.reload()}
function render(n){document.querySelectorAll('.hl,.pc').forEach(e=>e.classList.remove('hl','pc'));
 $('c1').className='cell unres';$('c1').textContent='call print → ???';$('e1').textContent='code @ ?';$('e2').textContent='call → ???';$('e2').className='cell';$('e3').textContent='data @ ?';$('h').textContent='header: entry=?';
 for(let k=0;k<8;k++){$('m'+k).className='cell';$('m'+k).textContent='0x'+(0x400000+k*16).toString(16)}$('pc').textContent='PC = —';
 for(let k=0;k<=n;k++)steps[k][1]();i=n;show();$('st').textContent=''}
function next(){if(i<steps.length-1)render(i+1)}
function prev(){if(i>0)render(i-1)}
function play(){clearInterval(t);render(0);t=setInterval(()=>{if(i>=steps.length-1)clearInterval(t);else next()},2500)}
render(0);
</script></body></html>"
 :AT "2026-11-18T11:03:39" :VERSION 1)
(:PINNED T :ID "power-on-to-database-row" :MAP "computers" :NODE "btree-indexes" :TYPE "html"
 :TITLE "Power-on to database row" :LANGUAGE NIL :CONTENT "<!DOCTYPE html>
<html lang=\"en\">
<head>
<meta charset=\"utf-8\">
<title>From power-on to a database row</title>
<style>
:root{--bg:#f3f5f8;--panel:#ffffff;--ink:#1b2430;--muted:#5b6778;--hot:#ff6a00;--data:#0a7cc2;--pwr:#e0a400;--net:#c2187a;--rd:#d9480f;--line:#d6dce6}
*{box-sizing:border-box}
body{margin:0;background:var(--bg);color:var(--ink);font:15px/1.45 system-ui,-apple-system,Segoe UI,sans-serif;height:100vh;display:grid;grid-template-rows:auto 1fr}
header{display:flex;gap:10px;align-items:center;padding:8px 14px;background:var(--panel);border-bottom:1px solid var(--line);flex-wrap:wrap}
header h1{font-size:15px;margin:0;flex:1;min-width:200px}
button,select{background:#fff;color:var(--ink);border:1px solid #b9c2d0;border-radius:6px;padding:6px 12px;cursor:pointer;font-size:14px}
button:hover{background:#eef2f7}
main{display:grid;grid-template-columns:1fr 400px;min-height:0}
@media (max-width:900px){main{grid-template-columns:1fr;grid-template-rows:55% 45%}}
#stage{min-height:0;position:relative;background:var(--bg)}
svg{width:100%;height:100%;display:block}
aside{background:var(--panel);border-left:1px solid var(--line);padding:14px 16px;overflow:auto}
aside h2{margin:0 0 4px;font-size:18px}
.meta{display:flex;gap:8px;flex-wrap:wrap;margin:6px 0 12px}
.tag{font-size:12px;padding:2px 8px;border-radius:10px;background:#eef2f7;color:var(--muted)}
.tag b{color:var(--ink)}
aside p{margin:0 0 10px}
aside code{background:#eef2f7;padding:1px 5px;border-radius:4px;font-size:13px}
aside ol,aside ul{padding-left:20px;margin:0 0 10px}
aside li{margin-bottom:4px}
.key{margin-top:14px;font-size:12px;color:var(--muted);border-top:1px solid var(--line);padding-top:8px}
.key span{display:inline-block;margin-right:12px}
.key i{display:inline-block;width:10px;height:10px;border-radius:50%;margin-right:4px;vertical-align:middle}
#prog{height:4px;background:#e3e8ef;position:absolute;left:0;right:0;top:0}
#prog div{height:100%;background:var(--hot);transition:width .3s}

/* hardware colours */
.pcb{fill:#1f7a3a;stroke:#145229;stroke-width:3}          /* green fibreglass board */
.pcbdark{fill:#0f3d1f;stroke:#0a2a15;stroke-width:2}
.chip{fill:#23272b;stroke:#4a5056;stroke-width:3}          /* black epoxy package */
.chipsilver{fill:#c9ced4;stroke:#8a9199;stroke-width:3}    /* metal heat spreader (CPU lid) */
.gold{fill:#d4a537;stroke:#9c7a22;stroke-width:1.5}        /* gold contacts */
.silver{fill:#c0c6cc;stroke:#8a9199;stroke-width:2}
.copper{fill:none;stroke:#b87333;stroke-width:6;stroke-linecap:round}   /* data trace */
.pwrwire{fill:none;stroke:#e0a400;stroke-width:7;stroke-linecap:round}  /* power rail */
.netwire{fill:none;stroke:#c2187a;stroke-width:5;stroke-dasharray:14 10}
.panel{fill:#ffffff;stroke:#b9c2d0;stroke-width:3}
.cell{fill:#f7f9fc;stroke:#8a9199;stroke-width:1.5}
.cloud{fill:#e8f1fb;stroke:#6b93c2;stroke-width:3}
.svc{fill:#fff7e6;stroke:#d79b2d;stroke-width:2}
.title{fill:#1b2430;font-size:30px;font-weight:600}
.lbl{fill:#1b2430;font-size:22px;font-weight:600}
.lblw{fill:#ffffff;font-size:22px;font-weight:600}
.sub{fill:#5b6778;font-size:17px}
.subw{fill:#d6dce6;font-size:16px}
.tiny{fill:#ffffff;font-size:15px}
.val{fill:#ffd166;font-size:18px;font-family:ui-monospace,monospace}
.mono{fill:#1b2430;font-size:16px;font-family:ui-monospace,monospace}
.note{fill:#5b6778;font-size:17px}
.hot>rect,.hot>path,.hot>circle,rect.hot,path.hot{stroke:#ff6a00!important;stroke-width:7!important}
.later{opacity:0;transition:opacity .5s}
.later.on{opacity:1}
.blk{stroke:#6b7280;stroke-width:1.5}
.free{fill:#eef2f7}
.gpt{fill:#b45309}.esp{fill:#2563eb}.boot{fill:#60a5fa}.fs{fill:#15803d}.kern{fill:#6d28d9}.user{fill:#f59e0b}.dirty{fill:#dc2626}.sb{fill:#0e7490}.bmap{fill:#4d7c0f}.inode{fill:#7c3aed}
.bar{fill:#cfd8e6;stroke:#8a9199;stroke-width:2}
.barhot{fill:#ff6a00}
.electron{fill:#0a7cc2}
.oxide{fill:#cbd5e1}.gate{fill:#64748b}.fg{fill:#d4a537}.si{fill:#94a3b8}.nplus{fill:#0e7490}
.tree{fill:#ffffff;stroke:#0a7cc2;stroke-width:2.5}
.treekey{fill:#1b2430;font-size:17px;font-family:ui-monospace,monospace}
.edge{fill:none;stroke:#6b7280;stroke-width:3}
</style>
</head>
<body>
<header>
  <h1>From power-on to a database row — step through</h1>
  <button id=\"prev\">◀ Prev</button>
  <select id=\"jump\"></select>
  <button id=\"next\">Next ▶</button>
  <button id=\"auto\">▶ Autoplay</button>
</header>
<main>
  <div id=\"stage\">
    <div id=\"prog\"><div></div></div>
    <svg id=\"svg\" viewBox=\"0 0 2000 2600\" preserveAspectRatio=\"xMidYMid meet\">
      <defs>
        <marker id=\"arr\" viewBox=\"0 0 10 10\" refX=\"8\" refY=\"5\" markerWidth=\"7\" markerHeight=\"7\" orient=\"auto\"><path d=\"M0,0 L10,5 L0,10 z\" fill=\"#5b6778\"/></marker>
      </defs>
      <g id=\"wires\"></g>
      <g id=\"world\"></g>
      <g id=\"flows\"></g>
    </svg>
  </div>
  <aside>
    <h2 id=\"t\"></h2>
    <div class=\"meta\"><span class=\"tag\">Scale: <b id=\"scale\"></b></span><span class=\"tag\">Time: <b id=\"time\"></b></span></div>
    <div id=\"body\"></div>
    <div class=\"key\">
      <span><i style=\"background:#e0a400\"></i>power</span>
      <span><i style=\"background:#0a7cc2\"></i>data / instructions</span>
      <span><i style=\"background:#d9480f\"></i>disk block read / write</span>
      <span><i style=\"background:#c2187a\"></i>network packet</span>
      <span style=\"color:#ff6a00\">▭ orange outline = active now</span>
    </div>
  </aside>
</main>
<script>
const NS='http://www.w3.org/2000/svg';
const svg=document.getElementById('svg'),world=document.getElementById('world'),flows=document.getElementById('flows'),wires=document.getElementById('wires');
function el(tag,attrs={},parent){const e=document.createElementNS(NS,tag);for(const k in attrs)e.setAttribute(k,attrs[k]);if(parent)parent.appendChild(e);return e;}
function rect(p,x,y,w,h,cls,id,extra={}){const a={x,y,width:w,height:h,class:cls,rx:5};if(id)a.id=id;return el('rect',Object.assign(a,extra),p)}
function txt(p,x,y,s,cls,anchor='start',extra={}){const t=el('text',Object.assign({x,y,class:cls,'text-anchor':anchor},extra),p);t.textContent=s;return t}
function para(p,x,y,lines,cls,lh=24){lines.forEach((l,i)=>txt(p,x,y+i*lh,l,cls))}
function g(id,p=world,cls){const a={id};if(cls)a.class=cls;return el('g',a,p)}
// A chip: black package, silver label text, optional sub text. Geometry stored for routing.
const GEO={};
function box(p,x,y,w,h,label,id,sub,cls='chip',lc='lblw',sc='subw'){const G=g(id,p);rect(G,x,y,w,h,cls);if(label)txt(G,x+w/2,y+h/2+(sub?-2:8),label,lc,'middle');if(sub)txt(G,x+w/2,y+h/2+22,sub,sc,'middle');GEO[id]={x,y,w,h};return G}
function geo(id){return GEO[id]}
// Orthogonal route from edge of a to edge of b: never crosses the boxes themselves.
function route(a,b){const A=geo(a),B=geo(b);const ac={x:A.x+A.w/2,y:A.y+A.h/2},bc={x:B.x+B.w/2,y:B.y+B.h/2};const dx=bc.x-ac.x,dy=bc.y-ac.y;let pts;
  if(Math.abs(dx)>=Math.abs(dy)){const sx=dx>0?A.x+A.w:A.x,ex=dx>0?B.x:B.x+B.w;const mx=(sx+ex)/2;pts=[[sx,ac.y],[mx,ac.y],[mx,bc.y],[ex,bc.y]]}
  else{const sy=dy>0?A.y+A.h:A.y,ey=dy>0?B.y:B.y+B.h;const my=(sy+ey)/2;pts=[[ac.x,sy],[ac.x,my],[bc.x,my],[bc.x,ey]]}
  return 'M'+pts.map(q=>q.join(',')).join(' L')}
function wire(a,b,cls){el('path',{d:route(a,b),class:cls},wires)}

/* ---------------- Laptop motherboard ---------------- */
(function(){
  const L=g('laptop');
  rect(L,40,40,1160,1420,'pcb','lap-board');GEO['lap-board']={x:40,y:40,w:1160,h:1420};
  txt(L,70,95,'Laptop motherboard — green fibreglass, copper traces, black chips','title',undefined,{fill:'#fff'});
  box(L,80,150,130,60,'Power','pwrbtn','button','silver','lbl','sub');
  box(L,80,260,130,80,'Battery','battery','7.7 V Li-ion');
  box(L,80,400,240,130,'PMIC + VRM','pmic','voltage regulators');
  box(L,80,640,180,90,'SPI flash','spiflash','UEFI, 32 MB');
  box(L,360,640,220,110,'Chipset (PCH)','pch','SPI · USB · PCIe lanes');
  // CPU: silver lid with dies drawn inside
  const C=g('cpu',L);rect(C,620,330,440,380,'chipsilver');GEO.cpu={x:620,y:330,w:440,h:380};
  txt(C,840,365,'CPU (system-on-chip)','lbl','middle');
  for(let i=0;i<4;i++){rect(C,650+i*95,390,80,80,'chip','core'+i);txt(C,690+i*95,436,'core '+i,'tiny','middle')}
  rect(C,650,495,380,50,'chip','pcreg');txt(C,662,528,'PC (RIP):','subw');txt(C,760,528,'—','val','start',{id:'pcval'});
  rect(C,650,565,180,70,'chip','cache');txt(C,740,595,'L1 / L2 / L3','tiny','middle');txt(C,740,617,'cache (SRAM)','tiny','middle');
  rect(C,850,565,180,70,'chip','memctl');txt(C,940,595,'memory','tiny','middle');txt(C,940,617,'controller','tiny','middle');
  txt(C,840,690,'4 cores · 3 GHz · ~30 W','sub','middle');
  // RAM: two SO-DIMMs, green PCB, black DRAM chips, gold edge connector
  const R=g('ram',L);GEO.ram={x:640,y:780,w:400,h:170};
  [0,1].forEach(k=>{const y=780+k*90;rect(R,640,y,400,70,'pcbdark');for(let i=0;i<8;i++)rect(R,650+i*48,y+8,40,34,'chip');for(let i=0;i<30;i++)rect(R,648+i*13,y+54,9,14,'gold');});
  txt(R,840,975,'RAM: 2 × 8 GB DDR5 SO-DIMM (DRAM, volatile)','lblw','middle');
  // SSD: black M.2 stick
  const S=g('ssd',L);GEO.ssd={x:80,y:900,w:420,h:130};rect(S,80,900,420,130,'chip');
  rect(S,100,920,90,90,'chipsilver');txt(S,145,960,'ctrl','lbl','middle');txt(S,145,982,'+ FTL','sub','middle');
  for(let i=0;i<3;i++){rect(S,210+i*90,920,80,90,'pcbdark');txt(S,250+i*90,970,'NAND','tiny','middle')}
  for(let i=0;i<14;i++)rect(S,84+i*8,1012,6,14,'gold');
  txt(S,290,1060,'SSD: 1 TB NVMe M.2 (flash, persistent)','lblw','middle');
  // Wi-Fi module + antenna
  const W=g('wifi',L);GEO.wifi={x:80,y:1150,w:200,h:90};rect(W,80,1150,200,90,'chip');txt(W,180,1190,'Wi-Fi','lblw','middle');txt(W,180,1215,'M.2 radio','subw','middle');
  el('path',{d:'M280,1170 L330,1170 L330,1110',class:'copper'},W);el('circle',{cx:330,cy:1110,r:9,fill:'#c0c6cc'},W);
  txt(W,60,1300,'Screen, keyboard, trackpad and USB hang off the PCH too; left out to keep the data path visible.','subw');
  // Wires (power rails gold, data traces copper)
  wire('battery','pmic','pwrwire');wire('pwrbtn','pmic','pwrwire');wire('pmic','cpu','pwrwire');wire('pmic','ssd','pwrwire');
  wire('spiflash','pch','copper');wire('pch','cpu','copper');wire('cpu','ram','copper');wire('pch','ssd','copper');wire('pch','wifi','copper');
  // reset line label
  txt(L,350,470,'RESET#','subw');
})();

/* ---------------- Inset: SSD block map ---------------- */
(function(){
  const P=g('ssdmap',world,'later');GEO.ssdmap={x:40,y:1520,w:560,h:440};
  rect(P,40,1520,560,440,'panel');txt(P,60,1560,'SSD as the OS sees it: 4 KB blocks (LBAs)','lbl');
  txt(P,60,1590,'Zoom of the 1 TB stick. Each square = one block.','sub');
  const cols=24,rows=10,sz=20,x0=60,y0=1610;
  for(let r=0;r<rows;r++)for(let c=0;c<cols;c++){const i=r*cols+c;rect(P,x0+c*sz,y0+r*sz,sz-2,sz-2,'blk free','lba'+i,{rx:2})}
  const legend=g('ssdlegend',P);let ly=1830;
  [['gpt','GPT partition table (LBA 1)'],['esp','EFI system partition'],['boot','bootloader file (PE binary)'],['fs','ext4 / APFS data partition'],['sb','superblock + bitmaps'],['inode','inode table'],['user','your document blocks']].forEach((k,i)=>{const x=60+(i%3)*180,y=ly+Math.floor(i/3)*32;rect(legend,x,y,18,18,'blk '+k[0],null,{rx:2});txt(legend,x+26,y+15,k[1],'note')});
})();

/* ---------------- Inset: RAM address map ---------------- */
(function(){
  const P=g('rammap',world,'later');GEO.rammap={x:640,y:1520,w:560,h:440};
  rect(P,640,1520,560,440,'panel');txt(P,660,1560,'RAM as the CPU sees it: one address line, 0 → 16 GB','lbl');
  txt(P,660,1590,'Volatile. Empty at power-on. Filled by DMA from the SSD.','sub');
  const segs=[['r-fw','firmware tables',0x15803d],['r-boot','bootloader',0x60a5fa],['r-kern','kernel',0x6d28d9],['r-pt','page tables',0x0e7490],['r-pc','page cache',0xf59e0b],['r-app','your app + libc',0xdc7633],['r-free','free',0xeef2f7]];
  let x=660;const ws=[50,60,110,60,100,70,70];
  segs.forEach((s,i)=>{rect(P,x,1620,ws[i],70,'blk later',s[0],{fill:'#'+s[2].toString(16).padStart(6,'0')});txt(P,x+ws[i]/2,1715,s[1],'note','middle',{'font-size':14});x+=ws[i]});
  txt(P,660,1760,'0x0000_0000','mono');txt(P,1180,1760,'0x4_0000_0000','mono','end');
  para(P,660,1810,['Each box is thousands of 4 KB pages.','The page cache holds copies of disk blocks;','a red page is \"dirty\": changed in RAM, not yet on the SSD.'],'note');
  rect(P,1040,1620,30,70,'blk later dirty','r-dirty',{});
})();

/* ---------------- Inset: Flash cell ---------------- */
(function(){
  const P=g('flashcell',world,'later');GEO.flashcell={x:1240,y:1520,w:560,h:440};
  rect(P,1240,1520,560,440,'panel');txt(P,1260,1560,'One NAND flash cell (~15 nm)','lbl');
  txt(P,1260,1590,'A transistor with an extra, insulated \"floating\" gate.','sub');
  const cx=1300;rect(P,cx,1800,440,70,'si');txt(P,cx+220,1890,'p-type silicon substrate','note','middle');
  rect(P,cx,1800,100,40,'nplus');txt(P,cx+50,1826,'source n+','tiny','middle');
  rect(P,cx+340,1800,100,40,'nplus');txt(P,cx+390,1826,'drain n+','tiny','middle');
  rect(P,cx+110,1780,220,20,'oxide');txt(P,cx+345,1796,'tunnel oxide','note');
  rect(P,cx+110,1735,220,45,'fg','fgate');txt(P,cx+220,1764,'floating gate (trapped charge)','tiny','middle',{fill:'#1b2430'});
  rect(P,cx+110,1715,220,20,'oxide');
  rect(P,cx+110,1670,220,45,'gate');txt(P,cx+220,1699,'control gate (word line)','tiny','middle');
  const E=g('electrons',P);for(let i=0;i<6;i++)el('circle',{cx:cx+140+i*35,cy:1757,r:6,class:'electron later','id':'e'+i},E);
  para(P,1260,1630,['Write: ~20 V on the control gate pulls electrons through','the oxide onto the floating gate. Read: ~1 V, see whether','the transistor conducts; trapped charge shifts the threshold.'],'note',22);
})();

/* ---------------- Inset: B-tree ---------------- */
(function(){
  const P=g('btree',world,'later');GEO.btree={x:40,y:2000,w:1160,h:560};
  rect(P,40,2000,1160,560,'panel');txt(P,60,2040,'Postgres B-tree index on users(id): 8 KB pages, 3 levels, ~10⁸ rows','lbl');
  const node=(id,x,y,keys,cls)=>{const G=g(id,P);rect(G,x,y,260,56,'tree');keys.forEach((k,i)=>txt(G,x+22+i*62,y+36,k,'treekey'));GEO[id]={x,y,w:260,h:56};return G};
  node('root',490,2090,['…','4 M','8 M','12 M'],'');txt(P,760,2124,'root (RAM)','note');
  node('int1',160,2210,['…','5 M','6 M','7 M'],'');node('int2',490,2210,['8.1 M','8.4 M','8.7 M','…'],'');node('int3',820,2210,['…','…','…','…'],'');txt(P,1090,2244,'internal (RAM)','note');
  node('leaf1',160,2330,['…','…','…','…'],'');node('leaf2',490,2330,['8.4 M','8.4 M+1','8.4 M+2','…'],'');node('leaf3',820,2330,['…','…','…','…'],'');txt(P,1090,2364,'leaf (one EBS read)','note');
  [['root','int1'],['root','int2'],['root','int3'],['int2','leaf1'],['int2','leaf2'],['int2','leaf3']].forEach(e=>{const A=geo(e[0]),B=geo(e[1]);el('path',{d:`M${A.x+A.w/2},${A.y+A.h} L${B.x+B.w/2},${B.y}`,class:'edge'},P)});
  const H=g('heap',P);rect(H,490,2460,260,56,'tree',null,{stroke:'#d9480f'});GEO.heap={x:490,y:2460,w:260,h:56};txt(H,620,2496,'heap page: id 8 400 001 → age 31','treekey','middle');
  el('path',{d:'M620,2386 L620,2460',class:'edge','marker-end':'url(#arr)'},P);
  para(P,60,2460,['Looking up id = 8 400 001:','root says 8 M ≤ id < 12 M → middle child;','that says 8.4 M ≤ id < 8.7 M → middle leaf;','leaf holds the row\\'s address (heap page, offset).'],'note',24);
})();

/* ---------------- Internet + AWS ---------------- */
(function(){
  const N=g('net');GEO.net={x:1260,y:40,w:700,h:280};
  el('path',{d:'M1300,250 C1230,170 1330,70 1430,110 C1480,40 1640,40 1690,110 C1800,60 1940,150 1880,230 C1930,300 1750,330 1660,290 C1540,340 1360,330 1300,250 Z',class:'cloud'},N);
  txt(N,1610,150,'Internet','lbl','middle');txt(N,1610,180,'Wi-Fi → home router → ISP fibre → undersea / cross-country fibre → AWS edge','sub','middle');
  box(N,1560,210,100,50,'router','router',null,'cell','lbl');box(N,1760,210,100,50,'ISP','isp',null,'cell','lbl');
  const A=g('aws');GEO.aws={x:1260,y:380,w:700,h:320};rect(A,1260,380,700,320,'panel');txt(A,1280,420,'AWS region (eu-west-2): Supabase project','lbl');
  box(A,1290,460,160,60,'Load balancer','lb',null,'svc','lbl');box(A,1480,460,160,60,'PostgREST','pgrest','HTTP → SQL','svc','lbl','sub');box(A,1670,460,160,60,'Pooler','pooler','connection reuse','svc','lbl','sub');
  box(A,1480,580,160,70,'Postgres','pg','on an EC2 server','svc','lbl','sub');box(A,1700,580,200,70,'EBS volume','ebs','network SSD, other servers','svc','lbl','sub');
  txt(A,1280,690,'Each box is a process on a server; arrows below are network hops inside the data centre.','note');
  wire('lb','pgrest','netwire');wire('pgrest','pooler','netwire');wire('pooler','pg','netwire');wire('pg','ebs','netwire');
})();

/* ---------------- Server board ---------------- */
(function(){
  const S=g('server');GEO.server={x:1260,y:760,w:700,h:700};rect(S,1260,760,700,700,'pcb');
  txt(S,1290,810,'Database server (2U rack unit, no screen)','title',undefined,{fill:'#fff'});
  // two CPU sockets
  box(S,1300,860,200,160,'CPU 0','scpu0','64 cores, 350 W','chipsilver','lbl','sub');box(S,1540,860,200,160,'CPU 1','scpu1','64 cores, 350 W','chipsilver','lbl','sub');
  // DIMMs: 8 per socket, green with gold edge
  const D=g('sram',S);GEO.sram={x:1300,y:1050,w:440,h:200};
  for(let i=0;i<16;i++){const x=1300+i*27.5,y=1050;rect(D,x,y,22,170,'pcbdark');for(let k=0;k<4;k++)rect(D,x+5,y+10+k*36,12,26,'chip');rect(D,x+3,y+180,16,10,'gold')}
  txt(D,1520,1275,'16 × 64 GB DDR5 ECC = 1 TB RAM','lblw','middle');
  box(S,1770,860,160,100,'NIC','nic','100 GbE, DMA');box(S,1770,1000,160,90,'BMC','bmc','remote console');
  box(S,1770,1130,160,120,'NVMe / EBS','sdisk','PCIe link');
  box(S,1300,1310,620,110,'Laptop → server: 4 → 128 cores · 16 GB → 1 TB · Wi-Fi 1 Gb → 100 GbE · no battery, two PSUs · same ISA, same OS kernel, same B-tree','srvnote',null,'cell','sub');
  wire('nic','scpu1','copper');wire('scpu0','sram','copper');wire('scpu1','sram','copper');wire('scpu1','sdisk','copper');wire('scpu0','scpu1','copper');
})();

/* ---------------- Ladder of time ---------------- */
(function(){
  const P=g('ladder',world,'later');GEO.ladder={x:1260,y:1520,w:700,h:1040};
  rect(P,1260,1520,700,1040,'panel');txt(P,1280,1560,'Ladder of time (log scale): one bar step = 10×','lbl');
  const rows=[['CPU clock tick',0.33e-9],['L1 cache hit',1e-9],['RAM access',100e-9],['SSD page read',50e-6],['EBS read (network SSD)',500e-6],['HDD seek + read',8e-3],['London ↔ Dublin fibre',12e-3],['Laptop ↔ AWS round trip',80e-3],['Eye blink',300e-3]];
  rows.forEach((r,i)=>{const y=1600+i*100;const w=Math.max(10,(Math.log10(r[1])+10)*60);txt(P,1280,y+22,r[0],'note');rect(P,1280,y+34,w,30,'bar','bar'+i);txt(P,1290+w,y+56,fmt(r[1]),'mono')});
  function fmt(s){return s<1e-6?(s*1e9).toFixed(2)+' ns':s<1e-3?(s*1e6).toFixed(0)+' µs':(s*1e3).toFixed(0)+' ms'}
  para(P,1280,2520,['A 4-level B-tree with 2 levels cached = 2 disk reads: ~0.1 ms SSD, ~1 ms EBS, ~16 ms HDD.'],'note');
})();

/* ---------------- Flow animation: dots ride the real routed wires ---------------- */
function dots(a,b,color,n=4,dur=1.6,rev=false){let d=route(a,b);const p=el('path',{d,fill:'none',stroke:color,'stroke-width':3,opacity:.35},flows);
  for(let i=0;i<n;i++){const c=el('circle',{r:11,fill:color,stroke:'#fff','stroke-keyed':1,'stroke-width':2},flows);const m=el('animateMotion',{dur:dur+'s',repeatCount:'indefinite',begin:(i*dur/n)+'s',keyPoints:rev?'1;0':'0;1',keyTimes:'0;1',calcMode:'linear'},c);el('mpath',{href:'#'+(p.id||(p.id='fp'+Math.random().toString(36).slice(2)))},m)}}
function ring(id,color){const G=geo(id);const r=el('rect',{x:G.x-6,y:G.y-6,width:G.w+12,height:G.h+12,rx:8,fill:'none',stroke:color,'stroke-width':6},flows);el('animate',{attributeName:'opacity',values:'1;.2;1',dur:'1.2s',repeatCount:'indefinite'},r)}

/* ---------------- Steps ---------------- */
const PWR='#e0a400',DAT='#0a7cc2',RD='#d9480f',NET='#c2187a';
const steps=[
{t:'1 · Press the power button',scale:'centimetres',time:'~50 ms',view:[40,40,1160,1000],hot:['pwrbtn','battery','pmic'],pc:'—',
 flow:()=>{dots('battery','pmic',PWR);dots('pwrbtn','pmic',PWR,2);dots('pmic','cpu',PWR);dots('pmic','ssd',PWR,3)},
 h:`<p>The button is a switch on a sense wire to the <b>PMIC</b>. The PMIC turns on its regulators in a fixed order (memory rail, chipset rail, CPU core rail), each one waiting for the previous to settle.</p><p>While the rails are rising, the CPU's <code>RESET#</code> pin is held low: every flip-flop in the chip is forced to its reset value. Nothing executes yet.</p><ul><li>Battery: 7.7 V</li><li>CPU core rail: ~1.0 V at up to 30 A</li><li>RAM rail: 1.1 V</li></ul>`},
{t:'2 · Reset vector: the first instruction',scale:'one chip',time:'first ~1 µs',view:[560,300,560,440],hot:['cpu','core0','pcreg'],pc:'0xFFFF_FFF0',
 flow:()=>{dots('spiflash','pch',DAT);dots('pch','cpu',DAT);ring('spiflash',DAT)},
 h:`<p>When the rails are stable the PMIC releases <code>RESET#</code>. Core 0 wakes with its program counter hard-wired to <code>0xFFFFFFF0</code>, 16 bytes below 4 GB. There is no RAM configured yet, so the chipset maps that address range onto the <b>SPI flash</b> chip.</p><p>The fetch goes core → chipset → SPI bus → flash, byte by byte at ~50 MB/s. The first instruction is a jump into the firmware proper.</p><p>This is the only thing the hardware \"knows\": where to fetch from. Everything else is software from here.</p>`},
{t:'3 · Firmware (UEFI) brings up the board',scale:'board',time:'0.5–2 s',view:[40,40,1160,1000],hot:['cpu','ram','pch'],pc:'0xFFF8_1A20',
 flow:()=>{dots('cpu','ram',DAT);dots('pch','ssd',DAT,3);dots('pch','wifi',DAT,2)},
 h:`<p>Running from flash and a few KB of cache-as-RAM, the firmware:</p><ol><li><b>Trains the memory controller</b>: sends test patterns to each DIMM and tunes the timing until reads come back clean. Only now does RAM exist as usable addresses.</li><li><b>Enumerates PCIe</b>: asks each lane \"who is there?\" and gets the SSD and the Wi-Fi module back, assigning each an address window.</li><li>Builds tables (ACPI, memory map) describing the board, and leaves them in RAM for the OS.</li></ol><p>Then it looks for something to boot.</p>`},
{t:'4 · The SSD as a map of blocks',scale:'1 TB → 4 KB blocks',time:'~1 ms',view:[40,1520,560,440],show:['ssdmap'],hot:['ssdmap'],
 paint:()=>{paintLBA(1,1,'gpt');paintLBA(2,30,'esp');paintLBA(8,4,'boot');paintLBA(40,200,'fs')},
 flow:()=>{},
 h:`<p>The firmware reads <b>LBA 1</b>, the GPT partition table: a list of (start block, end block, type) entries. It finds the EFI system partition, which is a small FAT file system, and inside it a file such as <code>EFI/BOOT/BOOTX64.EFI</code>: the <b>bootloader</b>.</p><p>Nothing on the disk is special to the hardware. It is only blocks; the GPT at block 1 is a convention that firmware and OS agree on.</p>`},
{t:'5 · Bootloader into RAM by DMA',scale:'board → RAM map',time:'~20 ms',view:[40,760,1160,1200],show:['rammap','r-fw','r-boot'],hot:['ssd','ram'],
 flow:()=>{dots('ssd','pch',RD);dots('pch','cpu',RD);dots('cpu','ram',RD)},
 h:`<p>The firmware queues a read command to the SSD: \"blocks 8–11, put them at RAM address X\". The SSD controller fetches the data from NAND and writes it <b>straight into RAM</b> (DMA, direct memory access) without the CPU copying bytes, then raises an interrupt.</p><p>The CPU jumps to X. Now it is running code that came from the disk.</p>`},
{t:'6 · Kernel loaded',scale:'RAM map',time:'~0.3 s',view:[640,1520,560,440],show:['rammap','r-kern'],hot:['r-kern'],
 flow:()=>{dots('ssd','ram',RD,6,2)},
 h:`<p>The bootloader understands the real file system (ext4, APFS). It walks its directory tree to <code>/boot/vmlinuz</code>, reads a few MB of blocks into RAM, then jumps into the kernel's entry point with a pointer to the firmware tables.</p><p>From this moment the firmware and bootloader are finished. The kernel owns the machine.</p>`},
{t:'7 · Kernel init',scale:'chip + RAM',time:'~1 s',view:[560,300,560,700],show:['r-pt'],hot:['cpu','memctl'],pc:'0xFFFF_FFFF_8100_0000',
 flow:()=>{dots('cpu','ram',DAT,6,1.2)},
 h:`<p>The kernel builds the structures every later step depends on:</p><ol><li><b>Page tables</b>, and switches the CPU to virtual addressing. From now on every program sees its own private address space.</li><li><b>Interrupt handlers</b>, so the keyboard, NIC and SSD can get its attention.</li><li>Drivers for the SSD and Wi-Fi, found through the PCIe windows the firmware set up.</li><li>Mounts the root file system: reads the superblock to learn where the inode table and bitmaps live.</li><li>Starts the first user process (<code>init</code>), which starts everything else.</li></ol>`},
{t:'8 · Rewind: formatting a blank drive',scale:'blocks',time:'seconds, once',view:[40,1520,560,440],show:['ssdmap'],hot:['ssdmap'],
 paint:()=>{paintLBA(40,2,'sb');paintLBA(42,6,'bmap');paintLBA(48,20,'inode')},
 flow:()=>{},
 h:`<p>Step 6 assumed a file system was there. How did it get there? The installer ran <code>mkfs</code> once:</p><ul><li><b>Superblock</b>: block size, total blocks, where the other tables are.</li><li><b>Bitmaps</b>: one bit per block and per inode, 0 = free.</li><li><b>Inode table</b>: fixed slots, each describing one file: size, owner, and the list of blocks holding it.</li><li><b>Root directory</b>: an inode whose data is a (name → inode number) table; on many file systems that table is a B-tree.</li></ul><p>A \"formatted\" drive is still just blocks; it now has blocks that describe the other blocks.</p>`},
{t:'9 · Saving a file: the write() syscall',scale:'RAM map',time:'~5 µs',view:[640,1520,560,440],show:['rammap','r-pc','r-app','r-dirty'],hot:['r-dirty'],
 flow:()=>{dots('cpu','ram',DAT,3)},
 h:`<p>Your editor calls <code>write(fd, buf, 4096)</code>. The CPU traps into the kernel, which:</p><ol><li>Finds the file's inode, allocates a free block number from the bitmap.</li><li>Copies your bytes into a <b>page cache</b> page in RAM and marks it <b>dirty</b> (red).</li><li>Returns. <code>write()</code> is done, but the SSD has not been touched.</li></ol><p>Pull the power now and the file is lost. <code>fsync()</code> is how a database forces the next step before reporting success.</p>`},
{t:'10 · Writeback: RAM → SSD via NVMe',scale:'board',time:'~100 µs',view:[40,600,1100,460],hot:['ram','pch','ssd'],
 flow:()=>{dots('ram','cpu',RD,3);dots('cpu','pch',RD,3);dots('pch','ssd',RD,3)},
 h:`<p>Seconds later (or on <code>fsync</code>) the kernel flushes dirty pages:</p><ol><li>Writes a 64-byte command into a <b>submission queue</b> in RAM: \"write 4 KB from RAM address X to LBA 7 231\".</li><li>Rings the SSD's <b>doorbell</b> register over PCIe.</li><li>The SSD controller reads the command, DMAs the page out of RAM, and posts to a completion queue.</li><li>Interrupt; the kernel marks the page clean and updates the inode's block list and the bitmaps (more writes).</li></ol>`},
{t:'11 · Inside one flash cell',scale:'nanometres',time:'~1 ms per page program',view:[1240,1520,560,440],show:['flashcell','e0','e1','e2','e3','e4','e5'],hot:['fgate'],
 flow:()=>{},
 h:`<p>The SSD controller's <b>flash translation layer</b> maps LBA 7 231 to a physical page in one NAND chip. Flash cannot overwrite in place: a cell must be erased (whole 4 MB block, ~ms) before it can be programmed, so the FTL writes to a fresh page and marks the old one stale for later garbage collection.</p><p>Programming: ~20 V on the control gate makes electrons tunnel through the oxide onto the floating gate, where they stay with no power applied. Reading: a small voltage on the gate; the trapped charge shifts the threshold, so the cell conducts or not. Modern cells store 3–4 bits by distinguishing 8–16 charge levels.</p><p>Your bytes are now a pattern of trapped electrons.</p>`},
{t:'12 · A query leaves your app',scale:'board',time:'~50 µs',view:[40,300,1160,1000],hot:['cpu','pch','wifi'],
 flow:()=>{dots('cpu','pch',NET,3);dots('pch','wifi',NET,3)},
 h:`<p>Your app runs <code>supabase.from('users').select('age').eq('id', 8400001)</code>. The library builds an HTTP request, wraps it in TLS, and the kernel wraps that in TCP, IP and Ethernet headers. Each layer adds a header; the payload is still your one line of text.</p><p>The frame is DMA'd to the Wi-Fi module, which modulates it onto a 5 GHz carrier.</p>`},
{t:'13 · Across the network',scale:'kilometres',time:'~40 ms one way',view:[40,40,1920,700],hot:['wifi','net'],
 flow:()=>{dots('wifi','router',NET,3,2.5);dots('router','isp',NET,3,1.5);dots('isp','lb',NET,3,1.5)},
 h:`<p>Router → ISP → fibre backbone → AWS edge. Each hop reads the IP destination, looks it up in its own routing table (a longest-prefix-match tree, a cousin of the B-tree), and forwards. Light in fibre moves at ~200 000 km/s, so ~1 ms per 200 km; most of the latency is distance and queueing, not computation.</p>`},
{t:'14 · Inside the AWS region',scale:'data centre',time:'~1 ms',view:[1240,360,740,360],hot:['aws','lb','pgrest','pooler','pg'],
 flow:()=>{dots('lb','pgrest',NET,3);dots('pgrest','pooler',NET,3);dots('pooler','pg',NET,3)},
 h:`<p>Supabase is a set of processes on AWS servers around a Postgres database:</p><ol><li><b>Load balancer</b> terminates TLS and picks a healthy backend.</li><li><b>PostgREST</b> turns the HTTP request into SQL: <code>SELECT age FROM users WHERE id = 8400001</code>.</li><li><b>Pooler</b> hands it to an already-open Postgres connection.</li><li><b>Postgres</b> runs on an EC2 server whose \"disk\" is an <b>EBS volume</b>: an SSD in another rack, reached over the data-centre network.</li></ol>`},
{t:'15 · The database server',scale:'rack unit',time:'—',view:[1240,740,740,740],hot:['server','scpu0','scpu1','sram'],
 flow:()=>{},
 h:`<p>Same architecture as the laptop, different proportions:</p><ul><li>Two CPU sockets, 128 cores total, no battery, two redundant power supplies.</li><li>16 DIMMs = 1 TB of <b>ECC</b> RAM (extra chip per DIMM detects and corrects bit flips). Most of the hot B-tree pages live here permanently.</li><li>100 GbE NIC instead of Wi-Fi; a <b>BMC</b> chip instead of a screen, so an operator can see the console over the network.</li><li>Same x86 ISA, same Linux kernel, same boot sequence from steps 1–7.</li></ul><p>The client/server difference is the role, not the kind of machine.</p>`},
{t:'16 · Packet in: NIC → RAM → Postgres wakes',scale:'server board',time:'~20 µs',view:[1240,740,740,740],hot:['nic','scpu1','sram'],
 flow:()=>{dots('nic','scpu1',NET,3);dots('scpu1','sram',DAT,3)},
 h:`<p>The NIC DMAs the frame into a ring buffer in RAM and raises an interrupt. The kernel's TCP stack strips the headers and copies the payload into the socket buffer of the Postgres backend process, which was blocked in <code>recv()</code>. The scheduler marks it runnable and a core picks it up.</p><p>Postgres parses the SQL, sees <code>WHERE id = …</code> on a column with an index, and chooses an index scan.</p>`},
{t:'17 · B-tree lookup',scale:'8 KB pages',time:'~0.5 ms (one EBS read)',view:[40,2000,1160,560],show:['btree'],hot:['root','int2','leaf2','heap'],
 flow:()=>{dots('root','int2',DAT,2,1);dots('int2','leaf2',DAT,2,1);dots('sdisk','leaf2',RD,3,2);dots('leaf2','heap',RD,2,1)},
 h:`<p>Each node is one 8 KB page holding ~300 sorted keys, so three levels index ~27 million rows and four index ~8 billion. The cost that matters is <b>pages fetched from disk</b>, not comparisons.</p><ol><li><b>Root</b>: in shared buffers (RAM). Binary search within the page: 8 M ≤ id &lt; 12 M → middle child.</li><li><b>Internal</b>: also cached (every query touches these). → middle leaf.</li><li><b>Leaf</b>: not cached. One read to the EBS volume: ~0.5 ms, the only slow step. The leaf entry holds (heap page, slot).</li><li><b>Heap page</b>: fetch the row, pull out <code>age = 31</code>.</li></ol><p>Without the index: scan 10⁸ rows ≈ 10⁵ pages ≈ seconds.</p>`},
{t:'18 · The answer returns',scale:'everything',time:'~80 ms round trip',view:[40,40,1920,1420],hot:['pg','cpu'],
 flow:()=>{dots('pg','lb',NET,3);dots('lb','isp',NET,3);dots('isp','router',NET,3);dots('router','wifi',NET,3,2.5);dots('wifi','pch',NET,3);dots('pch','cpu',NET,3)},
 h:`<p>Postgres writes <code>{\"age\":31}</code> to its socket; the layers wrap it, the hops forward it, your Wi-Fi module DMAs it into RAM, the kernel wakes your app.</p><p><b>Where the 80 ms went:</b></p><ul><li>Fibre, both ways: ~75 ms</li><li>Load balancer, PostgREST, pooler: ~2 ms</li><li>The EBS disk read: ~0.5 ms</li><li>The B-tree comparisons themselves: &lt; 1 µs</li></ul><p>The index made the one disk read possible; distance made everything else.</p>`},
{t:'19 · Ladder of time',scale:'log scale',time:'—',view:[1240,1500,740,1080],show:['ladder'],hot:['bar3','bar4','bar5'],
 flow:()=>{},
 h:`<p>Every design choice in this chain follows from this ladder. RAM is 10⁵× slower than a clock tick, so caches exist. An SSD is 10³× slower than RAM, so B-trees make nodes a whole page and keep the tree shallow. The network is 10³× slower than the SSD, so the database lives next to the data and only the answer travels.</p><p><b>Check yourself:</b> a 4-level B-tree with the top 2 levels cached. How many disk reads per lookup? Roughly how long on a local SSD, on EBS, on an HDD?</p>`}
];

function paintLBA(start,n,cls){for(let i=start;i<start+n;i++){const r=document.getElementById('lba'+i);if(r){r.setAttribute('class','blk '+cls)}}}

/* ---------------- Camera + runner ---------------- */
let cur=0,timer=null,shown=new Set();
function setView(v){svg.setAttribute('viewBox',v.join(' '))}
svg.style.transition='none';
function animView(to){const from=svg.getAttribute('viewBox').split(' ').map(Number);const t0=performance.now(),D=900;function f(now){const k=Math.min(1,(now-t0)/D),e=k<.5?2*k*k:-1+(4-2*k)*k;setView(from.map((a,i)=>a+(to[i]-a)*e));if(k<1)requestAnimationFrame(f)}requestAnimationFrame(f)}
function show(i){cur=Math.max(0,Math.min(steps.length-1,i));const s=steps[cur];
  flows.innerHTML='';document.querySelectorAll('.hot').forEach(e=>e.classList.remove('hot'));
  // insets: show everything revealed so far
  for(let j=0;j<=cur;j++)(steps[j].show||[]).forEach(id=>{shown.add(id)});
  document.querySelectorAll('.later').forEach(e=>e.classList.toggle('on',shown.has(e.id)));
  for(let j=0;j<=cur;j++)if(steps[j].paint)steps[j].paint();
  (s.hot||[]).forEach(id=>{const e=document.getElementById(id);if(e)e.classList.add('hot')});
  document.getElementById('pcval').textContent=s.pc||document.getElementById('pcval').textContent;
  animView(s.view);s.flow();
  document.getElementById('t').textContent=s.t;document.getElementById('scale').textContent=s.scale;document.getElementById('time').textContent=s.time;document.getElementById('body').innerHTML=s.h;
  document.getElementById('jump').value=cur;document.querySelector('#prog div').style.width=((cur+1)/steps.length*100)+'%';
  document.getElementById('prev').disabled=cur===0;document.getElementById('next').disabled=cur===steps.length-1}
const J=document.getElementById('jump');steps.forEach((s,i)=>{const o=document.createElement('option');o.value=i;o.textContent=s.t;J.appendChild(o)});
J.onchange=()=>show(+J.value);document.getElementById('prev').onclick=()=>show(cur-1);document.getElementById('next').onclick=()=>show(cur+1);
document.getElementById('auto').onclick=function(){if(timer){clearInterval(timer);timer=null;this.textContent='▶ Autoplay'}else{this.textContent='⏸ Pause';timer=setInterval(()=>{if(cur<steps.length-1)show(cur+1);else{clearInterval(timer);timer=null;document.getElementById('auto').textContent='▶ Autoplay'}},9000)}};
document.addEventListener('keydown',e=>{if(e.key==='ArrowRight')show(cur+1);if(e.key==='ArrowLeft')show(cur-1)});
setView([40,40,1160,1000]);show(0);
</script>
</body>
</html>"
 :AT "2026-11-19T16:06:47" :VERSION 2)
(:PINNED T :ID "bst-vs-b-tree-side-by-side-search" :MAP "computers" :NODE "btree-indexes" :TYPE
 "html" :TITLE "BST vs B-tree: side-by-side search" :LANGUAGE NIL :CONTENT "<!DOCTYPE html>
<html><head><meta charset=\"utf-8\"><style>
body{margin:0;font:14px system-ui,sans-serif;background:#f3f5f8;color:#1b2430;padding:10px}
.bar{display:flex;gap:10px;align-items:center;flex-wrap:wrap;margin-bottom:8px}
button,select{padding:6px 12px;border:1px solid #b9c2d0;border-radius:6px;background:#fff;cursor:pointer;font-size:14px}
.row{display:grid;grid-template-columns:1fr 1fr;gap:10px}
@media(max-width:700px){.row{grid-template-columns:1fr}}
.card{background:#fff;border:1px solid #d6dce6;border-radius:8px;padding:8px}
h3{margin:0 0 4px;font-size:15px}
svg{width:100%;height:auto;display:block}
.stat{font-size:13px;color:#5b6778;min-height:36px}
.stat b{color:#d9480f}
.n{fill:#fff;stroke:#0a7cc2;stroke-width:2}
.n.vis{fill:#ffe3cc;stroke:#ff6a00;stroke-width:3}
.n.found{fill:#c8f2d0;stroke:#15803d;stroke-width:3}
.e{stroke:#8a9199;stroke-width:1.5;fill:none}
text{font-family:ui-monospace,monospace;font-size:11px;text-anchor:middle;dominant-baseline:middle;fill:#1b2430}
.k.hit{fill:#d9480f;font-weight:700}
</style></head><body>
<div class=\"bar\">
<b>Search for key:</b><select id=\"key\"></select>
<button id=\"go\">▶ Search both</button>
<button id=\"reset\">Reset</button>
<span style=\"color:#5b6778\">Each highlighted node = one disk block read.</span>
</div>
<div class=\"row\">
<div class=\"card\"><h3>Binary search tree (1 key per node)</h3><svg id=\"a\" viewBox=\"0 0 520 300\"></svg><div class=\"stat\" id=\"sa\"></div></div>
<div class=\"card\"><h3>B-tree (4 keys per node, 3 levels)</h3><svg id=\"b\" viewBox=\"0 0 520 300\"></svg><div class=\"stat\" id=\"sb\"></div></div>
</div>
<script>
const NS='http://www.w3.org/2000/svg';
function el(t,a,p){const e=document.createElementNS(NS,t);for(const k in a)e.setAttribute(k,a[k]);p&&p.appendChild(e);return e}
const keys=[];for(let i=1;i<=31;i++)keys.push(i*3);   // 3..93
// ---- BST: balanced-ish from sorted keys (31 keys => depth 5), inserted in a plain way
function build(lo,hi){if(lo>hi)return null;const m=(lo+hi)>>1;return{k:keys[m],l:build(lo,m-1),r:build(m+1,hi)}}
// make it a little lopsided like real BSTs: use unbalanced insertion order
const order=[48,24,72,12,36,60,84,6,18,30,42,54,66,78,90,3,9,15,21,27,33,39,45,51,57,63,69,75,81,87,93];
let root=null;function ins(n,k){if(!n)return{k,l:null,r:null};if(k<n.k)n.l=ins(n.l,k);else n.r=ins(n.r,k);return n}
order.forEach(k=>root=ins(root,k));
const A=document.getElementById('a'),B=document.getElementById('b');
const aN={},bN={};
function layoutBST(n,d,x0,x1){if(!n)return;n.x=(x0+x1)/2;n.y=22+d*56;layoutBST(n.l,d+1,x0,n.x);layoutBST(n.r,d+1,n.x,x1)}
layoutBST(root,0,0,520);
function drawBST(n){if(!n)return;[n.l,n.r].forEach(c=>{if(c){el('line',{x1:n.x,y1:n.y,x2:c.x,y2:c.y,class:'e'},A);drawBST(c)}})}
function drawNodes(n){if(!n)return;aN[n.k]={n};n.c=el('circle',{cx:n.x,cy:n.y,r:12,class:'n'},A);const t=el('text',{x:n.x,y:n.y},A);t.textContent=n.k;drawNodes(n.l);drawNodes(n.r)}
drawBST(root);drawNodes(root);
// ---- B-tree: root [27,57], children each with keys, leaves
const leaves=[[3,6,9,12],[15,18,21,24],[30,33,36,39],[42,45,48,51],[54,60,63,66],[69,72,75,78],[81,84,87,90,93]];
// 3-level: root [39,66]; mid: m0 [15,27] m1 [45,54] m2 [72,81]; leaves under: need 9 leaves
const L=[[3,6,9,12],[18,21,24],[30,33,36],[42,48,51],[57,60,63],[69,75,78],[84,87,90,93]];
// structure: root [39? ...] build explicit:
const tree={keys:[45],ch:[
 {keys:[15,27],ch:[{keys:[3,6,9,12]},{keys:[18,21,24]},{keys:[30,33,36,39,42]}]},
 {keys:[60,78],ch:[{keys:[48,51,54,57]},{keys:[63,66,69,72,75]},{keys:[81,84,87,90,93]}]}]};
// assign layout
const NW=[0];function bl(n,d){n.d=d;if(n.ch)n.ch.forEach(c=>bl(c,d+1))}bl(tree,0);
const leafList=[];(function c(n){if(!n.ch)leafList.push(n);else n.ch.forEach(c)})(tree);
const lw=520/leafList.length;leafList.forEach((n,i)=>n.x=lw*(i+.5));
(function p(n){if(n.ch){n.ch.forEach(p);n.x=(n.ch[0].x+n.ch[n.ch.length-1].x)/2}})(tree);
const cw=15,H=22;
(function draw(n){n.y=30+n.d*95;n.w=Math.max(n.keys.length*cw*2.0,40);
 if(n.ch)n.ch.forEach(c=>{draw(c);el('line',{x1:n.x,y1:n.y+H/2,x2:c.x,y2:c.y-H/2,class:'e'},B)});})(tree);
(function box(n){n.r=el('rect',{x:n.x-n.w/2,y:n.y-H/2,width:n.w,height:H,rx:4,class:'n'},B);
 n.t=n.keys.map((k,i)=>{const t=el('text',{x:n.x-n.w/2+(i+.5)*n.w/n.keys.length,y:n.y,class:'k'},B);t.textContent=k;return t});
 if(n.ch)n.ch.forEach(box)})(tree);
// leaf-level label
const sel=document.getElementById('key');
keys.forEach(k=>{const o=document.createElement('option');o.value=k;o.textContent=k;sel.appendChild(o)});
sel.value=93;
const sa=document.getElementById('sa'),sb=document.getElementById('sb');
const sleep=ms=>new Promise(r=>setTimeout(r,ms));
let run=0;
function clear(){run++;document.querySelectorAll('.n').forEach(e=>e.setAttribute('class','n'));document.querySelectorAll('.k').forEach(e=>e.setAttribute('class','k'));sa.innerHTML=sb.innerHTML=''}
document.getElementById('reset').onclick=clear;
async function searchBST(k,id){let n=root,r=0;while(n){r++;n.c.setAttribute('class','n vis');sa.innerHTML=`Block reads: <b>${r}</b> — compare ${k} with ${n.k}`;await sleep(650);if(id!=run)return;
 if(k==n.k){n.c.setAttribute('class','n found');sa.innerHTML=`Found after <b>${r}</b> block reads (one key per block, depth grows ~log₂ n).`;return}
 n=k<n.k?n.l:n.r}}
async function searchB(k,id){let n=tree,r=0;while(n){r++;n.r.setAttribute('class','n vis');sb.innerHTML=`Block reads: <b>${r}</b> — scan sorted keys inside the block`;await sleep(1100);if(id!=run)return;
 const i=n.keys.indexOf(k);if(i>=0){n.r.setAttribute('class','n found');n.t[i].setAttribute('class','k hit');sb.innerHTML=`Found after <b>${r}</b> block reads (hundreds of keys per block → ~log₅₀₀ n).`;return}
 let j=0;while(j<n.keys.length&&k>n.keys[j])j++;n=n.ch&&n.ch[j]}}
document.getElementById('go').onclick=()=>{clear();const id=run,k=+sel.value;searchBST(k,id);searchB(k,id)};
</script>
<div style=\"margin-top:8px;color:#5b6778;font-size:13px\">With 31 keys the BST needs up to 6 reads and the B-tree 3. Scale up: for a billion keys a balanced BST needs about 30 levels, a B-tree with ~500 keys per block needs about 4. Pick 93 or 3 to see the difference.</div>
</body></html>"
 :AT "2026-11-19T16:14:39" :VERSION 1)
