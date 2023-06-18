//
//  TabBarController.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 25.12.2022.
//

import UIKit
import SwiftUI

final class TabBarController: UITabBarController {

    // MARK: - Constants

    private enum Constants {
        static let tabBarKeyValue = "tabBar"
    }

    // MARK: - Private properties

    private let calculationCoordinator: MainCoordinator
    private let calculationController: UINavigationController
    private let informationController: UIViewController

    // MARK: - Initializers

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        calculationCoordinator = MainCoordinator()
        calculationController = calculationCoordinator.start()
        informationController = UIHostingController(rootView: NavigationView(content: {
            TheoryRootView()
                .rootToolBar(title: "Теоретические материалы")
        }))
        super.init(nibName: nil, bundle: nil)
        commonInit()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private methods

private extension TabBarController {

    func commonInit() {
        setupTabbar()
        setupItems()
    }

    func setupTabbar() {
        delegate = self
        let tabBar = CustomTabBar()
        tabBar.delegate = self
        setValue(tabBar, forKey: Constants.tabBarKeyValue)
        tabBar.tintColor = DesignManager.shared.theme[.tintColor(.tabbarItem)]
    }

    func setupItems() {
        let animation = CATransition()
        animation.duration = 1.0
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.type = .fade
   
        calculationController.tabBarItem = UITabBarItem(
            title: nil,
            image: Asset.Tabbar.calculationItemDisabled.image,
            selectedImage: Asset.Tabbar.calculationItemEnabled.image
        )

        informationController.tabBarItem = UITabBarItem(
            title: nil,
            image: Asset.Tabbar.theoryItemDisabled.image,
            selectedImage: Asset.Tabbar.theoryItemEnabled.image
        )

        viewControllers = [
            calculationController,
            informationController
        ]
    }
}

// MARK: - UITabBarControllerDelegate

extension TabBarController: UITabBarControllerDelegate {

    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {

        guard let fromView = selectedViewController?.view, let toView = viewController.view else {
            return false
        }
        
        if fromView != toView {
            UIView.transition(from: fromView, to: toView, duration: 0.3, options: [.transitionCrossDissolve], completion: nil)
        }
        
        return true
    }
}
