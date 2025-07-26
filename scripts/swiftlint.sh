#!/bin/bash

# SwiftLint via Homebrew - Simple Universal Approach
# Usage: Run this script as an Xcode Build Phase

set -e

# Add Homebrew paths for both Intel and Apple Silicon Macs
if [[ "$(uname -m)" == arm64 ]]; then
    export PATH="/opt/homebrew/bin:$PATH"
else
    export PATH="/usr/local/bin:$PATH"
fi

# Check if SwiftLint is available
if command -v swiftlint >/dev/null 2>&1; then
    echo "🔍 Running SwiftLint..."
    swiftlint
    echo "✅ SwiftLint completed successfully"
else
    echo "warning: SwiftLint not installed. Run 'make bootstrap' or 'brew install swiftlint'"
fi