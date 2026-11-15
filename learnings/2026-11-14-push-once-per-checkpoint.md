# Push once per checkpoint; several quick pushes cancel each other's CI

- **Date:** 2026-11-14
- **Project (by role):** multi-board KiCad alarm system with hosted CI
- **Status:** promoted (seeded into `profiles/hardware/workflow.md §7`)
- **Applies to:** `profiles/hardware/workflow.md §7` (branch finishing)

## What happened

Documentation-only pushes made in quick succession cancelled each other's hosted CI runs, so the latest head had no green result and earlier green results did not prove the new head passed. The project adopted: make coherent checkpoint commits, validate locally first, publish once per checkpoint, and never treat cancellation, timeout or an old green run as acceptance for the current head.

## Rule or check it implies

Batch commits into one checkpoint, run the cheapest relevant local checks, push once, and require the required checks on the exact final head before merge.

## Evidence (file and section only)

- Project `memory.md`, 12 November opener, "Lessons" paragraph
- Project `AGENTS.md`, section "CI budget and publication discipline"

## Sanitization check

- [x] No identifiers that tie the entry to a product, vendor, person or price
- [x] Reads correctly to someone outside the project
