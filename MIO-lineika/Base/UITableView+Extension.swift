//
//  UITableView+Extension.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 17.12.2022.
//

import UIKit

extension UITableView {

    func register(_ cells: [TableViewCell.Type]) {
        cells.forEach { cell in
            register(cell, forCellReuseIdentifier: String(describing: cell))
        }
    }
}
