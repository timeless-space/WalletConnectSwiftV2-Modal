import SwiftUI
import UIKit

// swiftlint:disable identifier_name
enum Asset: String {

    /// Icons
    case wc_close
    case external_link
    case help
    case wallet

    /// large
    case copy_large
    case qr_large

    /// Images
    case walletconnect_logo
    case wc_logo

    /// Help
    case Browser
    case DAO
    case DeFi
    case ETH
    case Layers
    case Lock
    case Login
    case Network
    case NFT
    case Noun
    case Profile
    case System
}

extension Asset {

    var image: Image {
        Image(self)
    }
}

extension Image {

    init(_ asset: Asset) {
        self.init(asset.rawValue, bundle: .main)
    }
}

extension Asset {

    var uiImage: UIImage {
        UIImage(self)
    }

    var cgImage: CGImage {
        uiImage.cgImage!
    }
}

extension UIImage {

    convenience init(_ asset: Asset) {
        self.init(named: asset.rawValue, in: .main, compatibleWith: .current)!
    }
}
