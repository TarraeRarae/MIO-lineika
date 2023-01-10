//
//  ConclusionCoordinator.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 09.01.2023.
//

import Foundation

import UIKit

final class ConclusionCoordinator {

    // MARK: - Private properties

    private var navigationController: UINavigationController?

    // MARK: - Internal methods
    
    func start(
        navigationController: UINavigationController?,
        model: ConclusionModel
    ) {
        self.navigationController = navigationController
        let viewModel = ConclusionViewModel(model: model)
        let viewController = ConclusionViewController(viewModel: viewModel)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
