//
//  StraightSimplexModel.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 10.01.2023.
//

import Foundation

struct StraightSimplexModel {
    let function: [Int: Int]
    let constraints: [Int: [Int: Int]]
    let optimization: OptimizationType
}
