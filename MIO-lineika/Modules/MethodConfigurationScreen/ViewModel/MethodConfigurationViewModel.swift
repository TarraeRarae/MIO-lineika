//
//  MethodConfigurationViewModel.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 26.12.2022.
//

import Foundation

// MARK: - Protocols

enum MethodConfigurationRoute {
    case none
}

protocol MethodConfigurationViewModelDelegate: AnyObject {
    func setSections(model: MethodConfigurationControllerModel)
}

protocol MethodConfigurationViewModelProtocol: AnyObject {
    var route: (MethodConfigurationRoute) -> Void { get set }
    var delegate: MethodConfigurationViewModelDelegate? { get set }
}

// MARK: - MethodConfigurationViewModel

final class MethodConfigurationViewModel: MethodConfigurationViewModelProtocol {

    // MARK: - Internal properties

    weak var delegate: MethodConfigurationViewModelDelegate?

    var route: (MethodConfigurationRoute) -> Void = { _ in }

    // MARK: - Initializers

    init(model: MethodConfigurationModel) {
        commonInit()
    }
}

// MARK: - Private methods

private extension MethodConfigurationViewModel {

    func commonInit() {}
}
