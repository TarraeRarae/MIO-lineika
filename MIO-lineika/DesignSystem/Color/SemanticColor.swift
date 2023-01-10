//
//  SemanticColor.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 16.12.2022.
//

import UIKit

enum SemanticColor {

    enum BackgroundColor {
        case main
        case cell
        case divider
        case textFieldBorder
        case shadow
        case tabbar
    }

    enum TextColor {
        case primary
        case secondary
        case error
    }

    enum MainButtonColor {
        case enabled
        case disabled
    }

    enum TintColor {
        case tabbarItem
        case navigationItem
    }

    case background(BackgroundColor)
    case text(TextColor)
    case mainButton(MainButtonColor)
    case tintColor(TintColor)
}
