# TooSenior Makefile

.PHONY: bootstrap lint-fix create-module open-pr

# Install development tools
bootstrap:
	@echo "🍺 Installing development tools..."
	@command -v swiftlint >/dev/null || (echo "Installing SwiftLint..." && brew install swiftlint)
	@echo "✅ Bootstrap completed"

# Auto-fix SwiftLint issues
lint-fix:
	@echo "🔧 Auto-fixing code style issues..."
	@swiftlint --autocorrect

# Create new module
create-module:
	@./scripts/create-module.sh $(filter-out $@,$(MAKECMDGOALS))

# Open pull request from current branch  
open-pr:
	@./scripts/open-pr.sh $(filter-out $@,$(MAKECMDGOALS))

# Allow any target name for create-module
%:
	@: