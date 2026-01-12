# Contributing to QueryHound

Thank you for your interest in contributing to QueryHound! 🐾

## Development Setup

1. Clone the repository:
   ```bash
   git clone https://github.com/dmcna005/queryhound_qh.git
   cd queryhound_qh
   ```

2. Create a virtual environment:
   ```bash
   python -m venv queryhound-dev
   source queryhound-dev/bin/activate  # On Windows: queryhound-dev\Scripts\activate
   ```

3. Install in development mode:
   ```bash
   pip install -e .
   ```

## Making Changes

1. Create a feature branch:
   ```bash
   git checkout -b feat/your-feature-name
   ```

2. Make your changes and commit with descriptive messages:
   ```bash
   git commit -m "feat: add new feature"
   ```

3. Push your branch and create a pull request:
   ```bash
   git push origin feat/your-feature-name
   gh pr create --base main --head feat/your-feature-name
   ```

## Release Process

We use semantic versioning (MAJOR.MINOR.PATCH) and ensure every release is properly tagged.

### Automated Release (Recommended)

Use the release script to handle version bumping and tagging:

```bash
./scripts/release.sh
```

This script will:
- Check you're on the main branch
- Show current version
- Prompt for new version number
- Update `queryhound/__init__.py`
- Create an annotated git tag (e.g., `v0.7.4`)
- Push the tag and commits to GitHub

### Manual Release

If you prefer to do it manually:

1. **Update version** in `queryhound/__init__.py`:
   ```python
   __version__ = "0.7.5"
   ```

2. **Commit the version bump**:
   ```bash
   git add queryhound/__init__.py
   git commit -m "chore(release): bump version to 0.7.5"
   ```

3. **Create and push the tag**:
   ```bash
   git tag -a v0.7.5 -m "Release v0.7.5"
   git push origin main
   git push origin v0.7.5
   ```

### Automated GitHub Release

When you push changes to `queryhound/__init__.py` on the main branch, our GitHub Actions workflow will automatically:
- Detect the version change
- Create a git tag (if it doesn't exist)
- Create a GitHub Release

## Commit Message Convention

We follow conventional commits for clear changelog generation:

- `feat:` - New features
- `fix:` - Bug fixes
- `docs:` - Documentation changes
- `chore:` - Maintenance tasks (version bumps, dependencies)
- `test:` - Adding or updating tests
- `refactor:` - Code refactoring

Examples:
```
feat(cli): add --errors alias for error flag
fix: handle empty log files gracefully
docs: update stdin examples in README
chore(release): bump version to 0.7.4
```

## Testing

Before submitting a PR:

1. Test your changes manually:
   ```bash
   qh test.txt --slow
   ```

2. Run the test suite:
   ```bash
   pytest
   ```

## Documentation

If you're adding new features:

1. Update relevant docs in `docs/` directory
2. Rebuild the documentation site:
   ```bash
   mkdocs build
   ```

3. Test locally:
   ```bash
   mkdocs serve
   ```

## Questions?

Open an issue or reach out to the maintainers. Happy hounding! 🐾
