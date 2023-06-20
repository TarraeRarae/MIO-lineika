//
//  ConclusionModel.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 09.01.2023.
//

import Foundation

struct ConclusionModel {
    let function: [Int]
    let constraints: [[Int]]
    let optimization: OptimizationType
    let method: MethodType

    var functionString: String {
        var functionString = "F = "
        for itemIndex in 0..<function.count {
            if function[itemIndex] == 0 {
                continue
            }
            if itemIndex == 0 {
                if function[itemIndex] < 0 {
                    functionString += "-"
                }
            }
            if abs(function[itemIndex]) == 1 {
                functionString += "x\(itemIndex + 1) "
            } else {
                functionString += "\(function[itemIndex])x\(itemIndex + 1) "
            }
            if itemIndex == function.count - 1 {
                continue
            }
            if function[itemIndex + 1] > 0 {
                functionString += "+ "
            } else {
                functionString += "- "
            }
        }
        functionString += "\(L10n.Arrow.right) \(optimization.rawValue)"
        return functionString
    }

    var constraintsStrings: [String] {
        var constraintsStrings = [String]()
        for row in constraints {
            var rowString = ""
            for column in 0..<row.count {
                if column == row.count - 1 {
                    rowString += "\(row[column])"
                    continue
                }
                if row[column] == 0 {
                    continue
                }
                if abs(row[column]) == 1 {
                    rowString += "x\(column + 1) "
                } else {
                    rowString += "\(row[column])x\(column + 1) "
                }

                if column == row.count - 2 {
                    rowString += "= "
                    continue
                }
                if row[column + 1] > 0 {
                    rowString += "+ "
                } else {
                    rowString += "- "
                }
            }
            constraintsStrings.append(rowString)
        }
        return constraintsStrings
    }
}

extension String: Identifiable {

    public var id: Int {
        self.hashValue
    }
}
