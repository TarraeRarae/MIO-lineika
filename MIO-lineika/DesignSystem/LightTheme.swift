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
                return UIColor(hex: "#FD79A866")
            }

        case .text(let textColor):
            switch textColor {
            case .primary:
                return UIColor(hex: "#2D2031FF")
            case .secondary:
                return UIColor(hex: "#A5A0A6FF")
            }
        case .mainButton(let buttonColor):
            switch buttonColor {
            case .enabled:
                return UIColor(hex: "#FD79A8FF")
            case .disabled:
                return UIColor(hex: "#C5C0C6FF")
            }
        }
    }
}
