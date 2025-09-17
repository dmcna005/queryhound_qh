# Getting Started

## Install

```bash
pip install -U queryhound
```

If `qh` isn’t found after install, open a new terminal. QueryHound attempts to add your user scripts directory to PATH automatically on first run (opt‑out with `QUERYHOUND_SKIP_PATH_UPDATE=1`).

## Quick check

```bash
qh --version
qh --help
```

## First exploration

Show slow queries with extended stats:

```bash
qh mongo.log --slow --pstats
```

List connection sources:

```bash
qh mongo.log --connections
```

Show only errors / fatals:

```bash
qh mongo.log --error
```
