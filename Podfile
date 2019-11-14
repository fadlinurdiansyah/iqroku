# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'iQroku' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for iQroku

#pod 'NotificationBannerSwift', '2.0.1'
#pod 'SwiftyDraw'
pod "Pulsator"
#pod 'Eureka'
#pod 'DropDown'
#pod 'SQLite.swift', '~> 0.11.6'
pod 'SwiftEntryKit'

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    if ['Pulsator','SwiftEntryKit'].include? target.name
      target.build_configurations.each do |config|
        config.build_settings['SWIFT_VERSION'] = '4.2'
      end
    end
  end
end
