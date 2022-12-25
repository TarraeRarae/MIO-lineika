//
//  CustomTabbar.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 25.12.2022.
//

import UIKit

class CustomTabbar: UITabBar {

    private var shapeLayer: CALayer?

    override func draw(_ rect: CGRect) {
        addShape()
        addShadow()
    }

    func createPath() -> CGPath {
        let path = UIBezierPath(
            roundedRect: CGRect(x: 0, y: -20, width: frame.width, height: frame.height + 20),
            cornerRadius: 30
        )

        return path.cgPath
    }

    private func addShape() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = createPath()
        shapeLayer.strokeColor = DesignManager.shared.theme[.background(.tabbar)].cgColor
        shapeLayer.fillColor = DesignManager.shared.theme[.background(.tabbar)].cgColor
        shapeLayer.lineWidth = 1.0

        if let oldShapeLayer = self.shapeLayer {
            layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
        } else {
            layer.insertSublayer(shapeLayer, at: 0)
        }

        self.shapeLayer = shapeLayer
    }

    private func addShadow() {
        layer.shadowColor = DesignManager.shared.theme[.background(.shadow)].cgColor
        layer.shadowOffset = CGSize(width: 0, height: 10)
        layer.shadowRadius = 100
        layer.shadowOpacity = 0.12
    }
}

extension UITabBar {

    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = 74
        return sizeThatFits
    }
}

