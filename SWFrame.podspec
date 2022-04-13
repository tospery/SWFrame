#
# Be sure to run `pod lib lint SWFrame.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SWFrame'
  s.version          = '2.1.0'
  s.summary          = 'iOS App Framework.'
  s.description      = <<-DESC
						iOS App Framework using Swift.
                       DESC

  s.homepage         = 'https://github.com/tospery/SWFrame'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'tospery' => 'tospery@gmail.com' }
  s.source           = { :git => 'https://github.com/tospery/SWFrame.git', :tag => s.version.to_s }

  s.requires_arc = true
  s.swift_version = '5.0'
  s.ios.deployment_target = '11.0'
  s.frameworks = 'Foundation', 'UIKit', 'CoreGraphics'

  s.subspec 'Core' do |ss|
    ss.source_files = 'SWFrame/Core/**/*'
	ss.dependency 'QMUIKit/QMUICore', '4.4.3'
	ss.dependency 'SwiftyBeaver', '1.9.5'
	ss.dependency 'ObjectMapper-JX', '4.2.0-v1'
	ss.dependency 'SwifterSwift/SwiftStdlib', '5.2.0'
  end
  
  s.subspec 'Network' do |ss|
    ss.source_files = 'SWFrame/Network/**/*'
  	ss.dependency 'SWFrame/Core'
	ss.dependency 'RxRelay', '6.2.0'
  	ss.dependency 'Moya/RxSwift', '15.0.0'
	ss.dependency 'SwifterSwift/Foundation', '5.2.0'
  end
  
  s.subspec 'Reactor' do |ss|
    ss.source_files = 'SWFrame/Reactor/**/*'
	ss.dependency 'SWFrame/Network'
	ss.dependency 'SWFrame/Resources'
	ss.dependency 'SWFrame/Components/JSBridge'
	ss.dependency 'RxTheme', '6.0.0'
	ss.dependency 'RxDataSources', '5.0.0'
	ss.dependency 'NSObject+Rx', '5.2.2'
	ss.dependency 'ReactorKit', '3.1.0'
	ss.dependency 'URLNavigator', '2.3.0'
	ss.dependency 'BonMot', '6.0.0'
	ss.dependency 'SwifterSwift', '5.2.0'
	ss.dependency 'FCUUID', '1.3.1'
	ss.dependency 'Kingfisher', '6.3.1'
	ss.dependency 'DZNEmptyDataSet', '1.8.1'
	ss.dependency 'MJRefresh', '3.7.5'
  end
  
  s.subspec 'Resources' do |ss|
    ss.resource_bundles = {'Resources' => ['SWFrame/Resources/*.*']}
  end
  
  s.subspec 'Components' do |ss|
    ss.subspec 'JSBridge' do |sss|
      sss.source_files = 'SWFrame/Components/JSBridge/**/*'
  	  sss.frameworks = 'WebKit'
    end
  end
  
end
