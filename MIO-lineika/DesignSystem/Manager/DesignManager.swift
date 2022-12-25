//
//  DesignManager.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 16.12.2022.
//

import UIKit

final class DesignManager {

    // MARK: - Static properties

    static let shared = DesignManager()

    // MARK: - Private properties

    /// Конфигурация для светлой темы
    private let lightTheme = LighTheme()

    // MARK: - Internal properties

    var theme: Theme {
        return lightTheme
    }
}
