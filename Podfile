source 'https://github.com/CocoaPods/Specs.git'
source 'https://github.com/Artsy/Specs.git'

platform :ios, '9.0'
use_frameworks!
inhibit_all_warnings!

target 'taipeiAttractions' do
  pod 'Alamofire'
  pod 'ObjectMapper'
  pod 'OHHTTPStubs'
  pod 'OHHTTPStubs/Swift'
  pod 'Nimble'

  target 'taipeiAttractionsTests' do
    inherit! :search_paths

  end
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    puts target.name
  end
end
