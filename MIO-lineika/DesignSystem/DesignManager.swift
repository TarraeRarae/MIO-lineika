//
//  DesignManager.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 16.12.2022.
//

import UIKit

public final class DesignManager {

    // MARK: - Static properties

    static let shared = DesignManager()

    // MARK: - Private properties

    private let lightTheme = LighTheme()

    // MARK: - Public properties

    public var theme: Theme {
        return lightTheme
    }
}
