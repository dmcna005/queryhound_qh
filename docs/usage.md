# Usage & CLI Options

QueryHound operates on MongoDB JSON structured logs.

```bash
qh <logfile> [options]
```

## Options

- `--scan` — Only show COLLSCAN queries (plan & shape truncated by default)
- `--slow` — Only show slow queries (ms >= 100) (plan & shape truncated by default)
- `--start-date <ISO>` — Start date (ISO 8601 or YYYY-MM-DD)
- `--end-date <ISO>` — End date (ISO 8601 or YYYY-MM-DD)
- `--namespace <db.collection>` — Filter by namespace
- `--min-ms <int>` — Minimum duration (ms)
- `--pstats` — Include P75, P90, P99 stats
- `--pvalue <P50|P75|P90|P99>` — Include a specific percentile
- `--output-csv <path>` — Write output to CSV (slow / scan summary tables only)
- `--filter <str ...>` — Show lines containing any provided strings (also prints matching raw lines)
- `--connections` — Aggregate connection accepted events by Remote IP + App Name
- `--error` — Show only Error / Fatal severity log lines (`s` in {E,F})
- `--verbose` — Disable truncation (Plan / App Name / Query Shape / Error Message)
- `-v, --version` — Show version and exit

## Truncation Behavior

For readability, very long fields are truncated when using: `--slow`, `--scan`, `--connections`, or `--error`.
Truncated fields: Plan, App Name, Query Shape, Error Message. Use `--verbose` to show full values.

## Percentiles

- When `--pvalue` is `P50`, the median (P50) column is added.
- When `--pstats` is set, P75, P90, P99 columns are appended.

## Query Shape Column

Appears in slow / scan summaries. Resolution priority:

1. Use `queryShapeHash` / `queryShapeId` if present.
2. Else derive from the command object: main verb (`find`, `aggregate`, `count` …) + concise signature (e.g. filter keys or first pipeline stages).

Purpose: cluster similar logical operations without dumping full query bodies.

## Connections Mode

`--connections` groups connection-accepted events by Remote IP + App Name. App name is extracted from any of: `appName`, `applicationName`, `client.application.name`.

## Error Mode

`--error` filters lines whose severity field `s` is `E` (Error) or `F` (Fatal) and prints a table of: Timestamp, Severity, Component, ID, Message (truncated unless `--verbose`).

## CSV Output

`--output-csv` exports only the tabular slow/scan summary (not raw filtered lines or connections/errors output).

## Combining Flags

Common combos:

```bash
qh mongo.log --slow --pstats
qh mongo.log --scan --pvalue P90
qh mongo.log --slow --namespace sales.orders --min-ms 250
qh mongo.log --slow --start-date 2025-09-15 --end-date 2025-09-16 --pvalue P50
qh mongo.log --error --verbose
```
