# studybuddy

Study the core ideas of a field, not the infinite examples of them. A map of each field, a study buddy (Claude) living inside the map, and one loop: create a field, see its breadth, go deep where it matters, hone it over time. The full articulation lives on the home page (`data/about.md`) and is edited there.

## The workflow

1. **Create a field** (`/fields`). Name it, say what you know and why you want it. The model researches it with web search and lays out the core ideas breadth first, in prerequisite order.
2. **See the whole field** (`/computers`). One page: a **timeline** on the left (a bar per group across the years; click a bar to open its ideas) and the **topics** outline on the right (a title and subtitle per group; click to open its ideas like a folder). Click an idea and its detail opens below on the same page, with the writing box and a built-in Claude chat on its right. A Claude button at the top right of the timeline and of the topics opens the chat pinned to that section, so it can change it.
3. **Ask Claude** — the one channel to the model. The dock is a claude.ai-style chat: a rail of **chats** on the left (new, rename, delete; each place — the field, the timeline, the topics, one idea — keeps its own list), the conversation, and one composer card with a "Looking at" chip for where you are. A first message starts a chat; once the reply is in, the model names it (two to five words), and `(name-chats!)` at the REPL names any older chats still wearing their first words. Your words go with the map, that focus, your attempts and the chat so far. The reply streams in as it is written, and the model acts through tools, the way claude.ai does: it can change the map (add, update, remove, regroup; notes grow here) and it can **make things** — a flashcard deck, a scored quiz, a diagram (SVG or Mermaid), a document, a program, or an interactive HTML page. Each thing is an **artifact**: a diagram or a page shows itself in the chat under the reply (a framed preview with its card), the rest show as a card; a click on any card opens it on a stage beside the chat, and each has a page of its own (`/artifact/<id>`). What it did on the way (searched the web, added ideas) is listed above the reply; "web" turns search on, "think" sets the reasoning effort, Stop aborts. A changed map redraws the page.
4. **Go deep** (`/computers/switches/ram`). Write your explanation cold, get right / missing / wrong, rate yourself by hand. Edit or remove the idea by hand if you prefer.

URLs are a directory, shown as a path under the nav: `studybuddy / fields / computers / switches / ram`. Pages: `/`, `/fields`, `/:field`, `/:field/:group`, `/:field/:group/:idea`; `/:field?around=<idea>` shows one idea with what it builds on and leads to; `/artifact/:id` is an artifact on its own page and `/artifact/:id/view` the thing itself (what the frames load). Actions: ask, rename-chat, delete-chat, attempt, rate, edit-node, add-node, remove-node, remove-artifact, about, seed. Fragments the dock fetches: `/chats` (one place's chat list) and `/chat/:id` (one chat's messages).

## Layers

Built bottom-up, one small language per layer, each live-editable from the REPL:

| Layer | File | Gives |
| --- | --- | --- |
| L0 | `src/util.lisp` | `str`, `join`, `slugify`, `now-iso`, `read-file-forms`/`write-file-forms` (the whole persistence layer) |
| L1 | `src/html.lisp` | the `html` macro: s-expressions in, escaped HTML out; `defcomponent`; `markdown->html` for the small subset the model writes |
| L2 | `src/web.lisp` | `defpage`, `defaction`, `layout`, `redirect`; routes are a table so a re-evaluated form is live |
| L3 | `src/store.lisp` | `defstore`: a list of plists in memory, mirrored to a file on every `put!` |
| L4 | `src/llm.lisp` | `defprompt`, `ask`, `ask-structured`, `ask-with-search` — structured answers as plists, never prose; `deftool` and `converse` — a streamed conversation in which the model calls the app's tools |
| L5 | `src/nodes.lisp`, `src/pages.lisp`, `src/actions.lisp` | Field, Node, Level, Attempt, Message, Artifact; the pages and the artifact viewers; the `converse` prompt, the tools (`add_nodes` … `create_quiz`) and the streaming `ask` action |

In the browser: `static/dock.js` runs the dock and the stage, `static/md.js` renders markdown while a reply streams (the same subset as `markdown->html`), `static/artifact.js` is the flashcard and quiz viewer.

## Data

Lisp data in files you can read and edit by hand. `data/maps/<field>.lisp` is the map: one `(:map …)`, then `(:group …)` and `(:node …)` forms, one per line; nodes carry `:notes` for depth grown over time. The model's edits rewrite this file. Everything that is yours lives beside it, keyed by `"<field>/<node-id>"`: `attempts.lisp` (append-only), `chats.lisp` (each chat's place, title, and whether it was deleted), `messages.lisp` (every message, keyed to its chat, append-only; a deleted chat's messages stay in the file and are simply not shown; messages from before chats existed show as one "Earlier conversation"), `settings.lisp`, and `artifacts.lisp` — what the model made (`:type` html, svg, mermaid, markdown, code, flashcards or quiz; `:content` the text, or the cards/questions as data), each optionally about one idea. `data/about.md` is the home page. Back it all up by copying the folder.

## Claude via the subscription relay

The app never holds an API key. Every model call is a POST to the ClaudeSubscription relay (`../hf-space`, deployed on Hugging Face Spaces), which runs the Claude Agent SDK on the Claude Code subscription. Checking an explanation and seeding a field use structured output, enforced by the engine (`outputFormat: json_schema`) and returned in a `structured` SSE event. The conversation uses the relay's streaming and caller-tool support instead: the app sends a tool manifest (`deftool`), the relay streams `delta` text and `tool_request` events, the app runs each tool and posts the answer to `/api/agent/tool-result`, and the run carries on. The relay needed no change for any of this. One Windows detail: dexador's WinHTTP backend reads a whole response before returning it, so `stream-post` in `llm.lisp` makes the WinHTTP calls itself, asking how much has arrived before each read, which is what makes the stream a stream. Set in the environment SBCL starts from:

```
STUDYBUDDY_SERVER_URL=https://roanjtaylor-claudesubscription.hf.space   # default; or http://localhost:5174 when running hf-space locally
STUDYBUDDY_APP_SECRET=<the value of the Space secret studybuddySecretKey>
```

The Space sleeps when idle, so the first call after a pause is slow. Creating a field uses web search and takes minutes; ticking "search the web" on an ask does too. The form shows "thinking…" while it waits.

## Run it

```lisp
;; ~/.sbclrc registers every subfolder of RoanTaylor/ with ASDF, so this loads by name
(ql:quickload :studybuddy)
(studybuddy:start)              ; opens http://localhost:8080/
(in-package :studybuddy)        ; then edit any defpage / defaction / defprompt, re-evaluate, refresh
(studybuddy:stop)
```

Check a hand-edited map with `(load-map "computers")` then `(check-map)`.
