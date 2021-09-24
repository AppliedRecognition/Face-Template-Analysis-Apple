![Cocoapods](https://img.shields.io/cocoapods/v/FaceTemplateAnalysis)

# Face Template Analysis

Utility for analysing Ver-ID face templates

## Installation

The iOS framework is distributed on [CocoaPods](https://cocoapods.org).

1. Add the following dependency in your [Podfile](https://guides.cocoapods.org/syntax/podfile.html):

    ```
    pod 'FaceTemplateAnalysis', '~> 1.0'
    ```
2. Add the following script in your Podfile:

    ```
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
    ```
3. Run:

    ```
    pod install
    ```
4. Open the generated Xcode workspace (xcworkspace file not the xcodeproj file)

## Usage

1. Create an instance of `VerID`:
    
    ```swift
    let veridFactory = VerIDFactory()
    veridFactory.createVerID { result in
        switch result {
        case .success(let verID):
            // You can now use verID
        case .failure(let error):
            // VerID creation failed
        }
    }
    ```
2. Create an instance of ``FaceAnalysis``
    
    ```swift
    let faceAnalysis = FaceAnalysis(verID: verID)
    ```
3. Compare all faces to each other:

    ```swift
    // Face templates to compare, obtained from Ver-ID
    let faces: [Recognizable]
    // Compare all faces to each other
    faceAnalysis.compareAllFaces(faces) { result in
        switch result {
        case .success(let faceComparisonResult):
            // Success
        case .failure(let error):
            // The comparison failed
        }
    }
    ```

4. Encode the face comparison result to JSON:
    
    ```swift
    do {
        let json = try JSONEncode().encode(faceComparisonResult)
    } catch {
        // JSON encoding failed
    }
    ```
