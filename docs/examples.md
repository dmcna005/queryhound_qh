# Examples

## 1) Slow queries only

```bash
qh mongodb.log --slow
```

## 2) COLLSCANs only

```bash
qh mongodb.log --scan
```

## 3) Namespace + minimum duration filter

```bash
qh mongodb.log --namespace app.users --min-ms 50
```

## 4) Percentile stats + CSV export

```bash
qh mongodb.log --pstats --output-csv report.csv
```

## 5) Filter raw lines by keywords (plus summary)

```bash
qh mongodb.log --filter "index" "COLLSCAN"
```

## 6) Connection sources (Remote IP + App)

```bash
qh mongodb.log --connections
```

Verbose (no truncation):

```bash
qh mongodb.log --connections --verbose
```

## 7) Slow queries with full plan summaries

```bash
qh mongodb.log --slow --verbose
```

## 8) Slow COLLSCAN queries with percentile stats

```bash
qh mongodb.log --slow --scan --pstats
```

## 9) Slow queries within a date range

```bash
qh mongodb.log --slow --start-date 2025-09-10 --end-date 2025-09-12
```

With percentile stats + verbose:

```bash
qh mongodb.log --slow --start-date 2025-09-10T00:00:00 --end-date 2025-09-12T23:59:59 --pstats --verbose
```

## 10) Inspect only errors and fatals

```bash
qh mongodb.log --error
```

Show full messages:

```bash
qh mongodb.log --error --verbose
```

## 11) Focus on one percentile

```bash
qh mongodb.log --slow --pvalue P90
```

## 12) Drill into a namespace and export

```bash
qh mongodb.log --scan --namespace sales.orders --output-csv sales_collscan.csv
```

## 13) Combine filter & error mode

```bash
qh mongodb.log --filter "ReplicaSetMonitor" --error
```

## 14) Top 10 distinct queries
```bash
qh mongodb.log --query
```
Show with full details (no truncation):
```bash
qh mongodb.log --query --verbose
```

## 15) Queries for specific namespace
```bash
qh mongodb.log --query --namespace myapp.users
```
