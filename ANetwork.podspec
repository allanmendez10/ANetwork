#
# Be sure to run `pod lib lint ANetwork.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ANetwork'
  s.version          = '1.3'
  s.summary          = 'ANetwork is an HTTP networking library written in Swift.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/allanmendez10/ANetwork'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'allanmendez10' => 'allanmendez0120@gmail.com' }
  s.source           = { :git => 'https://github.com/allanmendez10/ANetwork.git', :tag => 'v1.3' }
  s.social_media_url = 'https://www.instagram.com/allan_cmdz?r=nametag'

  s.ios.deployment_target = '12.0'

  s.source_files = 'Source/**/*.swift'
  s.swift_version = '5.0'
  s.platforms = {
      "ios":"12.0"
  }
  
  # s.resource_bundles = {
  #   'ANetwork' => ['ANetwork/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
