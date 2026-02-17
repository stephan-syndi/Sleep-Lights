project 'SleepLights.xcodeproj'

# Uncomment the next line to define a global platform for your project
platform :ios, '15.0'

install! 'cocoapods', :disable_input_output_paths => true

target 'SleepLights' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for SleepLights
  pod 'Alamofire', '~> 5.9'
  pod 'AppsFlyerFramework', '= 6.12'
  pod 'Firebase/Core', '12.7.0'
  pod 'Firebase/Messaging', '12.7.0'
  pod 'Swinject'
  
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '15.0'
      config.build_settings['BUILD_LIBRARY_FOR_DISTRIBUTION'] = 'YES'
    end
  end
end

target 'notifications' do
  use_frameworks!
  
  pod 'Alamofire', '~> 5.9'
  pod 'AppsFlyerFramework', '= 6.12'
  pod 'Firebase/Core', '12.7.0'
  pod 'Firebase/Messaging', '12.7.0'
  pod 'Swinject'
  
end
