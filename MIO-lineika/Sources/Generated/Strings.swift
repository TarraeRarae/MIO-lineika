// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  internal enum App {
    /// МИО-Линейка
    internal static let title = L10n.tr("Localize", "App.title", fallback: "МИО-Линейка")
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
