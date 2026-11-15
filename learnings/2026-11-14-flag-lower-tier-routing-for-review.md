# Flag copper changes made by a lower-tier model for review by the trusted tier

- **Date:** 2026-11-14
- **Project (by role):** multi-board KiCad alarm system, 4-layer main board
- **Status:** promoted (seeded into `profiles/hardware/workflow.md §6` and `rules/hardware-design.md` rule 5)
- **Applies to:** `profiles/hardware/workflow.md §6`, `prompts/pre-merge-review.md`

## What happened

When the trusted engineering model hit usage limits, a different model continued routing so work would not stall. The owner allowed this on condition that every such change be recorded under a named heading in the current plan and in the session notes, one row per checkpoint, with the exact segments, vias and parts, and stay open until the trusted model reviewed and accepted it. A later review packet ordered the open rows by blast radius so one review pass could clear them.

## Rule or check it implies

Any copper-moving change by a model other than the designated engineering tier gets a row (checkpoint, model, exact objects, DRC after, hash, evidence folder) under `## FABLE CHECK NEEDED`; only a fresh-context review on the trusted tier clears it, and the author never clears its own rows.

## Evidence (file and section only)

- Project `AGENTS.md`, section "Model selection and handoffs" (owner update and tier table)
- Project PCB plan document, section "FABLE CHECK NEEDED — Opus-made routing" (row format)
- Project review packet document, introduction (ordering rows for one review pass)
- Project `STATUS.md`, section "Rules that bind any worker" (flagging rule)

## Sanitization check

- [x] No identifiers that tie the entry to a product, vendor, person or price
- [x] Reads correctly to someone outside the project
