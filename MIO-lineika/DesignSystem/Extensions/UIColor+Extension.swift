//
//  UIColor+Extension.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 16.12.2022.
//

import UIKit

public extension UIColor {

    convenience init(hex: String) {
        let red, green, blue, alpha: CGFloat

        if !hex.hasPrefix("#") {
            fatalError("Hex color # is necessary")
        }
        let start = hex.index(hex.startIndex, offsetBy: 1)
        let hexColor = String(hex[start...])

        if hexColor.count == 8 {
            let scanner = Scanner(string: hexColor)
            var hexNumber: UInt64 = 0
            
            if scanner.scanHexInt64(&hexNumber) {
                red = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                green = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                blue = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                alpha = CGFloat(hexNumber & 0x000000ff) / 255
                
                self.init(red: red, green: green, blue: blue, alpha: alpha)
                return
            }
        }
        fatalError("Hex color must have 8 legth without #")
    }
}
