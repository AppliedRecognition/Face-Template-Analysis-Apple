workspace 'FaceTemplateAnalysis.xcworkspace'

# Uncomment the next line to define a global platform for your project
platform :ios, '12.0'

# Comment the next line if you don't want to use dynamic frameworks
use_frameworks!

# Pods for FaceTemplateAnalysis

pod 'Ver-ID/Core', '2.3.2'

post_install do |installer|
  installer.pods_project.build_configurations.each do |config|
    config.build_settings['BUILD_LIBRARY_FOR_DISTRIBUTION'] = 'YES'
  end
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings.delete 'BUILD_LIBRARY_FOR_DISTRIBUTION'
    end
  end
end

target 'FaceTemplateAnalysis'
target 'FaceTemplateAnalysisTests'
