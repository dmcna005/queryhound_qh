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

```bash
qh mongodb.log --filter "index" "COLLSCAN"
```
