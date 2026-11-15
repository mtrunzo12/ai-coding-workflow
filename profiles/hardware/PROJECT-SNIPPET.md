# Per-project hook-up

`install.sh` puts the hardware profile at `~/.claude/hardware/` and a path-scoped rule at `~/.claude/rules/hardware-design.md`. Per the Claude Code memory docs (code.claude.com/docs/en/memory, "Path-specific rules"), that rule loads only when Claude reads, writes or edits a file matching its globs, not at session start. A session that starts with planning or BOM work therefore does not see the workflow until the first CAD file is touched. Add one of the lines below to make it load at launch for a hardware project. Non-hardware projects add nothing and are unaffected.

## CLAUDE.md (preferred)

Add this line to the project's `CLAUDE.md` (any position; keep it outside code spans):

```markdown
@~/.claude/hardware/workflow.md
```

The import resolves outside the working directory, so Claude Code shows a one-time "external import" approval dialog per project (docs: "Import additional files"). Approve it once; declining disables imports for that project until re-enabled. Imports in user-scope files need no dialog, which is why the rule in `~/.claude/rules/` imports the same path.

## AGENTS.md (projects whose canonical instructions live there)

Claude Code reads `AGENTS.md` only when no `CLAUDE.md` exists in or above the working directory, unless the `Project instructions` setting is `claude-md-and-agents-md`. If the project has both (as DoorAlarm does), keep the `@` import in `CLAUDE.md` and add a pointer sentence to `AGENTS.md` so other tools and humans see it:

```markdown
Central hardware workflow: `~/.claude/hardware/workflow.md` (repo `ai-coding-workflow`, `profiles/hardware/`). Project rules in this file take precedence. At wind-down, propose learnings entries per `~/.claude/hardware-learnings/README.md`.
```

## Proposed diff for DoorAlarm `AGENTS.md` (not applied)

Adds the central-workflow pointer and a learnings step to the existing wind-down routine. Step numbering shifts by one; the "Rules:" line is unchanged.

```diff
--- a/AGENTS.md
+++ b/AGENTS.md
@@ ## Wind-down and session start (owner standing instruction, 4 November 2026)
 **Session start.** Before responding to the owner: read `memory.md` at the repository root, starting with the top NEXT-SESSION OPENER; check that its claims are still true (hashes, branch, running jobs) before relying on them; then respond. Winding down is a past event, not a standing state — the next session works normally and does not treat the old note as an instruction to stay idle.
+
+Central hardware workflow: `~/.claude/hardware/workflow.md` (repo `ai-coding-workflow`, `profiles/hardware/`). This file and `memory.md` take precedence over it.
 
 **Wind-down.** Only when the owner explicitly says "wind down session" (or clearly means that) — never on your own because a task finished or the conversation went quiet — run these in order, then give a short summary:
 1. Finish or park live work. Start nothing new. Note anything still running (builds, tests, background jobs) and how to check on it.
 2. Clear open requests. Every unanswered question or request gets an answer now or a line in `memory.md` saying why it is deferred. Nothing is silently dropped.
 3. Update `memory.md`, newest note at the top, leading with a block labelled NEXT-SESSION OPENER: the first thing to do next session; current state (branch names, commit SHAs, versions, file hashes where they matter); what is open in priority order and what each item waits on; what is blocked; decisions the owner made and why, in his words where it matters; relative dates converted to absolute dates.
 4. List artifacts: full paths to everything created or changed.
 5. Say what is verified and what is not. Mark each claim verified (actually checked) or unverified. Never write "fixed" or "done" without confirmation. Record failures and skipped steps plainly.
 6. Bring the owner anything only he can decide, each as one specific question answerable in under 2 minutes, and ask before closing.
-7. Cold-read test: reread the note as a new session with no memory of this one; if the work cannot be picked up cleanly from `memory.md` plus this file, rewrite it.
+7. Propose learnings: for each lesson this session produced (a check that caught or missed something, a rule that was unclear, a tool behaviour), draft one entry in chat using `~/.claude/hardware-learnings/_template.md`: what happened, the rule or check it implies, which workflow file it would change, evidence by file and section only. Sanitize: no part numbers, vendor IDs, prices, names or credentials. Write nothing until the owner approves each entry; approved entries go to the learnings directory, not to this repository.
+8. Cold-read test: reread the note as a new session with no memory of this one; if the work cannot be picked up cleanly from `memory.md` plus this file, rewrite it.
 Rules: keep notes short and useful — move outdated detail down or remove it, do not let the opener become a diary; do not commit, push or deploy as part of wind-down unless asked.
```

And one line for DoorAlarm `CLAUDE.md`, after the existing "Standing owner routine" line:

```diff
 Standing owner routine: at session start read `memory.md` (root) first; on "wind down session" follow AGENTS.md "Wind-down and session start".
+
+@~/.claude/hardware/workflow.md
```

## Verifying it loaded

- `/context all` lists the memory files loaded at launch; `/memory` lists memory file locations.
- `/doctor prompt-audit` (Claude Code 2.1.283+) covers rules under `~/.claude/`.
- An `InstructionsLoaded` hook logs which CLAUDE.md and rules files loaded and why; `claude --debug` reports a rule's frontmatter parse error (a broken header silently drops `paths:` and the rule would then load in every project).
