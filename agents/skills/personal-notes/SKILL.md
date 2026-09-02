---
name: personal-notes
description: Search, read, create, and update personal Obsidian notes in the knowledge vault at $HOME/notes. Use when asked about CS concepts, programming languages, tools, infrastructure, engineering practices, projects, learning, or anything in the personal notebook.
---
## When to use
Any request that involves the user's personal knowledge base: finding definitions, reading notes on a topic, creating new notes, updating existing notes, or organising the vault.

Example triggers:
- "what do my notes say about X?"
- "create a note on X"
- "update my note on X"
- "add a section on Y to Z"
- "what notes do I have about Docker?"
- "summarise my notes on data structures"

## Vault location
`$HOME/notes`

## Structure

### 01. Concepts
Core computer-science topics:
- **Algorithms/** — sorting, searching, graph algorithms
- **Compiler/** — lexing, parsing, code generation
- **Concurrency and Models/** — threads, actors, CSP, async
- **Data Structures/** — trees, heaps, graphs, hash maps, etc.
- **Data Types/** — ADTs, enums, generics, type theory
- **GenAI/** — LLM concepts, agents, tools, prompting, RAG, fine-tuning, MCP
- **Paradigms/** — OOP, FP, logic programming, literate programming
- **Type Systems/** — static vs dynamic, gradual typing, type inference
- Standalone notes: Big O Notation, Regex, Reflection, Call Stack, Garbage Collection, etc.

### 02. Languages
- **Languages/** — one note per language (Rust, Go, Python, Elixir, Zig, etc.)
- **Frameworks/** — Phoenix, Flask, React, etc.
- **Libraries/** — notable libraries
- **Markup/** — HTML, CSS, Markdown, LaTeX

### 03. Tools
- **CLI/** — ~50 CLI tool notes (ripgrep, fd, jq, tmux, etc.)
- **Editors/** — Neovim, VS Code, Helix, etc.
- **GUI/** — desktop applications
- **Plotting and Diagrams/** — Mermaid, PlantUML, Graphviz, D2
- **Shells/** — Bash, Zsh, Fish
- **Web Servers/** — Nginx, Caddy
- **CI and CD/** — Jenkins, GitHub Actions, etc.
- **Services/** — hosted services
- **Web/** — web tools and utilities

### 04. Infra
- **Cloud/** — AWS, GCP, Proxmox
- **Databases/** — PostgreSQL, SQLite, Redis, etc.
- **DevOps/** — Ansible, Docker, Kubernetes, Terraform, Nix
- **Hardware/** — CPUs, GPUs, SBCs, networking hardware, home-lab gear
- **Messaging/** — Kafka, RabbitMQ, NATS
- **Monitor and Log/** — Prometheus, Grafana, ELK
- **Networks/** — TCP/IP, DNS, VPN, Tailscale
- **Orchestration/** — container orchestration
- **OSes/** — Linux, macOS, NixOS
- **Protocols/** — HTTP, gRPC, MQTT, WebSocket
- **Telco/** — telecom-specific infrastructure
- **Homelab/** — home server and self-hosting

### 05. Eng Practices
- **Design Patterns/** — GoF patterns, architectural patterns
- **UML/** — class diagrams, sequence diagrams
- Standalone: Refactoring, Unit Test

### 06. Proj and Learning
- **Courses/** — course notes and materials
- **Books/** — book notes
- **Electronics/** — electronics projects
- **Talks/** — conference talk notes
- Standalone: Advent Of Code, Exercism, Leetcode, Computer In Python, Dotfiles, Git-Internals

### 07. Misc
- **House/** — house-related notes
- **DIY/** — DIY projects
- **Games/** — game notes
- Standalone: Dog Training, Homebridge, Homeassistant, Homelab

### Root files
- `README.md` — vault structure explanation
- `Zettelkasten.md` — index of high-value notes with cross-links
- `Stubs.md` — list of stub notes that need fleshing out

## Frontmatter conventions

### Standard note
```yaml
---
tags:
  - <category>     # e.g. genai, llm, devops, rust, data-structure
url: <reference-url>   # optional — canonical external reference
aliases:
  - <ShortName>    # optional — alternate names for Obsidian linking
stub: true         # optional — marks incomplete notes
---
```

### Tag taxonomy (common tags)
- `genai`, `llm`, `agents` — AI/ML topics
- `data-structure`, `algorithm` — CS fundamentals
- `devops`, `docker`, `kubernetes`, `terraform` — infrastructure
- `rust`, `go`, `python`, `elixir`, `zig` — language-specific
- `cli`, `editor`, `shell` — tooling
- `design-pattern`, `testing`, `refactoring` — engineering practices

## Cross-linking conventions
- Use **Obsidian wikilinks**: `[Display Text](Relative%20Path.md)` or `[[Note Name]]`
- The existing notes use parenthesised relative-path links: `[LLM](Large%20Language%20Model.md)`
- For notes in the same folder, use filename only: `[RAG](RAG.md)`
- For notes in different folders, use relative paths: `[Docker](../04.%20Infra/DevOps/Docker.md)`
- Add a `## See Also` section at the bottom with links to related notes

## Steps when searching
1. Use `grep` or `glob` against `$HOME/notes` to find relevant `.md` files
2. Filter to `*.md` files — skip binary files and `.obsidian/` config
3. Read matching files with the `read` tool
4. For topic lookups: search the relevant section folder first, then broaden
5. Check `Zettelkasten.md` for an index entry on the topic

## Steps when creating notes
1. Determine the correct folder based on topic:
   - CS concept → `01. Concepts/` (or appropriate subfolder)
   - Language-specific → `02. Languages/Languages/` or `02. Languages/Frameworks/`
   - Tool → `03. Tools/` (CLI, Editors, etc.)
   - Infrastructure → `04. Infra/` (appropriate subfolder)
   - Engineering practice → `05. Eng Practices/`
   - Project/learning → `06. Proj and Learning/`
2. Add YAML frontmatter with appropriate tags and aliases
3. Write the definition/explanation with:
   - **What it is** — concise definition
   - **Key concepts** — core ideas, components, or characteristics
   - **When to use** — practical guidance
   - **When NOT to use** — anti-patterns or alternatives
   - **See Also** — cross-links to related notes
4. Use wikilinks for cross-references to other notes in the vault
5. Match the style of existing notes in the same folder

## Steps when updating notes
1. Read the existing note first
2. Preserve existing frontmatter — add to it, don't replace it
3. Maintain the existing structure and style
4. Add new sections or content where appropriate
5. Update cross-links if new related notes exist
6. If adding to `Zettelkasten.md`, add under the appropriate section heading

## Attachments and images
- Place images in an `attachments/` subfolder next to the note (e.g. `01. Concepts/GenAI/attachments/diagram.png`)
- Create the `attachments/` folder if it doesn't exist yet
- Reference with relative paths: `![](attachments/diagram.png)`
- Do NOT use the root `img/` folder for new images — that's legacy

## What NOT to do
- Do NOT modify `.obsidian/` config, plugins, or theme files
- Do NOT modify `scripts/` or `.github/` files
- Do NOT create notes in `.quartz/` or `docs/` (those are publishing config)
- Do NOT create duplicate notes — check if one exists first
- Do NOT delete notes without explicit confirmation
- Skip binary files (images, PDFs) during search — restrict to `*.md`
