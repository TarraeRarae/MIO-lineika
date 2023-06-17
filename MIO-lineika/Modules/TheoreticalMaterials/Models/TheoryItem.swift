//
//  TheoryItem.swift
//  MIO-lineika
//
//  Created by Misha Fedorov on 17.06.2023.
//

import Foundation

enum TheoryItems: Identifiable, CaseIterable {
    
    var id: String {
        return UUID().uuidString
    }
    
    case graphicMethod
    case directSimplexMethod
    case dualSimplexMethod
    case modifiedSimplexMethod
    case methodOfArtificialVariables
}

extension TheoryItems {
    var isEnabled: Bool {
        switch self {
        case .graphicMethod:
            return true
        case .directSimplexMethod:
            return true
        case .dualSimplexMethod:
            return false
        case .modifiedSimplexMethod:
            return false
        case .methodOfArtificialVariables:
            return false
        }
    }
    
    var title: String {
        switch self {
        case .graphicMethod:
            return "Графический метод"
        case .directSimplexMethod:
            return "Прямой симплекс метод"
        case .dualSimplexMethod:
            return "Метод искусственных переменных"
        case .modifiedSimplexMethod:
            return "Модифицированный симплекс метод"
        case .methodOfArtificialVariables:
            return "Двойственный симплекс метод"
        }
    }
}
