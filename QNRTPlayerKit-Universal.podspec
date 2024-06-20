#
# Be sure to run `pod lib lint QNRTPlayerKit.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "QNRTPlayerKit"
  s.version          = "1.0.3"
  s.summary          = "Pili iOS quic video player SDK, HLS video streaming supported."
  s.homepage         = "https://github.com/pili-engineering/QNRTPlayer-iOS"
  s.license          = 'Apache License, Version 2.0'
  s.author           = { "pili" => "pili-coresdk@qiniu.com" }
  s.source           = { :http => "https://sdk-release.qnsdk.com/QNRTPlayerKit-universal-v1.0.3.zip" }
 
  s.platform     = :ios
  s.ios.deployment_target   = '9.0'
  s.requires_arc = true

  s.vendored_frameworks = ['Pod/universal/QNRTPlayerKit.framework']

  s.frameworks = ['UIKit', 'AVFoundation', 'CoreGraphics', 'CFNetwork', 'AudioToolbox', 'CoreMedia', 'VideoToolbox']

end
