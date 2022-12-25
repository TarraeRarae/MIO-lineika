//
//  CustomTabBar.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 25.12.2022.
//

import UIKit

class CustomTabBar: UITabBar {

    // MARK: - Constants

    private enum Constants {
        static let horizontalOffset: CGFloat = 20
        static let cornerRadius: CGFloat = 30
    }

    // MARK: - Private properties

    private var shapeLayer: CALayer?

    // MARK: - Lifecycle

    override func draw(_ rect: CGRect) {
        addShape()
        addShadow()
    }
}

// MARK: - Private methods

private extension CustomTabBar {

    func createPath() -> CGPath {
        let path = UIBezierPath(
            roundedRect: CGRect(
                x: 0,
                y: -Constants.horizontalOffset,
                width: frame.width,
                height: frame.height + Constants.horizontalOffset
            ),
            cornerRadius: Constants.cornerRadius
        )

        return path.cgPath
    }

    func addShape() {
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

    func addShadow() {
        layer.shadowColor = DesignManager.shared.theme[.background(.shadow)].cgColor
        layer.shadowOffset = CGSize(width: 0, height: 10)
        layer.shadowRadius = 100
        layer.shadowOpacity = 0.12
    }
}

