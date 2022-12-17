//
//  Settings.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 17.12.2022.
//

enum MethodType {
    case graphic
    case straightSimplex
    case artificialVariables
    case modifiedSimplex
    case binarySimplex

    var title: String {
        switch self {
        case .graphic:
            return L10n.Methods.GraphicMethod.title
        case .straightSimplex:
            return L10n.Methods.StraightSimplex.title
        case .artificialVariables:
            return L10n.Methods.ArtificialVariables.title
        case .modifiedSimplex:
            return L10n.Methods.ModifiedSimplex.title
        case .binarySimplex:
            return L10n.Methods.BinarySimplex.title
        }
    }
}

enum OptimizationType: String {
    case max
    case min
}
