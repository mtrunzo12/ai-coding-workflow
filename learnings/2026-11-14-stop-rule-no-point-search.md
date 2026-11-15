# Stop after two similar failures; never point-search a blocked route

- **Date:** 2026-11-14
- **Project (by role):** multi-board KiCad alarm system, 4-layer main board
- **Status:** promoted (seeded into `profiles/hardware/workflow.md §5`)
- **Applies to:** `profiles/hardware/workflow.md §5`, `prompts/critical-plan-review.md` (YAGNI brake)

## What happened

A routing phase spent many hours and hundreds of megabytes of analysis on one blocked corridor without closing an open or running a native trial. The owner found the proof out of proportion to the risk and set rules: find the deciding number first, try it for real on a scratch copy early, stop after one working day on one problem and report with a recommendation, and treat tiny hops and trial vias after two similar failures as an unacceptable response to a blocked corridor (the fix is a floorplan or corridor change).

## Rule or check it implies

After two substantially identical failures on one problem, record the blocker and switch to a floorplan or record change or an owner question; do not continue with trial vias, tiny hops or further studies.

## Evidence (file and section only)

- Project `AGENTS.md`, section "PCB layout paradigm", rule "Change strategy after two similar failures"
- Project `AGENTS.md`, section "Planning and rigor budget" (deciding number first, try it for real early, stop rule, match proof to risk)
- Project `STATUS.md`, section "Rules that bind any worker" (stop rule)

## Sanitization check

- [x] No identifiers that tie the entry to a product, vendor, person or price
- [x] Reads correctly to someone outside the project
