project '/Volumes/Shared/Syndi/Swift/Sleep-Lights/Sleep Lights.xcodeproj'

# Uncomment the next line to define a global platform for your project
platform :ios, '15.0'

install! 'cocoapods', :disable_input_output_paths => true

target 'Sleep Lights' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Sleep Lights
  pod 'Alamofire', '~> 5.9'
  pod 'AppsFlyerFramework', '~> 6.15'
  pod 'Firebase/Core', '12.7.0'
  pod 'Firebase/Messaging', '12.7.0'

end



target 'notifications' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for notifications
  pod 'Alamofire', '~> 5.9'
  pod 'AppsFlyerFramework', '~> 6.15'
  pod 'Firebase/Core', '12.7.0'
  pod 'Firebase/Messaging', '12.7.0'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '15.0'
      config.build_settings['BUILD_LIBRARY_FOR_DISTRIBUTION'] = 'YES'
      config.build_settings['EXPANDED_CODE_SIGN_IDENTITY'] = ""
      config.build_settings['CODE_SIGNING_REQUIRED'] = "NO"
      config.build_settings['CODE_SIGNING_ALLOWED'] = "NO"
    end
  end
end
