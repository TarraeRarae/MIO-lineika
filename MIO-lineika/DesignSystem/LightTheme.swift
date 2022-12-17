//
//  LightTheme.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 17.12.2022.
//

import UIKit

class LighTheme: Theme {

    var color: (SemanticColor) -> UIColor = {
        switch $0 {
        case .background(let backgroundColor):
            switch backgroundColor {
            case .main:
                return UIColor(hex: "#F6F6F6FF")
            case .tableCell:
                return UIColor(hex: "#FFFFFFFF")
            case .divider:
                return UIColor(hex: "#FFE7FEFF")
            }

        case .text(let textColor):
            switch textColor {
            case .primary:
                return UIColor(hex: "#2D2031FF")
            }
        }
    }
}