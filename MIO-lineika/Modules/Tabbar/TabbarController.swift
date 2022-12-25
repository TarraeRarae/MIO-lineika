//
//  TabbarController.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 25.12.2022.
//

import UIKit

final class TabbarController: UITabBarController {

    // MARK: - Private properties

    private let calculationController: UINavigationController
    private let mockController1: UIViewController
    private let mockController2: UIViewController

    // MARK: - Initializers

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        calculationController = MainCoordinator().start()
        mockController1 = MockController()
        mockController2 = MockController()
        super.init(nibName: nil, bundle: nil)
        commonInit()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private methods

private extension TabbarController {

    func commonInit() {
        setupTabbar()
        setupItems()
    }

    func setupTabbar() {
        setValue(CustomTabbar(), forKey: "tabBar")

        tabBar.tintColor = DesignManager.shared.theme[.tintColor(.tabbarItem)]
    }

    func setupItems() {
        calculationController.tabBarItem = UITabBarItem(
            title: nil,
            image: Asset.Tabbar.calculationItemDisabled.image,
            selectedImage: Asset.Tabbar.calculationItemEnabled.image
        )

        mockController1.tabBarItem = UITabBarItem(
            title: nil,
            image: Asset.Tabbar.photoItemDisabled.image,
            selectedImage: Asset.Tabbar.photoItemEnabled.image
        )

        mockController2.tabBarItem = UITabBarItem(
            title: nil,
            image: Asset.Tabbar.theoryItemDisabled.image,
            selectedImage: Asset.Tabbar.theoryItemEnabled.image
        )

        viewControllers = [
            calculationController,
            mockController1,
            mockController2
        ]
    }
}
