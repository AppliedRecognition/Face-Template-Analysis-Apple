//
//  FaceTemplateAnalysisTests.swift
//  FaceTemplateAnalysisTests
//
//  Created by Jakub Dolejs on 24/09/2021.
//

import XCTest
import VerIDCore
import VerIDSDKIdentity
@testable import FaceTemplateAnalysis

class FaceTemplateAnalysisTests: XCTestCase {
    
    var verID: VerID!
    
    override func setUp(completion: @escaping (Error?) -> Void) {
        guard let p12File = Bundle(for: type(of: self)).url(forResource: "Ver-ID identity", withExtension: "p12") else {
            completion(NSError())
            return
        }
        do {
            let identity = try VerIDIdentity(url: p12File, password: "25f5a22f-4322-4131-9988-7d1870c779c2")
            let veridFactory = VerIDFactory.init(identity: identity)
            veridFactory.createVerID { result in
                switch result {
                case .success(let verID):
                    self.verID = verID
                    completion(nil)
                case .failure(let error):
                    completion(error)
                }
            }
        } catch {
            completion(error)
        }
    }
    
    func testCompareAllFaces() throws {
        let faceAnalysis = FaceAnalysis(verID: self.verID)
        var faceTemplates: [Recognizable] = []
        for _ in 0..<1000 {
            faceTemplates.append(try (self.verID.faceRecognition as! VerIDFaceRecognition).generateRandomFaceTemplate(version: .V20))
        }
        var error: Error?
        var faceComparisonResult: FaceComparisonResult?
        let expectation = XCTestExpectation()
        faceAnalysis.compareAllFaces(faceTemplates) { result in
            switch result {
            case .success(let comparisonResult):
                faceComparisonResult = comparisonResult
            case .failure(let err):
                error = err
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 20)
        XCTAssertNil(error)
        XCTAssertNotNil(faceComparisonResult)
        XCTAssertEqual(faceComparisonResult?.faceCount, faceTemplates.count)
        XCTAssertEqual(faceComparisonResult?.scores.count, (faceTemplates.count - 1) * (faceTemplates.count / 2))
        XCTAssertGreaterThanOrEqual(faceComparisonResult!.scores.last!, faceComparisonResult!.scores.first!)
    }

}
