//
//  Color.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 16.12.2022.
//

import UIKit

public enum Color {

    public enum BackgroundColorType {
        case main
        case tableCell
    }

    public enum TextColorType {
        case primary
    }

    case background(BackgroundColorType)
    case text(TextColorType)

    var color: UIColor {
        switch self {
        case .background(let backgroundColorType):
            switch backgroundColorType {
            case .main:
                return UIColor(hex: "#F6F6F6FF")
            case .tableCell:
                return UIColor(hex: "#FFFFFFFF")
            }

        case .text(let textColorType):
            switch textColorType {
            case .primary:
                return UIColor(hex: "#2D2031FF")
            }
        }
    }
}
