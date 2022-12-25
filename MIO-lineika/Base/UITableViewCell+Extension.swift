//
//  UITableViewCell+Extension.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 21.12.2022.
//

import UIKit

extension UITableViewCell {
    static var reuseIdentifier: String { String(describing: Self.self) }
}
