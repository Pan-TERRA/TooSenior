# TooSenior
...for toy problems, but I solved them all

## Getting Started

### Prerequisites
- Xcode 14.0+
- macOS 12.0+

### Setup
1. Clone the project
2. Run `make bootstrap` (installs required tools)
3. Open `TooSenior.xcodeproj` in Xcode
4. Build and run (`Cmd+R`)

## Development

### Testing Individual Modules
To test Swift package modules with proper iOS targeting:
```bash
cd Modules/[MODULE_NAME]
xcodebuild test -scheme [MODULE_NAME] -sdk iphonesimulator -destination 'platform=iOS Simulator,name=iPhone SE (3rd generation)'
```

**Note:** Replace the simulator name with any available iOS simulator on your system. Common options include:
- iPhone SE (3rd generation)
- iPhone 15
- iPhone 15 Pro
- iPad Air (5th generation)

Example:
```bash
cd Modules/TooNetworking
xcodebuild test -scheme TooNetworking -sdk iphonesimulator -destination 'platform=iOS Simulator,name=iPhone 15'
```
