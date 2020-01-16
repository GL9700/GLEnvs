#
# Be sure to run `pod lib lint GLEnvs.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'GLEnvs'
  s.version          = '1.2.5'
  s.summary          = 'GLEnvs By liguoliang'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
    * 1.2.5
        维护:增加了更加明确和更加详细的注释。
    * 1.2.4
        迁移:Github
    * 1.2.3
        修复:方法交换问题
        增加:版本号显示
    * 1.2.2
        修复:修复一个崩溃Bug，对event做类型验证然后再进行后续操作
    * 1.2.1
        优化:当前环境显示问题，从小方块修改成全屏条幅
    * 1.2.0
        修复:一系列在真机导致崩溃的问题
    * 1.1.2
        fix Environment Save FAILED & Improve Save/Load to Archive
    * 1.0.1
        fix return Type
    * 1.0.0
        added custom
    DESC

  s.homepage         = 'https://github.com/GL9700/GLEnvs'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'liguoliang' => '36617161@qq.com' }
  s.source           = { :git => 'https://github.com/GL9700/GLEnvs.git', :tag => s.version.to_s }
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
