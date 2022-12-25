//
//  Coordinator.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 16.12.2022.
//

import UIKit

protocol BaseCoordinator: AnyObject {
    func start(nav: UINavigationController) -> UIViewController
}
