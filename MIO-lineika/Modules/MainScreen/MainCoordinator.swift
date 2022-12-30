//
//  MainCoordinator.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 15.12.2022.
//

import UIKit

final class MainCoordinator {

    // MARK: - Private properties

    private let navigationController: UINavigationController
    private let methodConfigurationCoordinator: MethodConfigurationCoordinator

    // MARK: - Initializers

    init() {
        navigationController = UINavigationController()
        methodConfigurationCoordinator = MethodConfigurationCoordinator()
    }

    // MARK: - Internal methods 

    func start() -> UINavigationController {
        let viewModel = MainViewModel()
        bindMainViewModel(viewModel)

        let viewController = MainViewController(viewModel: viewModel)

        navigationController.viewControllers = [viewController]
        return navigationController
    }
}

// MARK: - Private methods

private extension MainCoordinator {

    func bindMainViewModel(_ viewModel: MainViewModelProtocol) {
        viewModel.route = { [weak self] route in
            switch route {
            case .toMethodConfiguration(let model):
                self?.toMethodConfiguration(model)
            }
        }
    }

    func toMethodConfiguration(_ model: MethodConfigurationModel) {
        methodConfigurationCoordinator.start(
            navigationController: navigationController,
            model: model
        )
    }
}
