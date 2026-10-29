# Neutral input and display repairs

The original manuscript is unchanged. All edits below apply only to this run.

- Removed five identity `\rev{...}` wrappers in the source copy, retaining every enclosed character. Replaced wrapper characters with spaces to preserve line provenance. The macro is defined as an identity, but its long uses prevented balanced segmentation.
- Copied four deeply nested figure PDFs byte for byte to `source/figures/` and updated the corresponding paths. The UI asset discovery has a depth limit; captions, figure content, and dimensions are unchanged.
- Added 210 exact-formula UI overrides, expanding `\norm` to norm bars and `\pdv` to the first partial derivative fraction. These affect display only.
- Bound the shared proof of Lemmas B.20 and B.21 to both results through `discovery/segments.json`; no proof text was added.

See `source_reading_repairs.json` for original locations and checksums.

## First referee checkpoint

The first full pass found all117 nodes mathematically correct; its11 findings concerned extraction faithfulness (canonical identifiers, settings, and construction/proof-reference edges). Resolved these in core_refs.json, preserving all statement/proof source bindings. The original receipt is first_referee_metadata_findings.json.

Recovered the explicitly displayed Bellec (2023), Lemma7.1 covariance input as a cited segment at flat2431–2435, with its exact primary-source statement and source-backed local definitions. The citation detector's48-character proximity window had missed the attribution67 characters away; the detector and manuscript are unchanged.

The UI ignored verified segment titles. Applied a general title fallback requiring an actual anchor and an exact complete segment locator, with citation precedence and regression coverage. No mathematics is changed.

## Regression-suite baseline defects

The first full suite passed2445 tests and failed2, with7 skipped. Both failing paths were reproduced against unchanged HEAD-identical code: macOS AF_UNIX returned ENOTSOCK for an invalid regular-file endpoint, and the crash-cleanup test killed its harness after the child PID was published but before registry persistence. Fixed ENOTSOCK stale-endpoint handling and synchronized that test with registry persistence. Live-daemon timeout/reset behavior and stop semantics are unchanged. Evidence and exact process cleanup are recorded in the scratch daemon-ipc-fix and child-registry-race directories.

Integrated repairs validated: TypeScript typecheck passed; full Vitest suite251/251 files passed,2447 tests passed and7 skipped (2454 total). The restarted UI at the existing token/port displays Trace identity and reports no missing figures, unresolved references, unnamed results, or math failures.

## F1 authentication and approval checkpoint — 2026-10-29T04:31:47.753696+00:00

The first F1 launch stopped before writing a plan: Claude OAuth expired and could not refresh. Doctor passed in the documented Codex-only mode. Automatic approval review rejected launching that fallback because explicit permission for manuscript-derived prompts to this provider is required. No provider change or retry was executed after rejection; user approval is pending. Original main.tex SHA-256 is unchanged: 4f091a5ab05d0e1111ff6e710d49780ac735b9208b635dd160d296852c40403e.

## Codex fallback explicitly authorized — 2026-10-29T15:10:09.735402+00:00

The user explicitly approved continuing PaperFormalizer with Codex, including sending manuscript-derived prompts to OpenAI's Codex service, in the Codex session. Resuming the same verification targets and proof gates using the documented Codex provider mode.
