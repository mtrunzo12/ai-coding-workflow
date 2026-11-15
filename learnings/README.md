# Learnings

Lessons from real hardware sessions that should change how the agent works. Each entry is one file; `INDEX.md` lists them; `_template.md` is the shape. Entries change `profiles/hardware/` only through a reviewed PR.

## This fork is public

`mtrunzo12/ai-coding-workflow` is a public fork. Anything committed to this directory is world-readable. Every entry here must be generic: no manufacturer or vendor part numbers, no prices or quotes, no customer, family or personal data, no credentials, no board coordinates or net names that identify a product, no file paths beyond the project's own documents named by role. If a lesson cannot be written that way, it does not belong here.

**Recommendation:** keep raw, project-specific lessons in a separate private repository (for example `ai-workflow-learnings-private`) and point `install.sh` at it with `--learnings-dir <path>` or `LEARNINGS_DIR=<path>`. The agent then writes proposals to `~/.claude/hardware-learnings/`, which is that private checkout. Promote to this public directory only the entries that generalize and survive sanitization. The seed entries below pass that bar because they state a rule and point to a file section, not to data.

## Capture and promote

1. **Capture (wind-down).** The project's wind-down routine includes a "propose learnings" step (see `profiles/hardware/PROJECT-SNIPPET.md`). The agent drafts each entry in chat from `_template.md`: what happened, the rule or check it implies, which workflow file it would change, evidence pointers by file and section only. It writes nothing yet.
2. **Approve.** The owner accepts, edits or drops each entry. Unapproved drafts are discarded, not parked.
3. **Land.** Approved entries are written to the learnings directory (`~/.claude/hardware-learnings/` → private repo if configured, else this directory) as `YYYY-MM-DD-<slug>.md`, and `INDEX.md` gets a row with status `captured`. This is a plain file write; it is committed only when the owner asks.
4. **Promote.** When an entry generalizes, open a PR on this repository that edits the named file under `profiles/hardware/` (workflow, a prompt, the rule) and sets the entry's status to `promoted` with the PR number. The PR body quotes the entry's rule line. Sanitize again at this step if the entry came from the private directory.
5. **Retire.** An entry superseded by a later one gets status `retired` and a pointer; it is not deleted.

Keep entries under 25 lines. One lesson per file. Evidence is "file, section", never a quote of private content.
