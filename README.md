# FaceTemplateAnalysis

Collection of face template analysis functions

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
