# Prompt 1: Hardware Planning

Use this prompt before any CAD write. Any tier may draft the plan; a `model: fable` agent must approve the acceptance numbers before the plan goes to the owner. The plan is saved where the project keeps plans and is the checklist for Stages 2 and 3.

---

```markdown
Write an implementation plan as a markdown document for this hardware change. Do not touch any CAD, BOM or fabrication file. Stop once the plan is saved and wait for my approval.

Scope & Inspection:
- State the project path, branch, the exact KiCad files (schematic sheets, board), BOM/CPL files and records you expect to change, and their current hashes.
- Confirm the live state first: board hash matches the recorded checkpoint, DRC/ERC baseline counts (opens, errors, parity, accepted warnings), and whether an editor holds the document. Name the one CAD writer.
- Inspect the governing records (AGENTS.md rules and waivers, decision records, requirement rows, current plan) and quote the constraint each step obeys. Never invent part numbers, stock, footprints, pin maps or rules.

Acceptance Criteria (each measurable, each with its source):
- Electrical: clearances and widths with the rule they come from, current per net or pour with the calculation, voltage ratings vs. rails, thermal limits where a part dissipates, return-path or plane requirements.
- Connectivity: expected DRC result (opens, errors, parity), ERC result, netlist diff limited to the named nets.
- Procurement: BOM diff limited to the named lines; every new or swapped part with MPN, assembler stock at a stated time, footprint and pinout verified against the datasheet section.
- Integrity: saved-object diff shows zero removed or changed objects outside the declared list; before/after hashes recorded.

Risk Analysis:
- List failure modes that reach fabrication or energization: wrong pinout, polarity, unverified footprint, plane cuts, ampacity, creepage, mechanical fit, assembler constraints.
- Choose the simplest change that meets the criteria (YAGNI): prefer a record fix over a copper change, a floorplan move over a point-search route, an existing stocked part over a new one.
- Name the single deciding number for any open question and compute it, or state the owner question with a recommendation.

Verification & Model Plan:
- For each criterion give the exact command or procedure (kicad-cli / IPC query, DRC/ERC run, diff script, render) and the expected output.
- State which steps run on `model: fable`, which may run on a cheaper tier, and which produce copper moves that would need a FABLE CHECK NEEDED row.
- List approval-gated steps (purchase, fabrication, energize, stackup, connector/pinout, commit/push) separately; none executes inside this plan.
- List unresolved assumptions, unverified inputs and residual risk. Do not claim the design is complete.

Adapt to the task. A footprint field fix does not need a thermal section; a stackup change needs all of it.
```
