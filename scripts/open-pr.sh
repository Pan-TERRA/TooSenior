#!/bin/bash

# TooSenior PR Opener
# Usage: make open-pr [target-branch]

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_status() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

# Check if gh CLI is installed
if ! command -v gh &> /dev/null; then
    print_error "GitHub CLI (gh) is not installed!"
    echo "Install it with: brew install gh"
    echo "Then authenticate with: gh auth login"
    exit 1
fi

# Check if user is authenticated
if ! gh auth status &> /dev/null; then
    print_error "Not authenticated with GitHub!"
    echo "Run: gh auth login"
    exit 1
fi

# Check if we're in a git repository
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    print_error "Not in a git repository!"
    exit 1
fi

# Get target branch (default to main)
TARGET_BRANCH="${1:-main}"

# Validate target branch exists
if ! git show-ref --verify --quiet refs/heads/$TARGET_BRANCH && ! git show-ref --verify --quiet refs/remotes/origin/$TARGET_BRANCH; then
    print_error "Target branch '$TARGET_BRANCH' does not exist!"
    echo "Use 'git branch -a' to see all available branches"
    exit 1
fi

# Check for uncommitted changes
if ! git diff-index --quiet HEAD --; then
    UNCOMMITTED_COUNT=$(git status --porcelain | wc -l | tr -d ' ')
    print_error "You have $UNCOMMITTED_COUNT uncommitted files!"
    echo "Please commit or stash your changes before opening a PR"
    exit 1
fi

# Get current branch
CURRENT_BRANCH=$(git branch --show-current)

# Check if we're not on target branch
if [[ "$CURRENT_BRANCH" == "$TARGET_BRANCH" ]]; then
    print_error "Cannot create PR from $TARGET_BRANCH branch!"
    echo "Create a feature branch first: git checkout -b feature/your-feature"
    exit 1
fi

# Check if branch has commits ahead of remote target branch
COMMITS_AHEAD=$(git rev-list --count origin/$TARGET_BRANCH..$CURRENT_BRANCH 2>/dev/null || echo "0")
if [[ "$COMMITS_AHEAD" == "0" ]]; then
    print_error "No commits found ahead of origin/$TARGET_BRANCH branch!"
    echo "Make some commits first or push your changes."
    exit 1
fi

print_info "Creating PR from branch: $CURRENT_BRANCH → $TARGET_BRANCH"

# Get commit messages for PR description
print_status "Analyzing commits..."

# Get all commit messages since remote target branch
COMMIT_MESSAGES=$(git log origin/$TARGET_BRANCH..$CURRENT_BRANCH --pretty=format:"- %s" | head -10)

# Get current repo info
REPO_INFO=$(gh repo view --json nameWithOwner -q .nameWithOwner)

print_info "Repository: $REPO_INFO"
print_info "Commits ahead: $COMMITS_AHEAD"

# Use last commit message as PR title
PR_TITLE=$(git log -1 --pretty=format:"%s")

# Create PR description
PR_BODY=$(cat <<EOF
## Summary

Describe what your PR is doing...

## Changes Made

$COMMIT_MESSAGES
EOF
)

# Push current branch to remote
print_status "Checking remote branch status..."

# Check if remote branch exists
if git ls-remote --exit-code --heads origin "$CURRENT_BRANCH" >/dev/null 2>&1; then
    print_info "Remote branch exists, checking for conflicts..."
    
    # Fetch latest changes
    git fetch origin "$CURRENT_BRANCH" >/dev/null 2>&1
    
    # Check if we can fast-forward push
    MERGE_BASE=$(git merge-base HEAD origin/"$CURRENT_BRANCH" 2>/dev/null || echo "")
    REMOTE_HEAD=$(git rev-parse origin/"$CURRENT_BRANCH" 2>/dev/null || echo "")
    
    if [[ "$MERGE_BASE" != "$REMOTE_HEAD" ]]; then
        print_error "Cannot push: remote branch has changes you don't have locally!"
        echo "Run 'git pull origin $CURRENT_BRANCH' to sync, then try again"
        exit 1
    fi
    
    print_status "Pushing latest changes..."
    git push origin "$CURRENT_BRANCH"
else
    print_status "Creating new remote branch..."
    git push -u origin "$CURRENT_BRANCH"
fi

# Create PR using gh CLI
print_status "Creating pull request..."

PR_URL=$(gh pr create \
    --title "$PR_TITLE" \
    --body "$PR_BODY" \
    --base "$TARGET_BRANCH" \
    --head "$CURRENT_BRANCH" \
    --web)

if [[ $? -eq 0 ]]; then
    print_status "Pull request created successfully! 🎉"
    print_info "PR URL: $PR_URL"
    print_status "Opening in browser..."
    
    # Open PR in browser (this should happen automatically with --web flag)
    sleep 1
    
    echo ""
    print_info "Next steps:"
    echo "1. Review the PR description and update if needed"
    echo "2. Add reviewers if required"
    echo "3. Check CI/CD status"
    echo "4. Merge when ready! 🚀"
else
    print_error "Failed to create pull request!"
    exit 1
fi