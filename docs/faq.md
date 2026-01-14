# FAQ

## Why doesn’t `qh` run right after install?

Open a new terminal to pick up PATH changes. QueryHound also attempts a best-effort PATH update on first run.

## Does QueryHound modify my shell profile?

If the user scripts dir isn’t on PATH, it appends an export line to `~/.zprofile` (or falls back to `~/.zshrc`). Opt-out with `QUERYHOUND_SKIP_PATH_UPDATE=1`.

## What log format is supported?

MongoDB JSON structured logs.

## How is Query Shape determined?

Priority: existing `queryShapeHash` / `queryShapeId`; else a derived concise signature from the command body or pipeline.

## Why are some fields truncated?

To keep tables readable. Use `--verbose` to disable truncation.

## Will `--output-csv` include error or connection tables?

No, it only exports the slow / scan summary table.

## How do I only see fatal issues?

Use `--error` (it shows Error `E` and Fatal `F`). To focus only on fatals, filter the output by severity `F`.

## How do I only see warnings?

Use `--warn` to show Warning severity (`W`) entries. Combine `--error --warn` to include all W/E/F severities in one view.
