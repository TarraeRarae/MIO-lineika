//
//  AppDelegate.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 15.12.2022.
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private let mainCoordinator = MainCoordinator()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.shared.enable = true
        window = UIWindow(frame: UIScreen.main.bounds)

        window?.rootViewController = TabBarController()

//        let model = MethodConfigurationModel(
//            method: .straightSimplex,
//            variables: 3,
//            constraints: 9,
//            optimization: .max
//        )
//        let viewModel = MethodConfigurationViewModel(model: model)
//        window?.rootViewController = MethodConfigurationViewController(viewModel: viewModel)

        window?.makeKeyAndVisible()
        return true
    }
}

