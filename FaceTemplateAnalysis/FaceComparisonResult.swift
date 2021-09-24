//
//  FaceComparison.swift
//  FaceTemplateAnalysis
//
//  Created by Jakub Dolejs on 24/09/2021.
//

import Foundation

/// Face analysis result
public struct FaceComparisonResult: Codable {
    
    /// Number of faces analysed
    let faceCount: Int
    /// Comparison scores of the analysed faces
    let scores: [Float]
}
