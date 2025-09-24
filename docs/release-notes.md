# Release Notes

## 0.7.0

- Add `-q, --query` mode to show top 10 distinct queries with query shape, execution count, and source information (app name or IP)

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
