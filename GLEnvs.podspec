#
# Be sure to run `pod lib lint GLEnvs.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'GLEnvs'
  s.version          = '1.4.0'
  s.summary          = 'GLEnv 可以在app中快速切换至想要的环境'
  s.description      = <<-DESC
    GLEnvs 快速切换app的环境
      采用多种策略进行环境选择
    by liguoliang 36617161@qq.com
  DESC

  s.homepage         = 'https://github.com/GL9700/GLEnvs'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'liguoliang' => '36617161@qq.com' }
  s.source           = { :git => 'https://github.com/GL9700/GLEnvs.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'GLEnvs/Classes/**/*'
  
  # s.resource_bundles = {
  #   'GLEnvs' => ['GLEnvs/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
