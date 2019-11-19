#
# Be sure to run `pod lib lint GLEnvs.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'GLEnvs'
  s.version          = '1.2.3'
  s.summary          = 'GLEnvs By liguoliang'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  * 1.0.0 added custom
  * 1.0.1 fix return Type
  * 1.1.2 fix Environment Save FAILED & Improve Save/Load to Archive
  * 1.2.0 fix 修复一系列在真机导致崩溃的问题
  * 1.2.1 opt 优化当前环境显示问题，从小方块修改成全屏条幅
  * 1.2.2 fix 修复一个崩溃Bug，对event做类型验证然后再进行后续操作
  * 1.2.3 修复一个方法交换问题，增加版本号显示
    DESC

  s.homepage         = 'http://gitlab.wdcloud.cc:10080/iosbase/GLEnvs'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'liguoliang' => 'guoliang@51jianjiao.com' }
  s.source           = { :git => 'http://gitlab.wdcloud.cc:10080/iosbase/GLEnvs.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'GLEnvs/Classes/**/*'
  
  # s.resource_bundles = {
  #   'GLEnvs' => ['GLEnvs/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
