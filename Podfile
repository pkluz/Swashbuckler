source 'https://github.com/CocoaPods/Specs.git'

project 'Sources/Swashbuckler.xcodeproj'

platform :osx, '10.12'
use_frameworks!
inhibit_all_warnings!

target 'Swashbuckler' do
    pod 'GRMustache.swift'
    pod 'FootlessParser', git: 'https://github.com/kareman/FootlessParser.git', branch: 'swift3.0'
    pod 'Result', '~> 3.1.0'
    pod 'SwiftLint'
end

target 'SwashbucklerTests' do
    pod 'FootlessParser', git: 'https://github.com/kareman/FootlessParser.git', branch: 'swift3.0'
end
