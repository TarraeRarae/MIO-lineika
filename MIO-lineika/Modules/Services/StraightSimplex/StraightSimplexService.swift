//
//  StraightSimplexService.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 10.01.2023.
//

import Foundation

protocol StraightSimplexServiceProtocol: AnyObject {
    func resolve(model: StraightSimplexModel)
}

final class StraightSimplexService: StraightSimplexServiceProtocol {

    // MARK: - Internal methods

    func resolve(model: StraightSimplexModel) {}
}
