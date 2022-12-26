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
            case .cell:
                return UIColor(hex: "#FFFFFFFF")
            case .divider:
                return UIColor(hex: "#FD79A866")
            case .textFieldBorder:
                return UIColor(hex: "#727272FF")
            case .shadow:
                return UIColor(hex: "#1B1738FF")
            case .tabbar:
                return UIColor(hex: "#FFFFFFFF")
            }

        case .text(let textColor):
            switch textColor {
            case .primary:
                return UIColor(hex: "#2D2031FF")
            case .secondary:
                return UIColor(hex: "#A5A0A6FF")
            case .error:
                return UIColor(hex: "#ED4337FF")
            }

        case .mainButton(let buttonColor):
            switch buttonColor {
            case .enabled:
                return UIColor(hex: "#FD79A8FF")
            case .disabled:
                return UIColor(hex: "#C5C0C6FF")
            }
            
        case .tintColor(let tintColor):
            switch tintColor {
            case .tabbarItem:
                return UIColor(hex: "#FD79A8FF")
            }
        }
    }
}
