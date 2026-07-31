# .NET local verification reference

How to catch build, test, formatting, and **SonarCloud/Roslynator** problems
**locally, before committing** — so failures never surface first in a slow
pipeline round-trip. Pair this with the "Verify before commit/push" rule in the
global rules.

## The rule

Before every commit/push to a .NET repo, run — and prove green — in this order:

```bash
dotnet restore
dotnet build -warnaserror            # analyzers run during build; treat warnings as errors
dotnet test                          # all affected test projects
dotnet format --verify-no-changes    # style/whitespace/using ordering (fails if it would change files)
```

If any step is red, fix it locally. Never push expecting the pipeline to tell
you what a local build already knows.

- **Use the latest installed .NET SDK/runtime.** Don't pin to an older SDK or
  target framework unless the repo explicitly requires it.
- Run from the directory that owns the `.sln`/`.slnx`/`.csproj`, not a guessed
  path.

## SonarCloud / analyzer parity locally

Pipeline SonarCloud failures (`Sxxxx` rules) are almost always catchable
locally, because the same Roslyn analyzers can run during `dotnet build`. The
reason they "only show up in CI" is that analyzers aren't wired into the local
build — fix that at the repo level, don't work around it.

- **Wire analyzers repo-wide** via `Directory.Build.props` (SonarAnalyzer.CSharp
  / Roslynator packages) and rule severities via `.editorconfig`, so every
  local `dotnet build` enforces the same rules CI does. This is the root-cause
  fix for "we're not catching SonarCloud stuff locally."
- Build with `-warnaserror` (or `TreatWarningsAsErrors` in props) so an analyzer
  warning fails the local build exactly as the gate does.
- To reproduce a specific reported rule, build and grep for the rule id:
  ```bash
  dotnet build 2>&1 | rg 'S[0-9]{3,4}|error|warning'
  ```

### Common Sxxxx gotchas (extend as encountered)

- **S6505** — recurring here. When it fires in CI, reproduce it with the wired
  analyzer locally and fix the code; don't re-push blind hoping it clears.

## Don't skip or fake green

- **Never skip a failing test** to get green (no `[Fact(Skip=...)]`, no
  commenting out) unless the human explicitly agrees.
- Prove results with the actual local build/test output, not assumptions.

## Docker / build-time analyzer failures

If the failure only happens in the Docker/CI build (e.g. a globber including or
excluding the wrong projects), reproduce the *same* build locally rather than
re-queuing the pipeline. Prefer building the full solution and selecting which
project to publish over per-file globbing that drifts from local behaviour.
