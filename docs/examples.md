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
