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
        case tableCell
        case divider
    }

    enum TextColor {
        case primary
        case secondary
    }

    case background(BackgroundColor)
    case text(TextColor)
}
