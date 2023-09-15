import SwiftUI

extension View {
    func transform(@ViewBuilder _ transform: (Self) -> some View) -> some View {
        transform(self)
    }
}
