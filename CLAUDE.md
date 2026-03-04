# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

StepUp is a native iOS application built with SwiftUI and SwiftData for data persistence. Currently a basic template app demonstrating CRUD operations with a timestamp-based Item model.

## Tech Stack

- **Language**: Swift 5.0
- **UI Framework**: SwiftUI
- **Data Persistence**: SwiftData
- **Testing**: Swift Testing framework (unit), XCTest (UI)
- **Build System**: Xcode
- **Minimum iOS**: 18.0+

## Build & Test Commands

```bash
# Build for iOS Simulator
xcodebuild -scheme StepUp -configuration Debug -sdk iphonesimulator build

# Run all unit tests
xcodebuild test -scheme StepUp \
  -destination 'platform=iOS Simulator,name=iPhone 16' \
  -configuration Debug

# Run specific test
xcodebuild test -scheme StepUp \
  -destination 'platform=iOS Simulator,name=iPhone 16' \
  -only-testing 'StepUpTests/StepUpTests/example'

# Run UI tests
xcodebuild test -scheme StepUp \
  -destination 'platform=iOS Simulator,name=iPhone 16' \
  -only-testing 'StepUpUITests'

# Clean build
xcodebuild clean -scheme StepUp
```

## Architecture

### Data Flow
- `StepUpApp.swift` - App entry point, initializes `ModelContainer` for SwiftData
- `ContentView.swift` - Main UI, uses `@Query` for reactive data binding and `@Environment(\.modelContext)` for mutations
- `Item.swift` - SwiftData model with `@Model` decorator

### Key Patterns
- All data mutations wrapped in `withAnimation` for smooth UI updates
- SwiftUI previews use `inMemory: true` ModelContainer to avoid side effects
- All UI code runs on `@MainActor` by default
- NavigationSplitView for responsive iPad/Mac/iPhone layouts

## Project Structure

```
StepUp/
├── StepUp/              # Main app source
│   ├── StepUpApp.swift  # Entry point & SwiftData setup
│   ├── ContentView.swift
│   └── Item.swift       # Data model
├── StepUpTests/         # Unit tests (Swift Testing framework)
└── StepUpUITests/       # UI tests (XCTest)
```

## SwiftData Conventions

```swift
// Model definition
@Model
final class Item {
    var timestamp: Date
    init(timestamp: Date) { self.timestamp = timestamp }
}

// View data binding
@Environment(\.modelContext) private var modelContext
@Query private var items: [Item]

// Mutations with animation
withAnimation {
    modelContext.insert(Item(timestamp: Date()))
}
```
