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
    private let resultScreenCoordinator: ResultScreenCoordinator

    // MARK: - Initializers

    init() {
        navigationController = UINavigationController()
        methodConfigurationCoordinator = MethodConfigurationCoordinator()
        resultScreenCoordinator = ResultScreenCoordinator()
    }

    // MARK: - Internal methods 

    func start() -> UINavigationController {
        let viewModel = MainViewModel()
        bindMainViewModel(viewModel)

        let viewController = MainViewController(viewModel: viewModel)

        navigationController.viewControllers = [viewController]
//        resultScreenCoordinator.start(navigationController: navigationController, model:  ConclusionModel(
//            function: [1, 2, 3, 4],
//            constraints: [[1, 2], [1, 2]],
//            optimization: .max,
//            method: .straightSimplex
//        )
//        )
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
