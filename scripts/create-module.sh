#!/bin/bash

# TooSenior Module Creator
# Usage: ./scripts/create-module.sh ModuleName

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

# Check if module name is provided
if [ -z "$1" ]; then
    print_error "Module name is required!"
    echo "Usage: make create-module MODULE_NAME"
    echo "Example: make create-module TooNetworking"
    exit 1
fi

MODULE_NAME="$1"
MODULE_DIR="Modules/${MODULE_NAME}"

# Validate module name (PascalCase)
if [[ ! "$MODULE_NAME" =~ ^[A-Z][a-zA-Z0-9]*$ ]]; then
    print_error "Module name must be in PascalCase (e.g., TooNetworking)"
    exit 1
fi

# Check if module already exists
if [ -d "$MODULE_DIR" ]; then
    print_error "Module '$MODULE_NAME' already exists!"
    exit 1
fi

print_status "Creating module: $MODULE_NAME"

# Create module directory structure
mkdir -p "$MODULE_DIR"
mkdir -p "$MODULE_DIR/Sources/$MODULE_NAME/Models"
mkdir -p "$MODULE_DIR/Sources/$MODULE_NAME/ViewModels"
mkdir -p "$MODULE_DIR/Sources/$MODULE_NAME/ViewModifiers"
mkdir -p "$MODULE_DIR/Sources/$MODULE_NAME/Views"
mkdir -p "$MODULE_DIR/Tests/${MODULE_NAME}Tests"

print_status "Created directory structure"

# Create Package.swift
cat > "$MODULE_DIR/Package.swift" << EOF
// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "$MODULE_NAME",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "$MODULE_NAME",
            targets: ["$MODULE_NAME"]
        )
    ],
    targets: [
        .target(
            name: "$MODULE_NAME",
            path: "Sources"
        ),
        .testTarget(
            name: "${MODULE_NAME}Tests",
            dependencies: ["$MODULE_NAME"],
            path: "Tests/${MODULE_NAME}Tests"
        )
    ]
)
EOF

print_status "Created Package.swift"

# Create empty placeholder file
cat > "$MODULE_DIR/Sources/$MODULE_NAME/EmptyFile.swift" << EOF
// Placeholder file for $MODULE_NAME module
// Remove this file when you add your first source file
EOF

print_status "Created placeholder files"

# Create basic test file
cat > "$MODULE_DIR/Tests/${MODULE_NAME}Tests/${MODULE_NAME}Tests.swift" << EOF
import XCTest
@testable import $MODULE_NAME

final class ${MODULE_NAME}Tests: XCTestCase {
    func testExample() throws {
        // Add your tests here
        XCTAssertTrue(true)
    }
}
EOF

print_status "Created test template"

print_status "Module '$MODULE_NAME' created successfully!"
echo ""
print_warning "Next steps:"
echo "1. Add the module to your workspace in Xcode"
echo "2. Remove EmptyFile.swift when you add your first source file"
echo "3. Import the module in your main app: import $MODULE_NAME"