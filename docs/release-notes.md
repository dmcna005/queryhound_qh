# Release Notes

## Version 0.8.0 (Latest)

**Release Date:** January 14, 2026

### Enhancements

- Expanded `--error` output with richer columns matching operational dashboards:
  - Context, Namespace, App Name, Remote, plus compact `Attributes` JSON
- Added `--errors` as an alias for `--error`
- Added `--warn` to surface Warning (`W`) severity entries; can be combined with `--error` to include all W/E/F
- `--slow [N]` now accepts an optional threshold value. Using `--slow` defaults to 100ms; `--slow 250` sets 250ms.
- **Enhanced Query Analysis (`--query/-q`)**: Major improvements to query shape extraction
  - Now correctly filters for COMMAND entries only (`c: "COMMAND"`)
  - Properly extracts query shapes from `attr.command.aggregate` and `attr.command.find`
  - Shows detailed filter field names (e.g., `find:filter:status,age:sort:created`)
  - Displays actual pipeline stages (e.g., `aggregate:pipeline:[$match,$group,$sort]`)
- Documentation updates reflecting the new error output
- Rebuilt site to include updated Usage and Examples

### Examples

```bash
journalctl -u mongod -o json | qh --errors --verbose

# Show warnings
qh mongo.log --warn

# Combine warnings with errors/fatals
qh mongo.log --error --warn

# Slow threshold set to 250ms
qh mongo.log --slow 250

# Now shows detailed query shapes like:
# find:filter:status,age:sort:created
# aggregate:pipeline:[$match,$group,$sort]
qh --query /var/log/mongodb/mongod.log
```

---

## Version 0.7.3

**Release Date:** December 23, 2025

### New Features

- Accepts `-` as the logfile to read from standard input.
- If no logfile is provided and data is piped, QueryHound automatically reads from stdin.
- Works across all modes: `--slow`, `--scan`, `--connections`, `--error`, and `--query`.

### Examples

```bash
# Pipe a live stream and analyze slow queries
tail -f /var/log/mongodb/mongod.log | qh - --slow

# Pipe compressed logs to query analysis
zcat mongo.log.gz | qh --query

# Pipe systemd journal JSON logs and show only errors
journalctl -u mongod -o json | qh --error
```

### Notes

## Version 0.8.0 (Latest)

**Release Date:** January 14, 2026

### Enhancements

- Expanded `--error` output with richer columns matching operational dashboards:
  - Context, Namespace, App Name, Remote, plus compact `Attributes` JSON
- Added `--errors` as an alias for `--error`
- Added `--warn` to surface Warning (`W`) severity entries; can be combined with `--error` to include all W/E/F
 - `--slow [N]` now accepts an optional threshold value. Using `--slow` defaults to 100ms; `--slow 250` sets 250ms.
- Documentation updates reflecting the new error output
- Rebuilt site to include updated Usage and Examples

### Bug Fixes

### Examples

```bash
journalctl -u mongod -o json | qh --errors --verbose

# Show warnings
qh mongo.log --warn

# Combine warnings with errors/fatals
qh mongo.log --error --warn

# Slow threshold set to 250ms
qh mongo.log --slow 250
```

- **Enhanced Query Analysis (`--query/-q`)**: Major improvements to query shape extraction

## Version 0.7.3

- Now correctly filters for COMMAND entries only (`c: "COMMAND"`)
  **Release Date:** September 24, 2025
- Properly extracts query shapes from `attr.command.aggregate` and `attr.command.find`

### Enhancements

- Shows detailed filter field names (e.g., `find:filter:status,age:sort:created`)
- Added `stdin` support: read from `-` or auto-detect piped input when no logfile is provided
- Documentation updates:
  - Usage: new “Stream Input (stdin)” section
  - Examples: piping/streaming examples
  - README: quick stdin examples
- Rebuilt site assets
  - Displays actual pipeline stages (e.g., `aggregate:pipeline:[$match,$group,$sort]`)
  - Provides much more meaningful and actionable query analysis results

### Technical Improvements

- Added `_extract_command_query_shape()` function for proper MongoDB command parsing
- Enhanced filtering to focus on aggregate and find operations specifically

### Bug Fixes

- Better pipeline stage extraction for aggregation queries

### Examples

```bash
# Now shows detailed query shapes like:
# find:filter:status,age:sort:created
# aggregate:pipeline:[$match,$group,$sort]
queryhound --query /var/log/mongodb/mongod.log
```

## Version 0.7.1

**Release Date:** September 24, 2025

### Bug Fixes

- **Improved Error Handling**: Fixed user experience issues with file-related errors
  - Replaced technical stack traces with user-friendly error messages
  - Added proper file validation for all processing modes
  - Enhanced error messages for file not found and permission denied cases
  - Improved overall tool reliability and user experience

### Technical Improvements

- Added `_validate_logfile()` helper function for consistent file validation
- Wrapped all file operations in proper exception handling
- Added graceful handling for interrupted operations (Ctrl+C)

## Version 0.7.0

**Release Date:** September 24, 2025

### New Features

- **Query Analysis Mode (`--query/-q`)**: New mode to analyze the top 10 distinct queries in MongoDB logs
  - Shows query shape, execution count, and source information (app name or IP address)
  - Provides insights into the most frequently executed queries
  - Helps identify query patterns and their origins

### Enhancements

- Added comprehensive query shape extraction and aggregation
- Improved source tracking to show application names or IP addresses
- Enhanced tabular output formatting for query analysis results

### Examples

```bash
# Analyze top queries
queryhound --query /var/log/mongodb/mongod.log

# Analyze queries within date range
queryhound --query /var/log/mongodb/mongod.log --start-date "2024-07-01" --end-date "2024-07-31"
```

## 0.6.0

- Add `--error` mode to list severity Error/Fatal (E/F) entries with truncated messages (use `--verbose` for full)

## 0.5.0

- Derive operation from `attr.type` when present
- Add Query Shape column (uses `queryShapeHash` or derived from command object)
- Truncation improvements for new column

## 0.4.0

- Add `--connections` mode aggregating connection events by remote IP and app name
- Truncate long plan / app fields for `--slow` / `--scan` tables
- Add `--verbose` flag to show full untruncated values

## 0.3.0

- Add `-v/--version`
- Auto PATH update helper

## 0.2.0

- Packaging and CI improvements

## 0.1.x

- Initial release
