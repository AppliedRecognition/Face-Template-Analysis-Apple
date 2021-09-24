Pod::Spec.new do |spec|

  spec.name         = "FaceTemplateAnalysis"
  spec.version      = "1.0.0"
  spec.summary      = "Utility for analysing Ver-ID face templates"
  spec.description  = "Utility for analysing Ver-ID face templates"
  spec.homepage     = "https://github.com/AppliedRecognition/Face-Template-Analysis-Apple/README.md"
  spec.license      = "MIT"
  spec.author       = "Jakub Dolejs"
  spec.platform     = :ios, "12.0"
  spec.source       = { :git => "https://github.com/AppliedRecognition/Face-Template-Analysis-Apple.git", :tag => "#{spec.version}" }

  spec.source_files  = "FaceTemplateAnalysis/**/*.swift"

  spec.dependency "Ver-ID/Core", ">= 2.3.2", "< 3.0.0"

end
