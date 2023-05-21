#
# Be sure to run `pod lib lint GeneralToolsFramework.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'GeneralToolsFramework'
  s.version          = '1.20.0'
  s.summary          = 'Contains general tools used in my iOS apps.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
I, Zandor Smith, use a general set of classes in all of my iOS apps. Because I use these classes all the time, I decided to write my own Cocoapod with all these classes.
                       DESC

  s.homepage         = 'https://git.zsinfo.nl/Zandor300/GeneralToolsFramework'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Zandor Smith' => 'info@zsinfo.nl' }
  s.source           = { :git => 'https://git.zsinfo.nl/Zandor300/GeneralToolsFramework.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '11.0'
  s.tvos.deployment_target = '11.0'
  s.watchos.deployment_target = '7.0'
  s.swift_version = '5.0'

  s.ios.source_files = 'GeneralToolsFramework/Classes/Common/**/*', 'GeneralToolsFramework/Classes/iOS/**/*'
  s.tvos.source_files = 'GeneralToolsFramework/Classes/Common/**/*'
  s.watchos.source_files = 'GeneralToolsFramework/Classes/Common/**/*'
  
  # s.resource_bundles = {
  #   'GeneralToolsFramework' => ['GeneralToolsFramework/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.ios.frameworks = 'UIKit', 'Security'
  s.tvos.frameworks = 'Security'
  s.watchos.frameworks = 'Security'

  s.dependency 'ZSPINCache', '~> 3.1'
  s.ios.dependency 'Connectivity', '~> 6.0'
  s.tvos.dependency 'Connectivity', '~> 6.0'
  s.ios.dependency 'ZSPickerView', '~> 1.4'
end
