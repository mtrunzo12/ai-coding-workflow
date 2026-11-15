# Keep exactly one writer per live CAD document

- **Date:** 2026-11-14
- **Project (by role):** multi-board KiCad alarm system
- **Status:** promoted (seeded into `profiles/hardware/workflow.md §3` and `rules/hardware-design.md` rule 1)
- **Applies to:** `profiles/hardware/workflow.md §3`, `rules/hardware-design.md`

## What happened

Several agents and two model families worked the same board across sessions, with an editor open and an IPC socket available. The project settled on a hard rule: one agent is the live CAD writer; everyone else is read-only on that file; delegated tasks name the writer and document ownership explicitly; nobody interrupts an in-flight save to reorganize work. The rule is restated in the hand-off status file so any new worker sees it first.

## Rule or check it implies

Every task that could touch a CAD file names the single writer; all other agents query read-only, and a writer asserts the document identity and saves through the application or its IPC, never by text edit.

## Evidence (file and section only)

- Project `AGENTS.md`, section "Model selection and handoffs" ("Keep one writer per live CAD document")
- Project `AGENTS.md`, section "Prompt-driven CAD" (one writer per live document; do not edit serialized CAD as text)
- Project `STATUS.md`, section "Rules that bind any worker" (one CAD writer at a time; CAD editing through IPC only)

## Sanitization check

- [x] No identifiers that tie the entry to a product, vendor, person or price
- [x] Reads correctly to someone outside the project
