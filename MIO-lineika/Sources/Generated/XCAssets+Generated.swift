// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif
#if canImport(SwiftUI)
  import SwiftUI
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ColorAsset.Color", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetColorTypeAlias = ColorAsset.Color
@available(*, deprecated, renamed: "ImageAsset.Image", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetImageTypeAlias = ImageAsset.Image

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum Asset {
  internal static let accentColor = ColorAsset(name: "AccentColor")
  internal enum Arrows {
    internal static let arrowRight = ImageAsset(name: "arrowRight")
    internal static let chevronRight = ImageAsset(name: "chevronRight")
    internal static let pinkChevronLeft = ImageAsset(name: "pinkChevronLeft")
  }
  internal enum ArtificialVariables {
    internal static let a1 = ImageAsset(name: "a1")
    internal static let a10 = ImageAsset(name: "a10")
    internal static let a11 = ImageAsset(name: "a11")
    internal static let a12 = ImageAsset(name: "a12")
    internal static let a13 = ImageAsset(name: "a13")
    internal static let a14 = ImageAsset(name: "a14")
    internal static let a15 = ImageAsset(name: "a15")
    internal static let a16 = ImageAsset(name: "a16")
    internal static let a2 = ImageAsset(name: "a2")
    internal static let a3 = ImageAsset(name: "a3")
    internal static let a4 = ImageAsset(name: "a4")
    internal static let a5 = ImageAsset(name: "a5")
    internal static let a6 = ImageAsset(name: "a6")
    internal static let a7 = ImageAsset(name: "a7")
    internal static let a8 = ImageAsset(name: "a8")
    internal static let a9 = ImageAsset(name: "a9")
  }
  internal static let baseInformation = ImageAsset(name: "BaseInformation")
  internal enum Brackets {
    internal static let figuralBracket = ImageAsset(name: "figuralBracket")
  }
  internal enum DirectMethod {
    internal static let i1 = ImageAsset(name: "i1")
    internal static let i10 = ImageAsset(name: "i10")
    internal static let i11 = ImageAsset(name: "i11")
    internal static let i12 = ImageAsset(name: "i12")
    internal static let i2 = ImageAsset(name: "i2")
    internal static let i3 = ImageAsset(name: "i3")
    internal static let i4 = ImageAsset(name: "i4")
    internal static let i5 = ImageAsset(name: "i5")
    internal static let i6 = ImageAsset(name: "i6")
    internal static let i7 = ImageAsset(name: "i7")
    internal static let i8 = ImageAsset(name: "i8")
    internal static let i9 = ImageAsset(name: "i9")
  }
  internal enum GraphicMethodImages {
    internal static let l1 = ImageAsset(name: "l1")
    internal static let l2 = ImageAsset(name: "l2")
    internal static let l3 = ImageAsset(name: "l3")
    internal static let l4 = ImageAsset(name: "l4")
    internal static let l5 = ImageAsset(name: "l5")
    internal static let l6 = ImageAsset(name: "l6")
    internal static let l7 = ImageAsset(name: "l7")
  }
  internal enum ModifiedMethod {
    internal static let t1 = ImageAsset(name: "t1")
    internal static let t10 = ImageAsset(name: "t10")
    internal static let t11 = ImageAsset(name: "t11")
    internal static let t12 = ImageAsset(name: "t12")
    internal static let t13 = ImageAsset(name: "t13")
    internal static let t14 = ImageAsset(name: "t14")
    internal static let t15 = ImageAsset(name: "t15")
    internal static let t16 = ImageAsset(name: "t16")
    internal static let t17 = ImageAsset(name: "t17")
    internal static let t18 = ImageAsset(name: "t18")
    internal static let t19 = ImageAsset(name: "t19")
    internal static let t2 = ImageAsset(name: "t2")
    internal static let t20 = ImageAsset(name: "t20")
    internal static let t21 = ImageAsset(name: "t21")
    internal static let t22 = ImageAsset(name: "t22")
    internal static let t23 = ImageAsset(name: "t23")
    internal static let t3 = ImageAsset(name: "t3")
    internal static let t4 = ImageAsset(name: "t4")
    internal static let t5 = ImageAsset(name: "t5")
    internal static let t6 = ImageAsset(name: "t6")
    internal static let t7 = ImageAsset(name: "t7")
    internal static let t8 = ImageAsset(name: "t8")
    internal static let t9 = ImageAsset(name: "t9")
  }
  internal enum Navigation {
    internal static let backButton = ImageAsset(name: "backButton")
  }
  internal enum Radiobutton {
    internal static let radiobuttonDisabled = ImageAsset(name: "radiobuttonDisabled")
    internal static let radiobuttonEnabled = ImageAsset(name: "radiobuttonEnabled")
  }
  internal enum Tabbar {
    internal static let calculationItemDisabled = ImageAsset(name: "calculationItemDisabled")
    internal static let calculationItemEnabled = ImageAsset(name: "calculationItemEnabled")
    internal static let photoItemDisabled = ImageAsset(name: "photoItemDisabled")
    internal static let photoItemEnabled = ImageAsset(name: "photoItemEnabled")
    internal static let theoryItemDisabled = ImageAsset(name: "theoryItemDisabled")
    internal static let theoryItemEnabled = ImageAsset(name: "theoryItemEnabled")
  }
  internal static let directMethod = ImageAsset(name: "directMethod")
  internal static let graphicalMethod = ImageAsset(name: "graphicalMethod")
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

internal final class ColorAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  internal private(set) lazy var color: Color = {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }()

  #if os(iOS) || os(tvOS)
  @available(iOS 11.0, tvOS 11.0, *)
  internal func color(compatibleWith traitCollection: UITraitCollection) -> Color {
    let bundle = BundleToken.bundle
    guard let color = Color(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }
  #endif

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  internal private(set) lazy var swiftUIColor: SwiftUI.Color = {
    SwiftUI.Color(asset: self)
  }()
  #endif

  fileprivate init(name: String) {
    self.name = name
  }
}

internal extension ColorAsset.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init?(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
internal extension SwiftUI.Color {
  init(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    self.init(asset.name, bundle: bundle)
  }
}
#endif

internal struct ImageAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Image = UIImage
  #endif

  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, macOS 10.7, *)
  internal var image: Image {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let name = NSImage.Name(self.name)
    let image = (bundle == .main) ? NSImage(named: name) : bundle.image(forResource: name)
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }

  #if os(iOS) || os(tvOS)
  @available(iOS 8.0, tvOS 9.0, *)
  internal func image(compatibleWith traitCollection: UITraitCollection) -> Image {
    let bundle = BundleToken.bundle
    guard let result = Image(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }
  #endif

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  internal var swiftUIImage: SwiftUI.Image {
    SwiftUI.Image(asset: self)
  }
  #endif
}

internal extension ImageAsset.Image {
  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, *)
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init?(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = BundleToken.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
internal extension SwiftUI.Image {
  init(asset: ImageAsset) {
    let bundle = BundleToken.bundle
    self.init(asset.name, bundle: bundle)
  }

  init(asset: ImageAsset, label: Text) {
    let bundle = BundleToken.bundle
    self.init(asset.name, bundle: bundle, label: label)
  }

  init(decorative asset: ImageAsset) {
    let bundle = BundleToken.bundle
    self.init(decorative: asset.name, bundle: bundle)
  }
}
#endif

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
