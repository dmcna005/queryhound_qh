# Branch Protection Guide

## Recommended GitHub Settings

To enforce the PR workflow, configure branch protection rules for `main`:

### Navigate to Settings
1. Go to repository Settings → Branches → Add rule
2. Branch name pattern: `main`

### Protection Rules

**Required:**
- ✅ Require a pull request before merging
  - Require approvals: 1 (or more for team projects)
  - Dismiss stale PR approvals when new commits are pushed
- ✅ Require status checks to pass before merging
  - Required checks:
    - `test` (from ci.yml)
    - `build-deploy` (from mkdocs-deploy.yml for doc changes)
- ✅ Do not allow bypassing the above settings

**Recommended:**
- ✅ Require conversation resolution before merging
- ✅ Require linear history (optional - enforces rebase/squash merges)
- ✅ Include administrators (applies rules to admins too)

**Optional:**
- Require deployments to succeed before merging
- Lock branch (prevents all pushes - use only for archived repos)

## Workflow Summary

```
feature/bug branch → PR → CI checks → Review → Merge → Deploy
     ↓                ↓        ↓          ↓        ↓       ↓
   Create         Template  Tests     Approve   main    Docs
   branch          Auto    + Docs              Updated Published
                  filled   Build                         
```

## Commands Quick Reference

```bash
# Start new feature
git checkout main && git pull origin main
git checkout -b feat/new-feature

# Work and commit
git add .
git commit -m "feat: add new feature"
git push origin feat/new-feature

# Create PR (after push)
gh pr create --fill  # Auto-fills from commits

# After PR approval - merge via GitHub UI
# Then update local main
git checkout main
git pull origin main
git branch -d feat/new-feature  # Clean up local branch

# For releases
git checkout main && git pull origin main
git checkout -b release/x.y.z
# Update version, docs, etc.
git push origin release/x.y.z
gh pr create --title "Release x.y.z" --body "Release notes..."
```

## Automated Workflows

- **ci.yml**: Runs tests on all PRs and feature branches
- **mkdocs-deploy.yml**: 
  - Validates docs build on PRs
  - Deploys to gh-pages only on merge to main
- **gh-pages-publish.yml**: Publishes GitHub Pages site
- **release-manual.yml**: Creates GitHub releases (manual trigger)

## Benefits

✅ All changes are reviewed before merging  
✅ Tests run automatically on PRs  
✅ Documentation validates before deployment  
✅ Clean git history  
✅ No accidental direct pushes to main  
✅ Automatic deployments on merge  
