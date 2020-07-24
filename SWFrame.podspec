#
# Be sure to run `pod lib lint SWFrame.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SWFrame'
  s.version          = '2.0.0'
  s.summary          = 'iOS App Framework.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
						iOS App Framework using Swift.
                       DESC

  s.homepage         = 'https://github.com/tospery/SWFrame'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'tospery' => 'tospery@gmail.com' }
  s.source           = { :git => 'https://github.com/tospery/SWFrame.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.requires_arc = true
  s.swift_version = '5.0'
  s.ios.deployment_target = '10.0'

  s.source_files = 'SWFrame/Classes/**/*'
  
  s.resource_bundles = {
    'SWFrame' => ['SWFrame/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'Foundation', 'UIKit', 'Accelerate', 'QuartzCore', 'CoreLocation', 'SystemConfiguration', 'AdSupport', 'WebKit', 'CoreGraphics', 'Photos'
  s.dependency 'SwiftyBeaver', '1.9.1'
  s.dependency 'RxSwiftExt', '5.2.0'
  s.dependency 'RxDataSources', '4.0.1'
  s.dependency 'RxViewController', '1.0.0'
  s.dependency 'NSObject+Rx', '5.1.0'
  s.dependency 'Moya/RxSwift', '14.0.0'
  s.dependency 'ObjectMapper', '4.2.0'
  s.dependency 'ReachabilitySwift', '5.0.0'
  s.dependency 'ReactorKit', '2.1.0'
  s.dependency 'URLNavigator', '2.3.0'
  s.dependency 'BonMot', '5.5.1'
  s.dependency 'SwifterSwift', '5.2.0'
  s.dependency 'FCUUID', '1.3.1'
  s.dependency 'Kingfisher', '5.14.0'
  s.dependency 'WebViewJavascriptBridge', '6.0.3'
  s.dependency 'DZNEmptyDataSet', '1.8.1'
  s.dependency 'ESPullToRefresh', '2.9.2'
  s.dependency 'Toast-Swift', '5.0.1'
  s.dependency 'QMUIKit/QMUICore', '4.1.3'
end
