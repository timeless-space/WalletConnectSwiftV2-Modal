import SwiftUI

enum AssetColor: String {
    case foreground1
    case foreground2
    case foreground3
    case foregroundInverse
    case background1
    case background2
    case background3
    case negative
    case thickOverlay
    case thinOverlay
    case accent
}

extension Color {

    init(_ asset: AssetColor) {
        self.init(asset.rawValue, bundle: .main)
    }

    static let foreground1 = Color(AssetColor.foreground1)
    static let foreground2 = Color(AssetColor.foreground2)
    static let foreground3 = Color(AssetColor.foreground3)
    static let foregroundInverse = Color(AssetColor.foregroundInverse)
    static let background1 = Color(AssetColor.background1)
    static let background2 = Color(AssetColor.background2)
    static let background3 = Color(AssetColor.background3)
    static let negative = Color(AssetColor.negative)
    static let thickOverlay = Color(AssetColor.thickOverlay)
    static let thinOverlay = Color(AssetColor.thinOverlay)
    static var accent = Color(AssetColor.accent)
}

extension UIColor {

    convenience init(_ asset: AssetColor) {
        self.init(named: asset.rawValue, in: .main, compatibleWith: nil)!
    }
}

extension AssetColor {

    var uiColor: UIColor {
        UIColor(self)
    }
}

extension AssetColor {

    var swituiColor: Color {
        Color(self)
    }
}
