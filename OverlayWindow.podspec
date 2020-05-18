#
# Be sure to run `pod lib lint Podname.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|

s.swift_version = '5.0'

s.name             = 'OverlayWindow'
s.version          = '0.1.2'
s.summary          = 'OverlayWindow displays a new window on top of any existing ones. Perfect for controller-independent modal presentation'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

s.description      = <<-DESC
OverlayWindow displays a new window on top of any existing ones. Perfect for controller-independent modal presentation. Fade-in animation for displaying and dismissing the overlay window.
DESC

s.homepage         = 'https://github.com/lveecode/OverlayWindow'
# s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'Lesya V' => '' }
s.source           = { :git => 'https://github.com/lveecode/OverlayWindow.git', :tag => s.version.to_s }
# s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

s.ios.deployment_target = '11.0'

s.source_files = 'OverlayWindow/Classes/**/*'

# s.resource_bundles = {
#   'OverlayWindow' => ['OverlayWindow/Assets/*.png']
# }

# s.public_header_files = 'Pod/Classes/**/*.h'
s.frameworks = 'UIKit'
# s.dependency 'AFNetworking', '~> 2.3'
# s.default_subspec = 'Core'

# s.subspec 'Core' do |core|
# subspec for users who only want Core features
#      core.source_files = 'Podname/Classes/Core/**/*'
# end

end
