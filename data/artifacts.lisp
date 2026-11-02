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
(:ID "sr-latch-from-two-nor-gates" :MAP "computers" :NODE NIL :TYPE "svg" :TITLE
 "SR latch from two NOR gates" :LANGUAGE NIL :CONTENT
 "<svg viewBox=\"0 0 640 420\" xmlns=\"http://www.w3.org/2000/svg\" font-family=\"sans-serif\">
  <style>
    .lbl{font-size:16px;fill:#111}
    .pin{font-size:14px;fill:#333}
    .wire{stroke:#111;stroke-width:2;fill:none}
    .fb{stroke:#c0392b;stroke-width:2;fill:none;stroke-dasharray:5 4}
    .gate{fill:#eef3fb;stroke:#2c3e50;stroke-width:2}
    .title{font-size:18px;fill:#111;font-weight:bold}
    .note{font-size:13px;fill:#555}
    .hdr{font-size:13px;fill:#111;font-weight:bold}
    td,th{}
  </style>

  <text x=\"20\" y=\"28\" class=\"title\">SR latch: two NOR gates in a loop</text>

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

  <!-- R input into top gate -->
  <line x1=\"90\" y1=\"85\" x2=\"200\" y2=\"85\" class=\"wire\"/>
  <text x=\"70\" y=\"90\" class=\"lbl\">R</text>
  <!-- S input into bottom gate -->
  <line x1=\"90\" y1=\"285\" x2=\"200\" y2=\"285\" class=\"wire\"/>
  <text x=\"70\" y=\"290\" class=\"lbl\">S</text>

  <!-- Q output from top -->
  <line x1=\"263\" y1=\"105\" x2=\"430\" y2=\"105\" class=\"wire\"/>
  <text x=\"440\" y=\"110\" class=\"lbl\">Q</text>
  <!-- Q' output from bottom -->
  <line x1=\"263\" y1=\"265\" x2=\"430\" y2=\"265\" class=\"wire\"/>
  <text x=\"440\" y=\"270\" class=\"lbl\">Q&#772;</text>

  <!-- Feedback Q -> bottom gate second input -->
  <path d=\"M330,105 L330,160 L180,160 L180,250 L200,250\" class=\"fb\"/>
  <!-- Feedback Q' -> top gate second input -->
  <path d=\"M360,265 L360,200 L160,200 L160,120 L200,120\" class=\"fb\"/>

  <text x=\"300\" y=\"150\" class=\"note\">red = feedback: each output steers the other gate</text>

  <!-- State table -->
  <text x=\"20\" y=\"345\" class=\"hdr\">S  R   →   Q</text>
  <text x=\"20\" y=\"368\" class=\"note\">0  0   hold previous Q   ← this is the memory</text>
  <text x=\"20\" y=\"388\" class=\"note\">1  0   Q = 1   (set)</text>
  <text x=\"20\" y=\"408\" class=\"note\">0  1   Q = 0   (reset)</text>
  <text x=\"330\" y=\"388\" class=\"note\">1  1   not allowed</text>
</svg>"
 :AT "2026-11-02T13:07:07" :VERSION 1)
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
