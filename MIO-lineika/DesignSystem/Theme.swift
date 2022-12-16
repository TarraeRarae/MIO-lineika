//
//  Theme.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 16.12.2022.
//

import UIKit

public protocol Theme: AnyObject {
    func color(_ color: Color) -> UIColor
}

public class LighTheme: Theme {

    // MARK: - Public functions

    public func color(_ color: Color) -> UIColor {
        return color.color
    }
}
