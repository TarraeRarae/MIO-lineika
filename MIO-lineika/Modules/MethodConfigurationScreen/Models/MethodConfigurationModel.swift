//
//  MethodConfigurationModel.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 26.12.2022.
//

import Foundation

struct MethodConfigurationModel {

    /// Метод решения
    let method: MethodType

    /// Кол-во переменных
    let variables: Int

    /// Кол-во ограничений
    let constraints: Int

    /// Вид оптимизации
    let optimization: OptimizationType
}
