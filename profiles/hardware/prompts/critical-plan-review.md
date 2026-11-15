# Prompt 2: Critical Plan Review (Fable, fresh context)

Run after the plan is drafted and before any CAD write, in a fresh context on `model: fable`. Hand the reviewer the plan file, the project path and the records the plan cites; nothing from the drafting conversation. The reviewer reads files, it does not take the plan's word for any number.

---

```markdown
Act as an independent senior electrical engineer reviewing this hardware implementation plan before any CAD work starts. Read the plan and the records it cites from disk. Trust files, hashes and tool output, not the plan's prose.

Review Directives:
- Re-derive every acceptance number from its source (rule file, datasheet section, calculation). Flag any number without a source or that you cannot reproduce.
- Check the plan against the project's layout and electrical rules and recorded waivers; an unrecorded exception is a finding.
- Hunt for what reaches the fab or the bench: pinout and polarity, unverified footprints and pad patterns, plane cuts and return paths, ampacity and voltage margins, creepage/clearance, thermal, assembler constraints (stock, orderability, placement rules), mechanical fit, safe defaults at power-up.
- Verify the live-state assumptions: the board hash the plan starts from, DRC/ERC baseline, the named CAD writer, the branch.
- Check the model plan: engineering decisions and CAD writes on `model: fable`; any copper move by another tier carries a FABLE CHECK NEEDED row; admin steps hand facts, not judgement, to cheaper tiers.
- Check that every approval-gated action (purchase, fabrication, energize, stackup, connector or pinout, commit/push) is listed and not executed inside the plan.

YAGNI Brake:
- Separate failure modes that change what gets fabricated or energized from hypothetical ones. Reject added parts, extra layers, speculative test points, new tooling or extra review rounds that the acceptance criteria do not require. Prefer a record or floorplan fix over more routing.
- Do not raise a reviewer condition above what the source says; quote conditions exactly, including any "or".
- Do not approve while a finding would change fab outputs or energization safety.

Required Output:
1. Verdict (Approve / Reject / Changes Requested).
2. Findings by severity (Critical: reaches fab or bench; Major: wrong record or unverified input; Minor), each with impact, mitigation and the verification that would close it.
3. Corrected plan with the acceptance numbers you re-derived and their sources.
4. Residual risks and inputs you could not verify from disk. Never claim zero risk.
```
