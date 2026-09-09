#!/bin/bash
set -euo pipefail

# The root _Pods.xcodeproj makes xcodebuild select CocoaPods instead of the package.
# Validate a standalone copy containing only the package and its test sources.
repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
package_dir="$(mktemp -d "${TMPDIR:-/tmp}/GeneralToolsFramework-SPM.XXXXXX")"
trap 'rm -rf "$package_dir"' EXIT

mkdir -p "$package_dir/Example"
cp "$repo_dir/Package.swift" "$package_dir/"
cp -R "$repo_dir/GeneralToolsFramework" "$repo_dir/Vendor" "$package_dir/"
cp -R "$repo_dir/Example/Tests" "$package_dir/Example/"

cd "$package_dir"
xcodebuild -scheme GeneralToolsFramework -derivedDataPath "$package_dir/DerivedData" CODE_SIGNING_ALLOWED=NO "$@"
