# Claude Instructions for TooSenior Project

## Available Make Commands

**Module Creation**
```bash
make create-module MODULE_NAME
```
Creates new Swift package module with proper structure and updates project.yml

**Pull Request Creation**
```bash
make open-pr [TARGET_BRANCH]
```
Pushes branch and creates GitHub PR with auto-generated description

**Project Generation**
```bash
make generate-project
```
Regenerates Xcode project from project.yml using XcodeGen

## Workflow Instructions

1. **Creating new modules**: Always use `make create-module` instead of manual directory creation
2. **Opening PRs**: Always use `make open-pr` instead of manual GitHub PR creation
3. **Project changes**: Run `make generate-project` after any project.yml modifications
4. **Before commits**: Run `make lint-fix` to auto-fix style issues