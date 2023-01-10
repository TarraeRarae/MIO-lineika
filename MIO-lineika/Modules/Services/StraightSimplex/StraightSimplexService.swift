//
//  StraightSimplexService.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 10.01.2023.
//

import Foundation

// MARK: - Protocols

protocol StraightSimplexServiceProtocol: AnyObject {
    func resolve(model: ConclusionModel) -> String
}

// MARK: - StraightSimplexService

final class StraightSimplexService: StraightSimplexServiceProtocol {

    // MARK: - Private properties

    private var sv = [[Double]]()

    private var result = 0

    private var istr = [Double]()

    private var bv = [[Double]]()

    private var iLcol = 0

    private var iLrow = 0

    private var th = [Double]()

    private var alm: Double = 0

    private var numV = 0

    private var numL = 0

    private var itNum = 0

    private var optimization: OptimizationType = .max

    // MARK: - Internal methods
    
    func resolve(model: ConclusionModel) -> String {
        initSystem(model: model)
        return getPlane()
    }
}

// MARK: - Private methods

private extension StraightSimplexService {
    
    func initSystem(model: ConclusionModel) {
        let function = model.function
        let constraints = model.constraints

        optimization = model.optimization

        sv = [[Double]]()
        istr = [Double]()
        bv = [[Double]]()
        th = [Double]()

        numV = model.function.count
        numL = model.constraints.count
        result = 0
        iLcol = 0
        iLrow = 0

        for _ in 0..<numL {
            sv.append([])
        }

        for index in 0..<numL {
            for secondIndex in 0..<numV {
                sv[index].append(Double(constraints[index][secondIndex]))
            }

            for secondIndex in numV..<numV * 2 {
                if index + numV == numV {
                    if optimization == .max {
                        sv[index].append(1)
                    } else {
                        sv[index].append(-1)
                    }
                } else {
                    sv[index].append(0)
                }
            }
        }

        for _ in 0..<numL {
            bv.append([])
        }

        for index in 0..<numL {
            bv[index] = []
            bv[index].append(Double(index + numV))
            bv[index].append(Double(constraints[index][constraints[index].count - 1]))
        }

        for _ in 0..<numV * 2 {
            istr.append(0)
        }

        for index in 0..<numV * 2 {
            if index < numV {
                istr[index] = Double(-function[index])
            } else {
                istr[index] = 0
            }
        }

        for index in 0..<numV * 2 - 1 {
            if (istr[index] < 0) {
                if (abs(istr[index + 1]) > abs(istr[index])) {
                    iLcol = index + 1
                }
            }
        }

        for _ in 0..<numL {
            th.append(0)
        }

        for index in 0..<numL {
            th[index] = bv[index][1] / sv[index][iLcol]
        }
        for index in 0..<numL - 1 {
            if (th[index] > th[index + 1]) {
                iLrow = index + 1
            }
        }
        alm = sv[iLrow][iLcol]
    }

    func isPlainValid() -> Bool {
        var isValid = true

        if optimization == .max {
            for index in 0..<numV * 2 {
                if istr[index] < 0 {
                    isValid = false
                    break
                }
            }
        }

        if optimization == .min {
            for index in 0..<numV * 2 {
                if istr[index] >= 0 {
                    isValid = false
                    break
                }
            }
        }

        return isValid
    }

    func isFunctionUndefined() -> Bool {
        for index in 0..<numL {
            if th[index] < 0 {
                return false
            }
        }

        return true
    }

    func getPlane() -> String {
        var A: Double = 0
        var B: Double = 0

        while !isPlainValid() && isFunctionUndefined() {
            A = bv[iLrow][1]
            B = istr[iLcol]


            result -= Int(A * B / alm)

            var tmpBv = [Double]()

            for _ in 0..<numL {
                tmpBv.append(0)
            }
    
            bv[iLrow][0] = Double(iLcol)
            A = bv[iLrow][1]

            for index in 0..<numL {
                B = sv[index][iLcol]
                tmpBv[index] = bv[iLrow][1]

                if index != iLrow {
                    tmpBv[index] = bv[index][1] - A * B / alm
                } else {
                    tmpBv[index] /= alm
                }
            }

            for index in 0..<numL {
                bv[index][1] = tmpBv[index]
            }

            var tmpIstr = istr

            B = istr[iLcol]

            for index in 0..<numV * 2 {
                A = sv[iLrow][index]
                tmpIstr[index] = istr[index] - A * B / alm
            }

            istr = tmpIstr

            var tmpSv = sv

            for index in 0..<numL {
                for secondIndex in 0..<numV * 2 {
                    A = sv[iLrow][secondIndex]
                    B = sv[index][iLcol]

                    if index == iLcol {
                        tmpSv[index][secondIndex] /= alm
                    } else {
                        tmpSv[index][secondIndex] = sv[index][secondIndex] - A * B / alm
                    }
                }
            }

            sv = tmpSv
            iLcol = 0

            for index in 0..<numL {
                th[index] = bv[index][1] / sv[index][iLcol]
            }

            iLrow = 0

            for index in 0..<numL - 1 {
                if (th[index] > th[index + 1]) {
                    iLrow = index + 1
                }
            }
                   
            alm = sv[iLrow][iLcol]
            itNum += 1
        }

        if !isFunctionUndefined() {
            return "Целевая фукнция не ограничена, данная задача решений не имеет"
        } else {
            var result = "\n f(x) = \(result)\n"
            for index in 0..<numL {
                result += "x\(Int(bv[index][0] + 1)) = \(bv[index][1])\n"
            }
            return result
        }
    }
}
