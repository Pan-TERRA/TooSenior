# TooSenior Makefile

.PHONY: bootstrap lint-fix

# Install development tools
bootstrap:
	@echo "🍺 Installing development tools..."
	@command -v swiftlint >/dev/null || (echo "Installing SwiftLint..." && brew install swiftlint)
	@echo "✅ Bootstrap completed"

# Auto-fix SwiftLint issues
lint-fix:
	@echo "🔧 Auto-fixing code style issues..."
	@swiftlint --autocorrect