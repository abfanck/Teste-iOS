# Podfile

source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'
use_frameworks!

target 'Teste-iOS' do
  pod 'RxSwift', '6.0.0-rc.2'
  pod 'RxCocoa', '6.0.0-rc.2'
  pod 'SnapKit', '~> 4.0'
  
  target "Teste-iOSTests" do
    inherit! :search_paths
    pod 'Quick'
    pod 'Nimble'
  end
  
  target "Teste-iOSUITests" do
    inherit! :search_paths
    pod 'Quick'
    pod 'Nimble'
  end
end
