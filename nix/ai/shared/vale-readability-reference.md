# Vale readability and controlled-language research

## Status

- Research date: 2026-08-13.
- State: Research complete. No active Nix configuration exists.
- Goal: Test English and Norwegian prose checks with Vale and Nix.
- Next result: A small, pinned Vale trial with measured false positives.

## Main findings

- Nix can provide Vale, proselint, write-good, LanguageTool, and textstat.
- The official Vale registry contains 16 packages.
- The official registry has no Norwegian package.
- The official Readability package includes LIX.
- SuperOffice has a working Bokmal spelling rule and `nb_NO` dictionary.
- Coop Norge has a maintained Vale package with company vocabularies.
- No general Bokmal or Nynorsk klarsprak rule set was found.
- A community package has useful STE-inspired rules. It does not prove ASD-STE100 compliance.

## Nix package check

None of these commands was on `PATH` before the test.

| Tool | Nix attribute | Version | Result |
| --- | --- | ---: | --- |
| Vale | `vale` | 3.17.0 | Works on Apple silicon. |
| textstat | `python3Packages.textstat` | 0.7.13 | Works as a Python library. It has no command in this package. |
| proselint | `proselint` | 0.16.0 | Works on Apple silicon. |
| write-good | `write-good` | 1.0.8 | Works on Apple silicon. |
| LanguageTool | `languagetool` | 6.6 | Works. It downloads about 270 MB. |
| `alex` | `alex` | 3.5.4.2 | Wrong tool. This package is a Haskell lexer generator. |

Use these one-shot commands:

```bash
nix shell nixpkgs#vale -c vale --version
nix shell nixpkgs#proselint -c proselint version
nix shell nixpkgs#write-good -c write-good --version
nix shell nixpkgs#languagetool -c languagetool-commandline --help
```

Use a composed Python environment for textstat:

```bash
nix shell --impure --expr \
  'with import <nixpkgs> {}; python3.withPackages (ps: [ ps.textstat ])' \
  -c python3 -c \
  "import textstat; print(textstat.flesch_reading_ease('This is a short sentence.'))"
```

Do not add packages directly to a machine profile. Add approved packages through this Nix repository.

## Official Vale package registry

Sources:

- [Vale Package Explorer](https://vale.sh/explorer)
- [Vale package registry](https://github.com/vale-cli/packages)
- [Vale package documentation](https://docs.vale.sh/keys/packages.md)

The official registry contains these packages:

| Package | Purpose |
| --- | --- |
| `AsciiDoc` | Selected AsciiDoc syntax rules. |
| `Elastic` | Elastic documentation style. |
| `Google` | Google developer documentation style. |
| `Hugo` | Hugo markup configuration. |
| `Joblint` | Language checks for technical job posts. |
| `MDX` | MDX markup configuration. |
| `Microsoft` | Microsoft writing style. |
| `NoAnimalViolence` | Plain-language alternatives for selected phrases. |
| `OpenShiftAsciiDoc` | Selected OpenShift AsciiDoc rules. |
| `Readability` | Seven readability metrics. |
| `RedHat` | Red Hat documentation style. |
| `Salesforce` | Salesforce writing style. |
| `alex` | Inclusive-language checks. |
| `neighbor` | Accessibility and inclusive-language checks. |
| `proselint` | General prose checks. |
| `write-good` | Simple English prose checks. |

Named packages install their latest release. A new package release can change CI results. Pin each package to a release URL before enforcement.

## Readability package

Source: [vale-cli/Readability](https://github.com/vale-cli/Readability)

The MIT-licensed package contains these rules:

- Automated Readability Index.
- Coleman-Liau.
- Flesch-Kincaid.
- Flesch Reading Ease.
- Gunning Fog.
- LIX.
- SMOG.

The LIX rule uses this formula:

```text
(words / sentences) + ((long_words * 100) / words)
```

Its default warning limit is 35. The Flesch Reading Ease rule warns below 70.

LIX is the best first metric for Norwegian text. It uses sentence length and long-word frequency. Norwegian compound words can increase the score. Calibrate the limit with real project documents before CI enforcement.

Flesch and related metrics depend on syllable counts and English calibration. Do not use their default limits as Norwegian quality gates.

## Norwegian support

### Bokmal spelling

Source: [SuperOfficeDocs/docs](https://github.com/SuperOfficeDocs/docs)

SuperOffice uses this Vale rule for its `no/**` documentation:

```yaml
extends: spelling
message: "Did you really mean '%s'?"
level: error
dictionaries:
  - nb_NO
```

Relevant files:

- [`vale/NB/Spelling.yml`](https://github.com/SuperOfficeDocs/docs/blob/main/vale/NB/Spelling.yml)
- [`vale/config/dictionaries/nb_NO.aff`](https://github.com/SuperOfficeDocs/docs/blob/main/vale/config/dictionaries/nb_NO.aff)
- [`vale/config/dictionaries/nb_NO.dic`](https://github.com/SuperOfficeDocs/docs/blob/main/vale/config/dictionaries/nb_NO.dic)
- [`.vale.ini`](https://github.com/SuperOfficeDocs/docs/blob/main/.vale.ini)

The dictionary comes from `wooorm/dictionaries`. The dictionary files use GPL-2.0. Check licence requirements before copying them into this repository.

This implementation checks spelling only. It does not check grammar, LIX, terminology, or klarsprak.

### Coop Norge package

Source: [coopnorge/vale-coop](https://github.com/coopnorge/vale-coop)

The package is MIT licensed and actively maintained. Release `v0.279.0` was current during this research.

It contains Coop vocabularies for:

- Abbreviations.
- Company names.
- General technical words.
- Locations.
- Systems.
- Technical terms.
- Preferred terms.

The package accepts terms such as `ClickOps`, `DevOps`, `GitOps`, and `MLOps`. Most entries are English technical terms. The package does not implement Norwegian spelling, grammar, LIX, or klarsprak rules.

### Search result

No reusable general package was found for:

- Norwegian klarsprak.
- Nynorsk spelling or language style.
- Norwegian grammar.
- Norwegian public-sector terminology.

One Bokmal implementation was found. It is the SuperOffice spelling rule above.

## STE-inspired community rules

Source: [Syntaf/vale-llm-slop](https://github.com/Syntaf/vale-llm-slop)

This MIT-licensed community package has an optional `STE` style. It checks:

- Descriptive sentence length of 25 words.
- Procedural sentence length of 20 words.
- Paragraph length.
- Articles.
- Gerunds.
- Passive voice.
- Noun clusters.
- Ambiguous terms.
- Modals.
- Contractions.
- One instruction per sentence.
- Plain-English word substitutions.

The package is inspired by ASD-STE100. It is not affiliated with or endorsed by ASD. It does not include the copyrighted ASD approved-word dictionary. Its dictionary rule contains general plain-English substitutions only.

Use these rules as prompts for review. Do not claim ASD-STE100 compliance from their results.

## Proposed trial

Start with a non-blocking trial on selected Markdown files.

Use these checks for English:

- `Microsoft` for technical writing conventions.
- `Readability.LIX` for a simple readability signal.
- Selected `STE` rules for sentence length, passive voice, contractions, noun clusters, and one instruction per sentence.
- A local IMDi vocabulary for approved names, abbreviations, and technical terms.

Use these checks for Bokmal:

- `Readability.LIX` with a calibrated limit.
- The `nb_NO` spelling rule after a licence review.
- A local IMDi Bokmal vocabulary.
- Custom klarsprak rules based on approved Norwegian guidance.

Do not apply English terminology or grammar rules to Norwegian paths.

## Suggested experiment

1. Select 10 English and 10 Norwegian pages.
2. Record their current LIX values.
3. Run each rule set at `suggestion` or `warning` level.
4. Classify each alert as useful, noisy, or wrong.
5. Tune scopes and limits.
6. Add project vocabulary.
7. Run the trial again.
8. Enable only rules with an acceptable false-positive rate.
9. Keep readability scores informational until the team approves a limit.

Measure at least these values:

| Measure | Purpose |
| --- | --- |
| Alerts per 1,000 words | Compare rule noise across documents. |
| Useful alert rate | Measure reviewer value. |
| False-positive rate | Decide if a rule can block CI. |
| LIX distribution | Select an evidence-based project limit. |
| Rule suppression count | Find rules that need better scope. |

## Open decisions

- Decide whether the first trial covers English only or both languages.
- Select the document sample.
- Decide whether GPL-2.0 dictionary files can be stored in this repository.
- Select and pin package versions.
- Define the IMDi vocabulary owner.
- Select the Norwegian klarsprak source that custom rules will implement.
- Decide which alerts can block CI.
- Decide whether LanguageTool adds enough value for its package size.

## Implementation outline

Do not implement this outline until the trial scope is approved.

1. Add Vale to the correct shared package list in this Nix repository.
2. Add a pinned `.vale.ini` and local style directory.
3. Add the selected external packages by pinned release URL.
4. Add an IMDi vocabulary with accepted and rejected terms.
5. Add a script that runs Vale on selected paths.
6. Add a readability report command.
7. Add fixtures for valid and invalid English and Bokmal text.
8. Add a local check.
9. Add non-blocking CI.
10. Record trial results in this document.

## Resume prompt

```text
Resume the Vale readability trial from `ai/shared/vale-readability-reference.md` in `~/git/github/setup/nix`. Read the document and inspect the current Nix configuration before editing. Confirm the trial language and document sample. Then implement the smallest pinned, non-blocking Vale trial. Use Nix only. Add tests and report false positives. Do not claim ASD-STE100 compliance.
```
