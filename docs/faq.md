# FAQ

## Why doesn’t `qh` run right after install?

Open a new terminal to pick up PATH changes. QueryHound also attempts a best-effort PATH update on first run.

## Does QueryHound modify my shell profile?

If the user scripts dir isn’t on PATH, it appends an export line to `~/.zprofile` (or falls back to `~/.zshrc`). Opt-out with `QUERYHOUND_SKIP_PATH_UPDATE=1`.

## What log format is supported?

MongoDB JSON structured logs.
