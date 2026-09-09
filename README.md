# GeneralToolsFramework

[![GitLab Source](http://img.shields.io/badge/source-GitLab-%23292961.svg)](https://git.zsinfo.nl/Zandor300/GeneralToolsFramework)
[![CI Status](https://git.zsinfo.nl/Zandor300/GeneralToolsFramework/badges/master/pipeline.svg)](https://git.zsinfo.nl/Zandor300/GeneralToolsFramework/pipelines)
[![Version](https://img.shields.io/cocoapods/v/GeneralToolsFramework.svg?style=flat)](https://cocoapods.org/pods/GeneralToolsFramework)
[![License](https://img.shields.io/cocoapods/l/GeneralToolsFramework.svg?style=flat)](https://cocoapods.org/pods/GeneralToolsFramework)
[![Platform](https://img.shields.io/cocoapods/p/GeneralToolsFramework.svg?style=flat)](https://cocoapods.org/pods/GeneralToolsFramework)
[![Swift Version](https://img.shields.io/badge/swift-5.0-orange.svg)](https://git.zsinfo.nl/Zandor300/GeneralToolsFramework)

I, [Zandor Smith](https://zandorsmith.com), use a general set of classes in all of my iOS apps. Because I use these classes all the time, I decided to write my own Cocoapod with all these classes.

## Requirements

GeneralToolsFramework is using the [Connectivity](https://cocoapods.org/pods/Connectivity) pod for it's API. It, by default, adds a couple of additional endpoints to Connectivity for it to use:
- https://web3.zsnode.com/success.html
- https://web4.zsnode.com/success.html

## Installation

### Swift Package Manager

Requires Xcode 15.3 or later (Swift 5.10), with iOS 13+, tvOS 13+, watchOS 7+, or visionOS 1+.

In Xcode, choose **File > Add Package Dependencies**, enter
`https://git.zsinfo.nl/Zandor300/GeneralToolsFramework.git`, and add the
`GeneralToolsFramework` library to your app target. Select a branch or release
that contains `Package.swift`; older releases only support CocoaPods.

To depend on the current development version from another package, add:

```swift
.package(url: "https://git.zsinfo.nl/Zandor300/GeneralToolsFramework.git", branch: "master")
```

Then add this product to your target's dependencies:

```swift
.product(name: "GeneralToolsFramework", package: "GeneralToolsFramework")
```

Import the framework with `import GeneralToolsFramework` as usual. Swift Package
Manager resolves upstream PINCache and the Zandor300 Connectivity fork automatically.
ZSPINCache 3.1.2 has CocoaPods-specific header imports that prevent its Swift
package from building, so the package uses PINCache 3.0.4 or later. The iOS
picker dependency is bundled with its MIT license because ZSPickerView 1.4 does
not provide a package manifest. Connectivity checks are enabled on iOS and tvOS,
matching the CocoaPods configuration.

### CocoaPods

GeneralToolsFramework is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your `Podfile`:

```ruby
pod 'GeneralToolsFramework'
```

and run `pod install` in the directory where your `Podfile` is located.

Not all versions of this framework will be released to [cocoapods.org](https://cocoapods.org) so you can also get a specific version from this repository like so:

```ruby
pod 'GeneralToolsFramework', :git => 'https://git.zsinfo.nl/Zandor300/GeneralToolsFramework.git', :tag => '1.1.2'
```

Or if you want to get the latest version that is in this repository, use the following line for your `Podfile` instead.

```ruby
pod 'GeneralToolsFramework', :git => 'https://git.zsinfo.nl/Zandor300/GeneralToolsFramework.git'
```

Note: The build on here might be broken.

## Validating the Swift package

Run `swift package resolve` to check dependency resolution. To build or test the
package independently of the root CocoaPods project, use:

```sh
bash scripts/check-swift-package.sh -destination 'generic/platform=iOS Simulator' build
bash scripts/check-swift-package.sh -destination 'platform=iOS Simulator,name=iPhone 15' test
```

Choose an installed simulator for tests. For other platform builds, replace
`iOS` with `tvOS`, `watchOS`, or `visionOS`. CI builds all four platforms.

## Author

Zandor Smith, info@zsinfo.nl

## License

GeneralToolsFramework is available under the MIT license. See the LICENSE file for more info.
