# Usage & CLI Options

QueryHound operates on MongoDB JSON structured logs.

```bash
qh [logfile | -] [options]
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
- `-q, --query` — Show top 10 distinct queries with shape, count, and source
- `--verbose` — Disable truncation (Plan / App Name / Query Shape / Error Message)
- `-v, --version` — Show version and exit

## Stream Input (stdin)

QueryHound can read from standard input. This is useful for piping logs from other commands or live streams.

- Use `-` as the logfile to explicitly read from stdin.
- If no logfile is provided and data is piped, QueryHound automatically reads from stdin.
- Works with all modes: `--slow`, `--scan`, `--connections`, `--error`, `--query`.

Examples:

```bash
# Analyze slow queries from a live stream
tail -f /var/log/mongodb/mongod.log | qh - --slow

# Query analysis on compressed logs
zcat mongo.log.gz | qh --query

# Show only errors from systemd journal JSON
journalctl -u mongod -o json | qh --error
```

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

`--error` (alias: `--errors`) filters lines whose severity field `s` is `E` (Error) or `F` (Fatal) and prints a table with rich columns:

- Timestamp, Severity, Component, ID
- Context, Namespace, App Name, Remote
- Message, Attributes (compact JSON of the `attr` object)

Use `--verbose` to disable truncation of long Message/Attributes values.

## Query Mode

`--query` shows the top 10 most frequently executed distinct queries. For each query it displays:

- Query Shape: The query pattern (queryShapeHash if available, or derived signature)
- Count: Number of times this query was executed
- Sources: Application names or IP addresses that executed this query (up to 3 shown)

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
qh mongo.log --query --namespace mydb.users
```
