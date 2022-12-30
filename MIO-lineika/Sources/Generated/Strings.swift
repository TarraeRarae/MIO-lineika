// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  internal enum Alert {
    internal enum Action {
      /// ОК
      internal static let ok = L10n.tr("Localize", "Alert.action.ok", fallback: "ОК")
    }
  }
  internal enum App {
    /// МИО-Линейка
    internal static let title = L10n.tr("Localize", "App.title", fallback: "МИО-Линейка")
  }
  internal enum Error {
    /// Ошибка
    internal static let title = L10n.tr("Localize", "Error.title", fallback: "Ошибка")
    internal enum Constraints {
      /// Максимально допустимое число ограничений равно 3
      internal static let maxThree = L10n.tr("Localize", "Error.constraints.maxThree", fallback: "Максимально допустимое число ограничений равно 3")
    }
    internal enum TextField {
      /// Вы можете ввести только одну цифру от 1 до 9
      internal static let maxNine = L10n.tr("Localize", "Error.textField.maxNine", fallback: "Вы можете ввести только одну цифру от 1 до 9")
      /// Вы можете ввести число только в диапазоне от 0 до 99
      internal static let onlyNumbers = L10n.tr("Localize", "Error.textField.onlyNumbers", fallback: "Вы можете ввести число только в диапазоне от 0 до 99")
      /// Вы можете ввести только одну цифру 2 или 3
      internal static let onlyTwoAndThree = L10n.tr("Localize", "Error.textField.onlyTwoAndThree", fallback: "Вы можете ввести только одну цифру 2 или 3")
    }
    internal enum Variables {
      /// Максимально допустимое число переменных равно 3
      internal static let maxThree = L10n.tr("Localize", "Error.variables.maxThree", fallback: "Максимально допустимое число переменных равно 3")
    }
  }
  internal enum MainButton {
    internal enum Conclusion {
      /// Решение
      internal static let title = L10n.tr("Localize", "MainButton.conclusion.title", fallback: "Решение")
    }
    internal enum Onward {
      /// Далее
      internal static let title = L10n.tr("Localize", "MainButton.onward.title", fallback: "Далее")
    }
  }
  internal enum MainScreen {
    internal enum Header {
      /// Выберите метод, количество переменных и ограничений, вид оптимизации, а затем заполните коэффициенты при переменных.
      internal static let subtitle = L10n.tr("Localize", "MainScreen.header.subtitle", fallback: "Выберите метод, количество переменных и ограничений, вид оптимизации, а затем заполните коэффициенты при переменных.")
      /// Решение задач линейного программирования
      internal static let title = L10n.tr("Localize", "MainScreen.header.title", fallback: "Решение задач линейного программирования")
    }
  }
  internal enum MethodConfigurationScreen {
    internal enum ConstraintsSystemCell {
      /// Система линейных ограничений
      internal static let title = L10n.tr("Localize", "MethodConfigurationScreen.constraintsSystemCell.title", fallback: "Система линейных ограничений")
    }
    internal enum FunctionCell {
      /// Целевая функция
      internal static let title = L10n.tr("Localize", "MethodConfigurationScreen.functionCell.title", fallback: "Целевая функция")
    }
    internal enum Header {
      /// Введите целые числа или обыкновенные дроби.
      /// Например, для выражения 2x1-x2≤12, необходимо ввести: 2;-1;12. Для выражения x1≥9: 1;0;≥9
      internal static let subtitle = L10n.tr("Localize", "MethodConfigurationScreen.header.subtitle", fallback: "Введите целые числа или обыкновенные дроби.\nНапример, для выражения 2x1-x2≤12, необходимо ввести: 2;-1;12. Для выражения x1≥9: 1;0;≥9")
    }
    internal enum NavigationBar {
      /// Прямой симплекс метод
      internal static let title = L10n.tr("Localize", "MethodConfigurationScreen.navigationBar.title", fallback: "Прямой симплекс метод")
    }
    internal enum TextCell {
      /// Ограничения по переменным
      internal static let title = L10n.tr("Localize", "MethodConfigurationScreen.textCell.title", fallback: "Ограничения по переменным")
    }
  }
  internal enum Methods {
    /// Метод решения
    internal static let title = L10n.tr("Localize", "Methods.title", fallback: "Метод решения")
    internal enum ArtificialVariables {
      /// Метод искусственных переменных
      internal static let title = L10n.tr("Localize", "Methods.artificialVariables.title", fallback: "Метод искусственных переменных")
    }
    internal enum BinarySimplex {
      /// Двойственный симплекс-метод
      internal static let title = L10n.tr("Localize", "Methods.binarySimplex.title", fallback: "Двойственный симплекс-метод")
    }
    internal enum GraphicMethod {
      /// Графический метод
      internal static let title = L10n.tr("Localize", "Methods.graphicMethod.title", fallback: "Графический метод")
    }
    internal enum ModifiedSimplex {
      /// Модифицированный симплекс-метод
      internal static let title = L10n.tr("Localize", "Methods.modifiedSimplex.title", fallback: "Модифицированный симплекс-метод")
    }
    internal enum StraightSimplex {
      /// Прямой симплекс метод
      internal static let title = L10n.tr("Localize", "Methods.straightSimplex.title", fallback: "Прямой симплекс метод")
    }
  }
  internal enum MockScreen {
    /// Раздел в разработке
    internal static let title = L10n.tr("Localize", "MockScreen.title", fallback: "Раздел в разработке")
  }
  internal enum Optimizations {
    /// Вид оптимизации
    internal static let title = L10n.tr("Localize", "Optimizations.title", fallback: "Вид оптимизации")
  }
  internal enum VariableConstaints {
    internal enum Constraints {
      /// Количество ограничений
      internal static let title = L10n.tr("Localize", "VariableConstaints.constraints.title", fallback: "Количество ограничений")
    }
    internal enum Variables {
      /// Количество переменных
      internal static let title = L10n.tr("Localize", "VariableConstaints.variables.title", fallback: "Количество переменных")
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
