(:MAP :ID "lisp" :TITLE "Lisp" :COMPRESSION
 "A language whose programs are list data, letting a tiny self-interpreter define and extend the whole language.")
(:GROUP :ID "symbolic-data" :COMPRESSION
 "Everything is a symbolic expression built from pairs, atoms, and symbols.")
(:GROUP :ID "lambda-eval" :COMPRESSION
 "Functions and a one-page evaluator over those expressions give a complete language that defines itself.")
(:GROUP :ID "evaluation-model" :COMPRESSION
 "How environments, binding, scope, and control actually turn expressions into values.")
(:GROUP :ID "homoiconic-power" :COMPRESSION
 "Because code is data, programs can quote, build, and transform other programs as macros.")
(:GROUP :ID "mutation-and-objects" :COMPRESSION
 "Adding state, identity, generic dispatch, and condition handling scales Lisp to large systems.")
(:GROUP :ID "dialects-and-synthesis" :COMPRESSION
 "The great dialects embody competing answers that together define modern Lisp practice.")
(:NODE :ID "s-expression" :TITLE "Symbolic expressions" :COMPRESSION
 "All data and all code are the same recursive tree of atoms and parenthesized lists." :BODY
 "A single uniform data structure is the substrate from which every other Lisp idea is built."
 :GROUP "symbolic-data" :PREREQS NIL :ERA 1960)
(:NODE :ID "atom-and-symbol" :TITLE "Atoms and symbols" :COMPRESSION
 "An atom is an indivisible value, and a symbol is a name that can stand for something else." :BODY
 "Symbols give Lisp a first-class notion of 'names', which is what lets programs talk about programs."
 :GROUP "symbolic-data" :PREREQS ("s-expression") :ERA 1960)
(:NODE :ID "cons-cell" :TITLE "The cons cell" :COMPRESSION
 "A pair of two pointers (car and cdr) is the single primitive from which all list structure is built."
 :BODY
 "Every list, tree, and program in Lisp is just cons cells, so understanding them is understanding Lisp's memory."
 :GROUP "symbolic-data" :PREREQS ("s-expression") :ERA 1960)
(:NODE :ID "nil-and-lists" :TITLE "Lists and nil" :COMPRESSION
 "A list is a chain of cons cells ending in the empty list nil, which doubles as logical false."
 :BODY
 "The list is the organizing pattern of the whole language, including the source code itself."
 :GROUP "symbolic-data" :PREREQS ("cons-cell") :ERA 1960)
(:NODE :ID "primitive-functions" :TITLE "The seven primitives" :COMPRESSION
 "car, cdr, cons, atom, eq, and the conditional suffice to express all list computation." :BODY
 "A tiny irreducible core shows that the language's power comes from composition, not from a big feature set."
 :GROUP "symbolic-data" :PREREQS ("cons-cell" "atom-and-symbol") :ERA 1960)
(:NODE :ID "lambda" :TITLE "Lambda abstraction" :COMPRESSION
 "A function is an anonymous value written as lambda over parameters and a body." :BODY
 "Borrowed from Church, lambda makes functions first-class data, the precondition for a language that manipulates itself."
 :GROUP "lambda-eval" :PREREQS ("primitive-functions") :ERA 1960)
(:NODE :ID "recursion" :TITLE "Recursion over structure" :COMPRESSION
 "Computation proceeds by a function calling itself on the car and cdr of its input." :BODY
 "Recursion, not iteration, is Lisp's native engine because data is recursively defined." :GROUP
 "lambda-eval" :PREREQS ("nil-and-lists" "lambda") :ERA 1960)
(:NODE :ID "conditional" :TITLE "The conditional expression" :COMPRESSION
 "cond chooses a branch by evaluating test clauses in order until one is true." :BODY
 "McCarthy's conditional as a value-returning expression is the control primitive on which recursion and everything else rest."
 :GROUP "lambda-eval" :PREREQS ("primitive-functions") :ERA 1960)
(:NODE :ID "quote" :TITLE "Quotation" :COMPRESSION
 "quote tells the evaluator to treat a form as literal data instead of evaluating it." :BODY
 "Quote is the hinge between code and data: it lets a program hold another program as an inert value."
 :GROUP "lambda-eval" :PREREQS ("s-expression") :ERA 1960)
(:NODE :ID "eval-apply" :TITLE "eval and apply" :COMPRESSION
 "A one-page pair of functions, eval and apply, interprets any Lisp expression, defining the language in itself."
 :BODY
 "This metacircular evaluator is the central discovery of Lisp: the language is specified by a short program in the language itself."
 :GROUP "lambda-eval" :PREREQS ("lambda" "conditional" "quote" "recursion") :ERA 1960)
(:NODE :ID "read-eval-print" :TITLE "Read–eval–print loop" :COMPRESSION
 "An interactive loop reads an expression, evaluates it, and prints the result, forever." :BODY
 "Making eval interactive turns programming into a live conversation with a running system." :GROUP
 "lambda-eval" :PREREQS ("eval-apply") :ERA 1960)
(:NODE :ID "environment" :TITLE "The environment" :COMPRESSION
 "Evaluation happens against an environment mapping symbols to values." :BODY
 "The environment is where binding, scope, and state all live; it is the missing argument that makes eval work."
 :GROUP "evaluation-model" :PREREQS ("eval-apply") :ERA 1960)
(:NODE :ID "binding-eval-order" :TITLE "Argument evaluation order" :COMPRESSION
 "By default a call evaluates each argument first, then applies the function (applicative order)."
 :BODY
 "Knowing when and whether arguments are evaluated is what distinguishes functions, special forms, and macros."
 :GROUP "evaluation-model" :PREREQS ("environment") :ERA 1960)
(:NODE :ID "lexical-scope" :TITLE "Lexical scope" :COMPRESSION
 "A name refers to the binding textually enclosing its use, not to whoever happened to call." :BODY
 "Scheme's switch from dynamic to lexical scope fixed deep bugs and made Lisp agree with lambda calculus."
 :GROUP "evaluation-model" :PREREQS ("environment" "lambda") :ERA 1975)
(:NODE :ID "closure" :TITLE "Closures" :COMPRESSION
 "A function value carries the environment it was defined in, capturing free variables." :BODY
 "Closures are first-class functions with memory, enabling objects, generators, and modular state from lambda alone."
 :GROUP "evaluation-model" :PREREQS ("lexical-scope") :ERA 1975)
(:NODE :ID "tail-recursion" :TITLE "Proper tail calls" :COMPRESSION
 "A call in tail position reuses its caller's stack frame, so recursion expresses iteration without growth."
 :BODY
 "Scheme's guarantee of tail-call elimination makes recursion a complete and efficient control structure."
 :GROUP "evaluation-model" :PREREQS ("recursion" "lexical-scope") :ERA 1975)
(:NODE :ID "continuation" :TITLE "First-class continuations" :COMPRESSION
 "The whole future of a computation can be captured as a callable value (call/cc)." :BODY
 "Reifying control flow as data lets you build loops, exceptions, coroutines, and backtracking from one primitive."
 :GROUP "evaluation-model" :PREREQS ("closure" "tail-recursion") :ERA 1975)
(:NODE :ID "code-is-data" :TITLE "Homoiconicity" :COMPRESSION
 "Program source is itself an ordinary list, so programs can read and construct programs." :BODY
 "This equivalence, latent since eval, is what makes Lisp's self-modification practical rather than theoretical."
 :GROUP "homoiconic-power" :PREREQS ("eval-apply" "quote") :ERA 1960)
(:NODE :ID "quasiquote" :TITLE "Quasiquotation" :COMPRESSION
 "A template that is mostly quoted but lets you splice in computed pieces (backquote and unquote)."
 :BODY
 "Quasiquote is the practical tool for assembling code as data cleanly, the workhorse of macro writing."
 :GROUP "homoiconic-power" :PREREQS ("code-is-data") :ERA 1960)
(:NODE :ID "fexpr" :TITLE "Fexprs" :COMPRESSION
 "An operator that receives its arguments unevaluated at runtime and decides what to do with them."
 :BODY
 "The first answer to custom syntax; its weakness (defeating static analysis) motivated the shift to macros."
 :GROUP "homoiconic-power" :PREREQS ("binding-eval-order" "code-is-data") :ERA 1960)
(:NODE :ID "macro" :TITLE "Macros" :COMPRESSION
 "A function from source form to source form, run before evaluation, that extends the language's syntax."
 :BODY
 "Macros let you add new language constructs yourself, the concrete form of 'a programmable programming language'."
 :GROUP "homoiconic-power" :PREREQS ("code-is-data" "quasiquote") :ERA 1963)
(:NODE :ID "hygiene" :TITLE "Macro hygiene" :COMPRESSION
 "Hygienic macros rename introduced names so expanded code never accidentally captures the user's variables."
 :BODY "Hygiene makes macros composable and safe, turning a sharp tool into a reliable one." :GROUP
 "homoiconic-power" :PREREQS ("macro" "lexical-scope") :ERA 1986)
(:NODE :ID "mutation-identity" :TITLE "Mutation and identity" :COMPRESSION
 "setf-style assignment and in-place pair mutation give cells a persistent, shareable identity."
 :BODY
 "State and object identity are what distinguish a value you copy from a thing you change, essential for real systems."
 :GROUP "mutation-and-objects" :PREREQS ("environment" "cons-cell") :ERA 1960)
(:NODE :ID "symbol-property" :TITLE "Symbols as rich objects" :COMPRESSION
 "A symbol bundles a name, a value cell, a function cell, and a property list in one interned object."
 :BODY
 "Symbols as first-class, interned, attribute-carrying objects power everything from variables to keywords to packages."
 :GROUP "mutation-and-objects" :PREREQS ("atom-and-symbol" "mutation-identity") :ERA 1960)
(:NODE :ID "garbage-collection" :TITLE "Automatic memory" :COMPRESSION
 "Unreachable cons cells are reclaimed automatically so programs allocate freely without manual freeing."
 :BODY
 "Lisp invented garbage collection; freeing the programmer from memory bookkeeping is a precondition for symbolic programming."
 :GROUP "mutation-and-objects" :PREREQS ("cons-cell" "mutation-identity") :ERA 1960)
(:NODE :ID "generic-dispatch" :TITLE "Generic functions (CLOS)" :COMPRESSION
 "Behavior is chosen by the types of all arguments via multimethods, not owned by a single class."
 :BODY
 "Multiple dispatch, built as a library on macros, shows Lisp absorbing object orientation without changing the core."
 :GROUP "mutation-and-objects" :PREREQS ("macro" "symbol-property") :ERA 1988)
(:NODE :ID "metaobject-protocol" :TITLE "The metaobject protocol" :COMPRESSION
 "The object system is itself built from objects you can subclass to change how objects work."
 :BODY
 "The MOP is reflection taken to its limit: even the language's semantics become user-modifiable."
 :GROUP "mutation-and-objects" :PREREQS ("generic-dispatch" "eval-apply") :ERA 1991)
(:NODE :ID "condition-system" :TITLE "The condition system" :COMPRESSION
 "Signaling separates detecting a problem from deciding how to recover, via restarts chosen higher up."
 :BODY
 "A more general model than exceptions, it shows how continuations and dynamic scope combine into resumable error handling."
 :GROUP "mutation-and-objects" :PREREQS ("continuation" "macro") :ERA 1985)
(:NODE :ID "lisp15" :TITLE "Lisp 1.5 lineage" :COMPRESSION
 "The first widely used Lisp fixed the core and spawned the whole family tree of dialects." :BODY
 "Knowing the common ancestor lets you read every later dialect as a set of deliberate choices and departures."
 :GROUP "dialects-and-synthesis" :PREREQS ("read-eval-print" "garbage-collection") :ERA 1962)
(:NODE :ID "scheme-minimalism" :TITLE "Scheme's minimalism" :COMPRESSION
 "A tiny core of lexical closures, tail calls, and continuations, kept deliberately small." :BODY
 "Scheme is the clean distillation that teaches the semantics; it is Lisp reduced to its load-bearing ideas."
 :GROUP "dialects-and-synthesis" :PREREQS ("closure" "continuation" "hygiene") :ERA 1975)
(:NODE :ID "common-lisp" :TITLE "Common Lisp synthesis" :COMPRESSION
 "An industrial standard uniting macros, CLOS, conditions, and packages into one large pragmatic language."
 :BODY
 "Common Lisp is the maximalist answer, showing how the core scales to a full production environment."
 :GROUP "dialects-and-synthesis" :PREREQS ("generic-dispatch" "condition-system" "lisp15") :ERA
 1984)
(:NODE :ID "image-based-dev" :TITLE "Image-based development" :COMPRESSION
 "You grow and save a living, running system rather than compiling a dead program from scratch."
 :BODY
 "Interactive, redefine-anything development is Lisp's distinctive and underappreciated way of building software."
 :GROUP "dialects-and-synthesis" :PREREQS ("read-eval-print" "common-lisp") :ERA 1962)
(:NODE :ID "lisp-as-lab" :TITLE "Lisp as a language laboratory" :COMPRESSION
 "Because eval and macros are open, a Lisp program can grow its own domain-specific language."
 :BODY
 "This is the payoff of the whole map: the field's real thesis is that you build the language up to the problem."
 :GROUP "dialects-and-synthesis" :PREREQS ("macro" "metaobject-protocol" "scheme-minimalism") :ERA
 1975)
(:NODE :ID "syntax-rules" :TITLE "syntax-rules pattern macros" :COMPRESSION
 "A declarative pattern-and-template language makes hygienic macros writable by matching input forms and rewriting them."
 :BODY
 "It turned the 1986 hygiene idea into something usable, and is how Scheme and Racket actually write macros today. R4RS (1991, appendix) and R5RS (1998) standardised `syntax-rules`: macros become pattern matchers over syntax objects rather than raw lists, so hygiene is automatic. Where patterns are not enough, Kohlbecker's hygiene and Clinton/Rees/Bawden's `syntax-case` (1992) gave the procedural escape hatch."
 :GROUP "homoiconic-power" :PREREQS ("hygiene") :ERA 1998)
(:NODE :ID "beating-the-averages" :TITLE "Beating the Averages" :COMPRESSION
 "Graham argued that Lisp macros gave Viaweb a power other teams literally could not match, coining the 'Blub paradox'."
 :BODY
 "Paul Graham's 2001 essay, drawn from the Viaweb/Yahoo Store experience, is the primary-source case that homoiconic metaprogramming is an economic advantage, not just an elegance. Its Blub paradox explains why the advantage stays hidden: a programmer in a mid-level language can't see the power of languages above theirs. Graham's book *On Lisp* (1993) is the deep macro reference behind the argument."
 :GROUP "dialects-and-synthesis" :PREREQS ("macro" "common-lisp") :ERA 2001)
(:NODE :ID "arc" :TITLE "Arc" :COMPRESSION
 "Graham's attempt to redesign Lisp for 'exploratory programming' by ruthlessly minimising common operations."
 :BODY
 "It shows the living tension in Lisp design: synthesis (Common Lisp) versus re-minimisation, pursued by Lisp's loudest modern advocate. Released in 2008, Arc is built on the idea that terseness for the common case matters most. It was famously controversial and is less influential than Clojure, but it is a clear data point on where Graham thinks the language should go."
 :GROUP "dialects-and-synthesis" :PREREQS ("scheme-minimalism" "beating-the-averages") :ERA 2008)
(:NODE :ID "persistent-data" :TITLE "Persistent data structures" :COMPRESSION
 "Immutable collections that share structure give cheap 'updated copies' without mutating the original."
 :BODY
 "It is Clojure's core move: it keeps Lisp's list-centric feel while discarding in-place mutation as the default. Hash array mapped tries (Bagwell, 2001) make vectors and maps with near-O(1) update by structural sharing, so old versions stay valid forever — the opposite of cons-cell mutation. This reframes identity: a value never changes; only a reference points at a new value."
 :GROUP "mutation-and-objects" :PREREQS ("nil-and-lists" "mutation-identity") :ERA 2001)
(:NODE :ID "clojure" :TITLE "Clojure" :COMPRESSION
 "A modern Lisp on the JVM built around immutable persistent data and a disciplined model of state and concurrency."
 :BODY
 "It is the most widely adopted new Lisp dialect, and it rethinks mutation and identity for a concurrent world. Rich Hickey released it in 2007 around a few core ideas: everything is a value by default; state is explicit, held in atoms, refs and agents with software transactional memory; sequences are the unifying abstraction; and it is hosted on the JVM (and, as ClojureScript, on JS). Hickey's talks 'Are We There Yet?' and 'Simple Made Easy' give the philosophy."
 :GROUP "dialects-and-synthesis" :PREREQS ("persistent-data" "common-lisp") :ERA 2007)
(:NODE :ID "racket-languages" :TITLE "Racket: languages as modules" :COMPRESSION
 "Racket makes 'write your own language' routine: each module declares its #lang, and macros define real syntax."
 :BODY
 "It is the full realisation of Lisp as a language laboratory — language-oriented programming as the default workflow. Racket grew out of PLT Scheme (1995) and took its name in 2010. `#lang` lets a module be written in a different language implemented as a library, because the reader, the macro expander and the module system are all extensible. Flatt et al., 'Languages as Libraries' (2012), is the primary source."
 :GROUP "dialects-and-synthesis" :PREREQS ("scheme-minimalism" "lisp-as-lab") :ERA 2010)
