# Makefile for JobTwister
# Provides convenient commands for building and testing

.PHONY: help build test clean ui-test all

# Default target
help:
	@echo "JobTwister Build Commands:"
	@echo "  make build     - Build the application"
	@echo "  make test      - Run unit tests"
	@echo "  make ui-test   - Run UI tests"
	@echo "  make clean     - Clean build artifacts"
	@echo "  make all       - Clean, build, and test"
	@echo ""
	@echo "Requirements: macOS with Xcode installed"

# Build the application
build:
	@echo "🔨 Building JobTwister..."
	xcodebuild build \
		-project JobTwister.xcodeproj \
		-scheme JobTwister \
		-destination 'platform=macOS' \
		-configuration Debug \
		CODE_SIGN_IDENTITY="" \
		CODE_SIGNING_REQUIRED=NO \
		ONLY_ACTIVE_ARCH=NO

# Run unit tests
test:
	@echo "🧪 Running unit tests..."
	xcodebuild test \
		-project JobTwister.xcodeproj \
		-scheme JobTwister \
		-destination 'platform=macOS' \
		-configuration Debug \
		CODE_SIGN_IDENTITY="" \
		CODE_SIGNING_REQUIRED=NO \
		ONLY_ACTIVE_ARCH=NO

# Run UI tests
ui-test:
	@echo "🖥️  Running UI tests..."
	xcodebuild test \
		-project JobTwister.xcodeproj \
		-scheme JobTwister \
		-destination 'platform=macOS' \
		-configuration Debug \
		-testPlan JobTwisterUITests \
		CODE_SIGN_IDENTITY="" \
		CODE_SIGNING_REQUIRED=NO \
		ONLY_ACTIVE_ARCH=NO

# Clean build artifacts
clean:
	@echo "🧹 Cleaning build artifacts..."
	xcodebuild clean \
		-project JobTwister.xcodeproj \
		-scheme JobTwister

# Full build and test cycle
all: clean build test
	@echo "✅ Build and test cycle completed!"

# Check if we're on macOS
check-macos:
	@if [ "$$(uname)" != "Darwin" ]; then \
		echo "❌ This Makefile requires macOS"; \
		exit 1; \
	fi

# Add macOS check as dependency for build targets
build test ui-test clean: check-macos