# Usage & CLI Options

QueryHound operates on MongoDB JSON logs.

```bash
qh <logfile> [options]
```

## Options

- `--scan` — Only show COLLSCAN queries (table fields truncated by default)
- `--slow` — Only show slow queries (ms >= 100) (table fields truncated by default)
- `--start-date <ISO>` — Start date (ISO 8601 or YYYY-MM-DD)
- `--end-date <ISO>` — End date (ISO 8601 or YYYY-MM-DD)
- `--namespace <db.collection>` — Filter by namespace
- `--min-ms <int>` — Minimum duration (ms)
- `--pstats` — Include P75, P90, P99 stats
- `--pvalue <P50|P75|P90|P99>` — Include a specific percentile
- `--output-csv <path>` — Write output to CSV
- `--filter <str ...>` — Show lines containing any provided strings (also captures raw lines)
- `--connections` — Aggregate connection accepted events by Remote IP + App Name
- `--verbose` — Disable truncation (show full Plan / App Name values)
- `-v, --version` — Show version and exit

### Truncation Behavior

For readability, very long Plan summaries and App Names are truncated when using `--slow` or `--scan` (and in `--connections` output). Use `--verbose` to see full strings.

### Percentiles

- When `--pvalue` is `P50`, the median column is added.
- When `--pstats` is set, P75/P90/P99 columns are included.

### Connections Mode

`--connections` scans the log for lines indicating a connection acceptance and groups them by the remote IP and application name detected in the entry. The App Name is extracted from multiple possible fields (e.g. `appName`, `applicationName`, `client.application.name`).
