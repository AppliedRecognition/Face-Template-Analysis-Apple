//
//  FaceAnalysis.swift
//  FaceTemplateAnalysis
//
//  Created by Jakub Dolejs on 24/09/2021.
//

import Foundation
import VerIDCore

public class FaceAnalysis {
    
    /// Instance of `VerID` that performs the analysis
    public let verID: VerID
    private lazy var queue = DispatchQueue(label: "Face analysis", qos: .default, attributes: .concurrent)
    
    /// Initializer
    /// - Parameter verID: Instance of `VerID`
    public init(verID: VerID) {
        self.verID = verID
    }
    
    /// Compare all faces in a set to each other
    /// - Parameters:
    ///   - faces: Face templates to compare
    ///   - completion: Completion callback
    public func compareAllFaces(_ faces: [Recognizable], completion: @escaping (Result<FaceComparisonResult,Error>) -> Void) {
        var scores: [Float] = []
        var err: Error?
        let opQueue = OperationQueue()
        if faces.count < 2 {
            completion(.failure(FaceAnalysisError.notEnoughFacesToCompare))
        }
        opQueue.maxConcurrentOperationCount = 1
        self.queue.async {
            var comparisonPairs: [(Recognizable,Recognizable)] = []
            for i in 0..<faces.count-1 {
                for j in (i+1)..<faces.count {
                    comparisonPairs.append((faces[i], faces[j]))
                }
            }
            DispatchQueue.concurrentPerform(iterations: comparisonPairs.count) { i in
                do {
                    let score = try self.verID.faceRecognition.compareSubjectFaces([comparisonPairs[i].0], toFaces: [comparisonPairs[i].1]).floatValue
                    opQueue.addOperation {
                        scores.append(score)
                    }
                } catch {
                    opQueue.addOperation {
                        err = error
                    }
                }
            }
            opQueue.addOperation {
                if let error = err {
                    completion(.failure(error))
                } else {
                    scores.sort()
                    let result = FaceComparisonResult(faceCount: faces.count, scores: scores)
                    completion(.success(result))
                }
            }
        }
    }
}
