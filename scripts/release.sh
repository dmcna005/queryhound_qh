#!/bin/bash
# Release script to ensure version is bumped and tagged properly

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}QueryHound Release Script${NC}"
echo "================================"

# Check if we're on main branch
CURRENT_BRANCH=$(git branch --show-current)
if [ "$CURRENT_BRANCH" != "main" ]; then
    echo -e "${YELLOW}Warning: Not on main branch (currently on: $CURRENT_BRANCH)${NC}"
    read -p "Continue anyway? (y/N) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

# Get current version
CURRENT_VERSION=$(grep "__version__" queryhound/__init__.py | cut -d\" -f2)
echo -e "Current version: ${YELLOW}$CURRENT_VERSION${NC}"

# Prompt for new version
read -p "Enter new version number (or press Enter to keep current): " NEW_VERSION
if [ -z "$NEW_VERSION" ]; then
    NEW_VERSION=$CURRENT_VERSION
    echo -e "Using current version: ${GREEN}$NEW_VERSION${NC}"
else
    echo -e "New version will be: ${GREEN}$NEW_VERSION${NC}"
    
    # Update version in __init__.py
    sed -i.bak "s/__version__ = \".*\"/__version__ = \"$NEW_VERSION\"/" queryhound/__init__.py
    rm queryhound/__init__.py.bak 2>/dev/null || true
    
    # Commit version bump
    git add queryhound/__init__.py
    git commit -m "chore(release): bump version to $NEW_VERSION"
fi

# Create tag
TAG="v$NEW_VERSION"
echo -e "\nCreating tag: ${GREEN}$TAG${NC}"

# Check if tag already exists
if git rev-parse "$TAG" >/dev/null 2>&1; then
    echo -e "${RED}Error: Tag $TAG already exists!${NC}"
    exit 1
fi

# Create annotated tag
git tag -a "$TAG" -m "Release $TAG"

echo -e "\n${GREEN}✓${NC} Tag $TAG created successfully"

# Ask to push
read -p "Push tag and commits to origin? (y/N) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    git push origin HEAD
    git push origin "$TAG"
    echo -e "${GREEN}✓${NC} Tag and commits pushed to origin"
    echo -e "\nRelease tag ${GREEN}$TAG${NC} is now available!"
else
    echo -e "${YELLOW}Not pushed. Run these commands manually:${NC}"
    echo "  git push origin HEAD"
    echo "  git push origin $TAG"
fi

echo -e "\n${GREEN}Release process complete!${NC}"
