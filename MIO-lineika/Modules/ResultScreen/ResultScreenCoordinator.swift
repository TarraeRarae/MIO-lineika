//
//  ResultScreenCoordinator.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 17.06.2023.
//

import UIKit
import SwiftUI

final class ResultScreenCoordinator {

    // MARK: - State

//    private let controller = UIHostingController(rootView: ResultScreen())
    private var navigationController: UINavigationController?

    func start(navigationController: UINavigationController?, model: ConclusionModel) {
        let controller = UIHostingController(rootView: ResultScreen(model: model))
        controller.navigationItem.title = L10n.ResultScreen.title
        self.navigationController = navigationController
        navigationController?.pushViewController(controller, animated: true)
    }
}
