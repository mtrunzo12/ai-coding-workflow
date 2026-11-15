---
paths:
  - "**/*.kicad_pcb"
  - "**/*.kicad_sch"
  - "**/*.kicad_pro"
  - "**/*.kicad_mod"
  - "**/*.kicad_sym"
  - "**/*.PcbDoc"
  - "**/*.SchDoc"
  - "**/*.brd"
  - "**/*.sch"
  - "**/*.gbr"
  - "**/*.drl"
  - "**/*.kicad_dru"
  - "**/*.kicad_wks"
  - "**/*.f3d"
  - "**/*.f3z"
  - "**/*.f3a"
  - "**/*.123dx"
  - "**/*.step"
  - "**/*.stp"
  - "**/*.iges"
  - "**/*.igs"
  - "**/*.stl"
  - "**/*.3mf"
  - "**/*.dxf"
  - "**/*.FCStd"
  - "**/*.SLDPRT"
---

# Hardware design project: standing rules

This rule loads when an electronic or mechanical CAD, model or fabrication file (KiCad, Fusion/123D, STEP, STL, Altium, Eagle, Gerber and similar) is read or edited. The full workflow is `~/.claude/hardware/workflow.md` (imported below when imports are honoured in rules files); project `AGENTS.md`/`memory.md` win over it. These rules hold even if the import does not load:

1. **One CAD writer.** Exactly one agent writes a live KiCad document. Assert the file path, branch and hash first; save through the application or its IPC; re-hash after. Never text-edit serialized CAD. Never mutate the live document for a trial; use a scratch copy.
2. **No gated action without a quoted approval in this session or a recorded decision:** purchase, quote, fabrication upload or order, energizing anything, stackup or layer-count change, connector or pinout change, commit, push, merge, PR.
3. **Evidence before claims.** "DRC clean", "routed", "in stock", "verified" require the command run this turn and its output (counts, hash, exit code). Separate verified from unverified in every status line.
4. **Model tiers.** Electrical decisions, CAD writes and acceptance reviews run on `model: fable`; bounded research and scripts may use a mid tier; admin from stated facts uses the cheapest tier. Token efficiency is a goal; do not spend Fable on admin.
5. **FABLE CHECK NEEDED.** Any copper-moving change (tracks, vias, pours, pad or footprint swaps that move copper, part moves) made by a non-Fable model gets a row in the plan's `## FABLE CHECK NEEDED` table and the PR body: checkpoint, model, exact nets/segments/vias/parts, DRC after, board hash, evidence folder. Only a Fable review in fresh context clears a row.
6. **Wind-down.** When the owner says to wind down, follow the project routine and propose learnings entries per `~/.claude/hardware-learnings/README.md` (sanitized, generic, owner approves before anything is written).

@~/.claude/hardware/workflow.md
