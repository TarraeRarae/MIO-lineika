//
//  BaseController.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 16.12.2022.
//

import UIKit

class BaseController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        applyTheme()
    }

    func applyTheme() {
        view.backgroundColor = DesignManager.shared.theme[.background(.main)]
        navigationController?.navigationBar.tintColor = DesignManager.shared.theme[.tintColor(.navigationItem)]
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: DesignManager.shared.theme[.text(.primary)],
            .font: FontFamily.Nunito.regular.font(size: 16)
        ]

        let backBarButton = UIBarButtonItem(
            title: "",
            style: .plain,
            target: nil,
            action: nil
        )

        navigationItem.backBarButtonItem = backBarButton
    }

    @objc
    func goBack() {
        navigationController?.popViewController(animated: true)
    }
}
