# Usage & CLI Options

QueryHound operates on MongoDB JSON logs.

```bash
qh <logfile> [options]
```

## Options

- `--scan` — Only show COLLSCAN queries
- `--slow` — Only show slow queries (ms >= 100)
- `--start-date <ISO>` — Start date (ISO 8601 or YYYY-MM-DD)
- `--end-date <ISO>` — End date (ISO 8601 or YYYY-MM-DD)
- `--namespace <db.collection>` — Filter by namespace
- `--min-ms <int>` — Minimum duration (ms)
- `--pstats` — Include P75, P90, P99 stats
- `--pvalue <P50|P75|P90|P99>` — Include a specific percentile
- `--output-csv <path>` — Write output to CSV
- `--filter <str ...>` — Show lines containing any provided strings
- `--connections` — Displays connection count
- `-v, --version` — Show version and exit

Notes:
- When `--pvalue` is `P50`, the median column is added.
- When `--pstats` is set, P75/P90/P99 columns are included.

