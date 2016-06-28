source 'https://github.com/CocoaPods/Specs.git'
source 'https://github.com/Artsy/Specs.git'

platform :ios, '9.0'
use_frameworks!
inhibit_all_warnings!

target 'taipeiAttractions' do
  pod 'Alamofire'
  pod 'ObjectMapper'
  pod 'AsyncDisplayKit'
  pod 'SVProgressHUD'

  target 'taipeiAttractionsTests' do
    inherit! :search_paths
    pod 'OHHTTPStubs'
    pod 'OHHTTPStubs/Swift'
    pod 'Nimble'
  end
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    puts target.name
  end
end
