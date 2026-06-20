---
name: kickoff
description: Turn a vague or multi-step request into an agreed spec BEFORE building anything. Use at the start of any non-trivial task — uncover the real goal, decompose into small steps, define done-criteria, and get approval before producing artifacts. Prevents the "vending machine" failure mode where assumptions get baked into the wrong output.
---

# Kickoff — spec a task before building it

You run this at the **start** of a task to make sure you are solving the right
problem. The deliverable of this skill is a **confirmed spec**, not code. You do
**not** write files, run commands, or otherwise produce artifacts until the user
has approved the spec.

> **You can outsource thinking, but you can't outsource understanding.**
> The user holds the goal. Your job is to *extract* it, not invent it. When you
> fill a gap with an assumption to keep moving, that is the failure mode this
> skill exists to prevent.

## When to run this

- Any **ambiguous** request — one that could lead to meaningfully different
  outcomes depending on interpretation.
- Any **multi-step** task — more than a single obvious edit.
- Whenever the user says "build something", "help me with X", or hands you a
  goal without a spec.

Skip it only for genuinely trivial, unambiguous work (a typo fix, a one-line
change, a direct factual question).

## Workflow

### 1. Uncover the actual goal

Dig beneath the literal request. Ask *why* until the real intent is clear — the
surface task is often a proxy for something the user actually wants. Treat each
answer as a thread to pull, not a box to tick.

- Do **not** produce artifacts, drafts, tables, or designs in this step.
  Jumping to solution-mode before you understand is the mistake.
- Prefer a small number of sharp questions over a flood. The structured
  question tool is good for this.
- The signal that you understand: you can state the goal in one sentence that
  the user would not correct.

### 2. Restate the spec back for approval

Once the goal is clear, restate it as a short spec containing exactly:

- **Real goal** — what the user actually wants, in their terms, *not* the
  literal ask.
- **Decomposition** — small, independently-verifiable steps. Recommend the
  smallest valuable first slice so the first Spec→build→check loop is tight.
- **Done-criteria** — how *both of you* will know it worked. This is the
  verifier hook: every spec carries its own evaluation criteria up front, so
  "done" is defined before work starts rather than argued after.

Keep it scannable. The spec is a contract, not an essay.

### 3. Get explicit approval before building

No edits, commands, or other side effects until the user confirms the spec.
If a plan-mode / ExitPlanMode gate is available, use it. Otherwise ask plainly
and wait.

### 4. Keep the spec critically reviewable

Invite the user to challenge the spec. Treat pushback ("you're at the wrong
level", "that's not what I meant") as the **signal that understanding is still
incomplete** — go back to step 1, don't defend the draft. The spec improves by
the user correcting it, which is why it must be restated, not assumed.

## Rules

- **Understanding before artifacts.** No code, files, or designs until step 3 is
  passed.
- **Extract, don't invent.** Never substitute an assumption for a question on
  anything that changes the outcome.
- **Smallest valuable slice first.** Decompose; don't build the whole thing in
  one pass.
- **Done-criteria are mandatory.** A spec without a way to verify it is
  incomplete.
- **Pushback resets understanding.** When corrected on intent, return to step 1.

## Error prevention

- *Producing a polished plan after one vague sentence* — that is solution-mode
  skipping understanding. Stop and ask first.
- *Asking endless questions* — over-questioning is also a failure. Once you can
  state the goal in one uncorrectable sentence, move to the spec.
- *Treating "yes, build it" as the only gate* — confirm the **spec** (goal +
  steps + done-criteria), not merely permission to start.
- *Silently widening scope mid-task* — if the work grows beyond the agreed spec,
  re-spec the new part; don't absorb it on assumption.
