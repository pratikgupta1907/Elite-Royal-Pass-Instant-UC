# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Elite Royal Pass Instant UC' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Elite Royal Pass Instant UC
pod 'GoogleSignIn'
pod 'Firebase/Analytics'
pod 'Alamofire', '~> 5.1'
pod 'SwiftyJSON', '~> 4.0'
pod 'Kingfisher'
pod 'SRScratchView'
pod 'Google-Mobile-Ads-SDK'
pod 'GoogleMobileAdsMediationFacebook'
pod 'GoogleMobileAdsMediationAppLovin'
pod 'GoogleMobileAdsMediationAdColony'
pod 'Siren', '~> 5.4'
pod 'ImageSlideshow', '~> 1.9'
pod "ImageSlideshow/Kingfisher"
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
        end
    end
end
