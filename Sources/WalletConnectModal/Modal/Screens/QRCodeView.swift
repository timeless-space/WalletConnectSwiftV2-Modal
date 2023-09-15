import QRCode
import SwiftUI

struct WCQRCodeView: View {

    @State var uri: String

    var body: some View {
        let size: CGSize = .init(
            width: UIScreen.main.bounds.width - 20,
            height: UIScreen.main.bounds.height * 0.4
        )

        let height: CGFloat = min(size.width, size.height)

        render(
            content: uri,
            size: .init(width: height * UIScreen.main.scale, height: height * UIScreen.main.scale)
        )
        .resizable()
        .aspectRatio(contentMode: .fit)
        .colorScheme(.light)
        .frame(width: height, height: height)
    }

    private func render(content: String, size: CGSize) -> Image {
        let doc = QRCode.Document(
            utf8String: content,
            errorCorrection: .high
        )
        doc.design.backgroundColor(UIColor.clear.cgColor)
        doc.design.shape.eye = QRCode.EyeShape.Squircle()
        doc.design.shape.pupil = QRCode.PupilShape.Squircle()
        doc.design.shape.onPixels = QRCode.PixelShape.Circle(insetFraction: 0.35)
        doc.design.style.onPixels = QRCode.FillStyle.Solid(UIColor.white.cgColor)

        return doc.imageUI(
            size, label: Text("QR code with URI")
        )!
    }
}

typealias Screen = UIScreen

extension WCQRCodeView {
    var foreground1: UIColor {
        UIColor(AssetColor.foreground1)
    }

    var background1: UIColor {
        UIColor(AssetColor.background1)
    }
}
