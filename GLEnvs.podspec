#
# Be sure to run `pod lib lint GLEnvs.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'GLEnvs'
  s.version          = '1.3.0'
  s.summary          = 'GLEnv 可以进行app环境快速切换，可以在app中摇一摇来进行环境选择，无需重新编译'
  s.description      = <<-DESC
    GLEnvs 可以快速进行app的环境切换
      采用摇一摇策略进行环境选择
    by liguoliang 36617161@qq.com
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
