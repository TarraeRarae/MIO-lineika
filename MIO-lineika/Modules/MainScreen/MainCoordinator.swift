//
//  MainCoordinator.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 15.12.2022.
//

import UIKit

final class MainCoordinator {

    private let navigationController: UINavigationController

    init() {
        navigationController = UINavigationController()
    }

    func start() -> UINavigationController {
        let viewController = MainViewController(viewModel: MainViewModel())
        navigationController.viewControllers = [viewController]
        return navigationController
    }
}
