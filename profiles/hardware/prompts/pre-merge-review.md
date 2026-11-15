# Prompt 3: Pre-Merge Review (CAD diff + DRC/ERC grounded)

> Run in a fresh context on `model: fable`, not by the agent that made the change. The audit is grounded in the saved KiCad files, their diff against the base, and tool output run in this review; never in conversation claims. It also clears or keeps FABLE CHECK NEEDED rows.

---

```markdown
Before any commit, PR or fabrication export, independently audit the actual hardware change in the repository against the approved plan.

Audit Methodology:
- Start with `git status` and `git diff --stat` (or `git diff <base>...HEAD` if committed). Read every untracked file. Record the board and schematic hashes and compare them with the plan's before/after values.
- If an editor is open, confirm the live document equals the saved file before trusting the file; if they differ, stop and report.
- Diff the CAD at object level, not as text: footprints added/removed/moved, tracks, vias, zones, net assignments, schematic symbols and fields, DNP and BOM flags. The declared change list in the plan is the only allowed set; anything outside it is a finding.
- Run ERC and DRC yourself from the saved files and record opens, errors, parity, warnings vs. the accepted list. Run the project's validate/export scripts if they exist. Diff netlist and BOM against the base.
- Use the approved plan only as the checklist of acceptance criteria.

Inspection Checklist:
- Each acceptance number met, with the measured value: clearance, width, current, rating, stock at a stated time.
- Pinout and polarity of any new or swapped part against the datasheet section; pad pattern against the footprint; symbol pin to pad mapping.
- Planes and return paths intact; no signal on a layer the rules reserve without a recorded waiver; via and neck rules met.
- Fab outputs: if Gerbers, drill, CPL or BOM were regenerated, they match the CAD hashes and the package check passes; if not regenerated, say the package is stale.
- FABLE CHECK NEEDED rows for this change: review each against the file and evidence; write Accepted or Rejected with your own DRC output and hash. Never clear a row for work you authored.

Remediation:
- For each confirmed issue: root cause and blast radius (record only / copper / fab outputs / energization safety) → smallest targeted fix by the one CAD writer, through the application or IPC → re-run the affected check → re-diff. If the fix needs a gated change (stackup, connector, pinout, power tree, rule waiver), stop and ask.
- Never text-edit serialized CAD. Never weaken a rule, delete an accepted-warning entry or widen a waiver to make a check pass.

Safety Boundaries:
- Do not commit, push, upload, quote, purchase or energize. Do not delete evidence folders.
- Do not declare the change release-ready while any acceptance criterion is unmeasured or a FABLE CHECK NEEDED row is open. Separate verified results, unverified items and residual risk.

End with the exact bench or placement-preview checks the owner must still perform, each with its expected result.
```
