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

## Author

Zandor Smith, info@zsinfo.nl

## License

GeneralToolsFramework is available under the MIT license. See the LICENSE file for more info.
