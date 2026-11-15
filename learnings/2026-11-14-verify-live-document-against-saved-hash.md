# Verify the live CAD document against the saved file hash before trusting any note

- **Date:** 2026-11-14
- **Project (by role):** multi-board KiCad alarm system, 4-layer main board
- **Status:** promoted (seeded into `profiles/hardware/workflow.md §1` and `§4`)
- **Applies to:** `profiles/hardware/workflow.md §1` (live document check), `rules/hardware-design.md` rule 1

## What happened

Session notes carried board checkpoints by file hash. On at least one occasion an editor still held an older saved state and a later GUI save reverted a change that had been made through the external schematic tool. The project's standing routine became: at session start, re-check hashes, branch and running editors before relying on the opener; around external edits, close or reload the editor; after a save, compare the live document with the saved file.

## Rule or check it implies

Before any CAD read-for-decision or write, record the file hash, confirm it matches the recorded checkpoint, and if an editor is open confirm live equals saved; close or reload the editor around external edits.

## Evidence (file and section only)

- Project `AGENTS.md`, section "Wind-down and session start" (session-start hash and branch check)
- Project `AGENTS.md`, section "Prompt-driven CAD" (assert identity, save through the application, check the saved revision, close/reload around external edits)
- Project `memory.md`, checkpoint note that records the lesson about a stale editor save reverting an edit

## Sanitization check

- [x] No identifiers that tie the entry to a product, vendor, person or price
- [x] Reads correctly to someone outside the project
