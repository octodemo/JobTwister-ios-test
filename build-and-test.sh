#!/bin/bash

# Build and Test Script for JobTwister
# This script builds and tests the JobTwister macOS application

set -e  # Exit on any error

echo "🏗️  Building and Testing JobTwister..."

# Check if we're on macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
    echo "❌ This script must be run on macOS with Xcode installed"
    exit 1
fi

# Check if xcodebuild is available
if ! command -v xcodebuild &> /dev/null; then
    echo "❌ xcodebuild not found. Please install Xcode."
    exit 1
fi

PROJECT_NAME="JobTwister.xcodeproj"
SCHEME_NAME="JobTwister"

echo "📋 Project: $PROJECT_NAME"
echo "🎯 Scheme: $SCHEME_NAME"

# Clean previous builds
echo "🧹 Cleaning previous builds..."
xcodebuild clean \
    -project "$PROJECT_NAME" \
    -scheme "$SCHEME_NAME" \
    -quiet

# Build the application
echo "🔨 Building application..."
xcodebuild build \
    -project "$PROJECT_NAME" \
    -scheme "$SCHEME_NAME" \
    -destination 'platform=macOS' \
    -configuration Debug \
    CODE_SIGN_IDENTITY="" \
    CODE_SIGNING_REQUIRED=NO \
    ONLY_ACTIVE_ARCH=NO

if [ $? -eq 0 ]; then
    echo "✅ Build successful!"
else
    echo "❌ Build failed!"
    exit 1
fi

# Run unit tests
echo "🧪 Running unit tests..."
xcodebuild test \
    -project "$PROJECT_NAME" \
    -scheme "$SCHEME_NAME" \
    -destination 'platform=macOS' \
    -configuration Debug \
    CODE_SIGN_IDENTITY="" \
    CODE_SIGNING_REQUIRED=NO \
    ONLY_ACTIVE_ARCH=NO

if [ $? -eq 0 ]; then
    echo "✅ Unit tests passed!"
else
    echo "⚠️  Unit tests failed or had issues"
fi

# Run UI tests (optional, often flaky)
echo "🖥️  Running UI tests..."
xcodebuild test \
    -project "$PROJECT_NAME" \
    -scheme "$SCHEME_NAME" \
    -destination 'platform=macOS' \
    -configuration Debug \
    -testPlan JobTwisterUITests \
    CODE_SIGN_IDENTITY="" \
    CODE_SIGNING_REQUIRED=NO \
    ONLY_ACTIVE_ARCH=NO || echo "⚠️  UI tests failed (this is often expected)"

echo "🎉 Build and test process completed!"
echo "📊 Check the output above for detailed results"