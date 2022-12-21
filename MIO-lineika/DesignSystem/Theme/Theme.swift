//
//  Theme.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 16.12.2022.
//

import UIKit

protocol Theme: AnyObject {
    var color: (SemanticColor) -> UIColor { get }
}

extension Theme {

    subscript(_ color: SemanticColor) -> UIColor {
        self.color(color)
    }
}
