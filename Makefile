# TooSenior Makefile

.PHONY: bootstrap lint-fix create-module open-pr generate-project

# Install development tools
bootstrap:
	@echo "🍺 Installing development tools..."
	@command -v swiftlint >/dev/null || (echo "Installing SwiftLint..." && brew install swiftlint)
	@command -v xcodegen >/dev/null || (echo "Installing XcodeGen..." && brew install xcodegen)
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

# Generate Xcode project from project.yml
generate-project:
	@echo "🏗️  Generating Xcode project..."
	@xcodegen generate
	@echo "✅ Project generated successfully!"

# Allow any target name for create-module
%:
	@: