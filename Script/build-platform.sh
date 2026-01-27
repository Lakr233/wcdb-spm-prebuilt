#!/bin/bash

# Build WCDB for a specific platform
# Usage: ./build-platform.sh <wcdb_source_dir> <scheme> <platform> <output_dir>
# Platforms: ios, ios-simulator, macos, macos-catalyst, tvos, tvos-simulator, watchos, watchos-simulator

set -e

cd "$(dirname "$0")/.."

WCDB_SOURCE_DIR=$1
SCHEME=$2
PLATFORM=$3
OUTPUT_DIR=$4

if [ -z "$WCDB_SOURCE_DIR" ] || [ -z "$SCHEME" ] || [ -z "$PLATFORM" ] || [ -z "$OUTPUT_DIR" ]; then
	echo "Usage: $0 <wcdb_source_dir> <scheme> <platform> <output_dir>"
	echo "Platforms: ios, ios-simulator, macos, macos-catalyst, tvos, tvos-simulator, watchos, watchos-simulator"
	exit 1
fi

PROJECT_FILE="$WCDB_SOURCE_DIR/src/WCDB.xcodeproj"
if [ ! -d "$PROJECT_FILE" ]; then
	echo "[!] Project not found: $PROJECT_FILE"
	exit 1
fi

echo "[*] Building $SCHEME for $PLATFORM"
echo "[*] Project: $PROJECT_FILE"
echo "[*] Output: $OUTPUT_DIR"

mkdir -p "$OUTPUT_DIR"

# Map platform to xcodebuild destination
case "$PLATFORM" in
ios)
	DESTINATION="generic/platform=iOS,name=Any iOS Device"
	;;
ios-simulator)
	DESTINATION="generic/platform=iOS Simulator"
	;;
macos)
	DESTINATION="generic/platform=macOS,name=Any Mac"
	;;
macos-catalyst)
	DESTINATION="generic/platform=macOS,variant=Mac Catalyst,name=Any Mac"
	;;
tvos)
	DESTINATION="generic/platform=tvOS,name=Any tvOS Device"
	;;
tvos-simulator)
	DESTINATION="generic/platform=tvOS Simulator"
	;;
watchos)
	DESTINATION="generic/platform=watchOS,name=Any watchOS Device"
	;;
watchos-simulator)
	DESTINATION="generic/platform=watchOS Simulator"
	;;
*)
	echo "[!] Unknown platform: $PLATFORM"
	echo "Valid platforms: ios, ios-simulator, macos, macos-catalyst, tvos, tvos-simulator, watchos, watchos-simulator"
	exit 1
	;;
esac

ARCHIVE_PATH="$OUTPUT_DIR/$SCHEME-$PLATFORM"

# Extra args for Swift library distribution
EXTRA_ARGS=""
if [ "$SCHEME" = "WCDBSwift" ]; then
	EXTRA_ARGS="BUILD_LIBRARY_FOR_DISTRIBUTION=YES"
fi

echo "[*] Destination: $DESTINATION"
echo "[*] Archive path: $ARCHIVE_PATH"

# Check if xcbeautify is available
if command -v xcbeautify &>/dev/null; then
	xcodebuild archive \
		-project "$PROJECT_FILE" \
		-scheme "$SCHEME" \
		-configuration Release \
		-destination "$DESTINATION" \
		-archivePath "$ARCHIVE_PATH" \
		SKIP_INSTALL=NO \
		$EXTRA_ARGS \
		2>&1 | xcbeautify
else
	xcodebuild archive \
		-project "$PROJECT_FILE" \
		-scheme "$SCHEME" \
		-configuration Release \
		-destination "$DESTINATION" \
		-archivePath "$ARCHIVE_PATH" \
		SKIP_INSTALL=NO \
		$EXTRA_ARGS
fi

echo "[*] Build complete: $ARCHIVE_PATH.xcarchive"
