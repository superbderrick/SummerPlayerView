#
# Be sure to run `pod lib lint SummerPlayerView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SummerPlayerView'
  s.version          = '0.1.4'
  s.summary          = 'VideoPlayerView for kids, Tried to make it as similar as possible a Youtube kids App Player UI'
  s.description      = <<-DESC
  VideoPlayerView for kids, Tried to make it as similar as possible a Youtube kids App Player UI
                         DESC

  s.homepage         = 'https://github.com/Derrick/SummerPlayerView'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Derrick' => 'kang.derrick@gmail.com' }
  s.swift_version = '5.0'
  s.source           = { :git => 'https://github.com/superbderrick/SummerPlayerView.git', :tag => s.version.to_s }
  s.ios.deployment_target = '13.0'
  s.source_files = 'SummerPlayerView/Classes/**/*'
  s.resources = 'SummerPlayerView/Assets/**/*'
  s.frameworks = 'UIKit', 'AVKit'
end





                       