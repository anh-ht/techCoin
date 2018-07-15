# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Techlab-Coin' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  pod 'JSONRPCKit', :git=> 'https://github.com/bricklife/JSONRPCKit.git'
  pod 'APIKit'
  #pod 'web3.swift'
  pod 'QRCodeReader.swift', '~> 8.2.0'
  pod 'ChameleonFramework/Swift', :git => 'https://github.com/ViccAlexander/Chameleon.git'
  pod 'QRCode'
  pod "ESTabBarController-swift"
  pod 'Firebase'
  pod 'Google'
  pod 'GoogleSignIn'
  pod 'FacebookLogin'
  pod 'TwitterKit'
  pod 'Fabric'
  # Pods for Techlab-Coin

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['GCC_WARN_INHIBIT_ALL_WARNINGS'] = "YES"
        end
    end
end
