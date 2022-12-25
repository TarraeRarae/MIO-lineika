//
//  ConfigurableItem.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 16.12.2022.
//

import UIKit

protocol ConfigurableItem: AnyObject {
    func configure(_ params: Any)
}
