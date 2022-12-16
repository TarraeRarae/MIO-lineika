//
//  BaseController.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 16.12.2022.
//

import UIKit

class BaseController: UIViewController {

    override public func viewDidLoad() {
        super.viewDidLoad()
        applyTheme()
    }

    func applyTheme() {
        view.backgroundColor = DesignManager.shared.theme.color(.background(.main))
    }
}
