source 'https://github.com/CocoaPods/Specs.git'
source 'https://github.com/Artsy/Specs.git'

platform :ios, '9.0'
use_frameworks!
inhibit_all_warnings!

target 'taipeiAttractions' do
  pod 'Alamofire'
  pod 'ObjectMapper', :git => 'https://github.com/Hearst-DD/ObjectMapper.git', :branch => 'swift-3'
  pod 'AsyncDisplayKit'
  pod 'SVProgressHUD'
  
  target 'taipeiAttractionsTests' do
    inherit! :search_paths  
    pod 'Nimble'
    pod 'OHHTTPStubs'
    pod 'OHHTTPStubs/Swift'

  end
end

 post_install do |installer|
 	installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
 end