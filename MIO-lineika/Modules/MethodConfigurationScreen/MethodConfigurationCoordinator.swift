//
//  MethodConfigurationCoordinator.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 28.12.2022.
//

import UIKit

final class MethodConfigurationCoordinator {

    // MARK: - Private properties

    private var navigationController: UINavigationController?

    // MARK: - Internal methods
    
    func start(
        navigationController: UINavigationController?,
        model: MethodConfigurationModel
    ) {
        self.navigationController = navigationController
        let viewModel = MethodConfigurationViewModel(model: model)
        bindViewModel(viewModel)
        let viewController = MethodConfigurationViewController(viewModel: viewModel)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - Private methods

private extension MethodConfigurationCoordinator {

    func bindViewModel(_ viewModel: MethodConfigurationViewModel) {
        viewModel.route = { [weak self] route in
            switch route {
            case .none:
                self?.toConclusion()
            }
        }
    }

    func toConclusion() {
        print("❌❌❌")
    }
}
