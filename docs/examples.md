# Examples

## 1) Show slow queries only

```bash
qh mongodb.log --slow
```

## 2) Show COLLSCANs only

```bash
qh mongodb.log --scan
```

## 3) Filter by namespace and minimum duration

```bash
qh mongodb.log --namespace app.users --min-ms 50
```

## 4) Include percentile stats and export CSV

```bash
qh mongodb.log --pstats --output-csv report.csv mongodb.log
```

## 5) Filter lines by keywords

```bash
qh mongodb.log --filter "index" "COLLSCAN"
```

## 6) Show connection sources (top IP + App pairs)

```bash
qh mongodb.log --connections
```

Verbose (no truncation):

```bash
qh mongodb.log --connections --verbose
```

## 7) Slow queries with full, untruncated plan summaries

```bash
qh mongodb.log --slow --verbose
```

## 8) Combined: slow COLLSCAN queries with percentile stats

```bash
qh mongodb.log --slow --scan --pstats
```

## 9) Slow queries within a date range

Show only slow queries between Sept 10 and Sept 12 (UTC assumed if no timezone provided):

```bash
qh mongodb.log --slow --start-date 2025-09-10 --end-date 2025-09-12
```

With percentile stats and verbose (no truncation):

```bash
qh mongodb.log --slow --start-date 2025-09-10T00:00:00 --end-date 2025-09-12T23:59:59 --pstats --verbose
```
