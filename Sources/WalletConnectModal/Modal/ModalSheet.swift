import SwiftUI

public struct ModalSheet: View {
    @ObservedObject var viewModel: ModalViewModel

    @Environment(\.verticalSizeClass) var verticalSizeClass

    @State var searchEditing = false

    public var body: some View {
        VStack(spacing: 0) {
            modalHeader()

            VStack(spacing: 0) {
                contentHeader()
                content()
            }
            .frame(maxWidth: .infinity)
            .background(Color.background1)
            .cornerRadius(30, corners: [.topLeft, .topRight])
        }
        .background(
            VStack(spacing: 0) {
                Color.white
                    .frame(height: 90)
                    .cornerRadius(8, corners: [[.topLeft, .topRight]])
                Color.background1
            }
        )
        .toastView(toast: $viewModel.toast)
        .if(verticalSizeClass == .compact) {
            $0.padding(.horizontal, 80)
        }
        .onAppear {
            Task {
                await viewModel.fetchWallets()
                await viewModel.createURI()
            }
        }
    }

    private func modalHeader() -> some View {
        HStack(spacing: 0) {
            Image(.walletconnect_logo)
                .resizable()
                .renderingMode(.template)
                .foregroundColor(Color.black)
                .scaledToFit()
                .frame(width: 180)
                .padding(.leading, 10)

            Spacer()

            closeButton()
                .padding(.trailing, 10)
        }
        .frame(height: 48)
    }

    private func contentHeader() -> some View {
        HStack(spacing: 0) {
            if viewModel.destinationStack.count > 1 {
                backButton()
            }

            Spacer()

            switch viewModel.destination {
            case .welcome:
                qrButton()
            case .qr, .walletDetail:
                copyButton()
            default:
                EmptyView()
            }
        }
        .animation(.default, value: viewModel.destination)
        .foregroundColor(.accent)
        .frame(height: 60)
        .overlay(
            VStack {
                if viewModel.destination.hasSearch {
                    HStack {
                        Image(systemName: "magnifyingglass")
                        TextField("Search", text: $viewModel.searchTerm, onEditingChanged: { editing in
                            self.searchEditing = editing
                        })
                        .transform { view in
                            view.autocapitalization(.none)
                        }
                    }
                    .padding(.vertical, 4)
                    .padding(.horizontal, 10)
                    .background(Color.background3)
                    .foregroundColor(searchEditing ? .foreground1 : .foreground3)
                    .cornerRadius(28)
                    .overlay(
                        RoundedRectangle(cornerRadius: 28)
                            .stroke(searchEditing ? Color.accent : Color.thinOverlay, lineWidth: 1)
                    )
                    .onDisappear {
                        searchEditing = false
                    }
                    .padding(.horizontal, 50)
                } else {
                    Text(viewModel.destination.contentTitle)
                        .font(.system(size: 20).weight(.semibold))
                        .foregroundColor(.foreground1)
                        .padding(.horizontal, 50)
                }
            }
        )
    }

    @ViewBuilder
    private func welcome() -> some View {
        WalletList(
            wallets: .init(get: {
                viewModel.filteredWallets
            }, set: { _ in }),
            destination: .init(get: {
                viewModel.destination
            }, set: { _ in }),
            navigateTo: viewModel.navigateTo(_:),
            onListingTap: { viewModel.onListingTap($0) }
        )
    }

    private func qrCode() -> some View {
        VStack {
            if let uri = viewModel.uri {
                WCQRCodeView(uri: uri)
            } else {
                WCActivityIndicator(isAnimating: .constant(true))
            }
        }
    }

    @ViewBuilder
    private func content() -> some View {
        switch viewModel.destination {
        case .welcome,
                .viewAll:
            welcome()
        case .qr:
            qrCode()
                .padding(.bottom, 20)
        case .getWallet:
            GetAWalletView(
                wallets: Array(viewModel.wallets.prefix(6)),
                onWalletTap: viewModel.openAppstore(wallet:),
                navigateToExternalLink: viewModel.navigateToExternalLink(_:)
            )
            .frame(minHeight: verticalSizeClass == .compact ? 200 : 550)
            .padding(.bottom, 20)

        case let .walletDetail(wallet):
            WCWalletDetail(
                viewModel: .init(
                    wallet: wallet,
                    deeplinkHandler: viewModel
                )
            )
        }
    }
}

extension ModalSheet {
    private func closeButton() -> some View {
        Button {
            viewModel.onCloseButton()
        } label: {
            Image(Asset.wc_close)
                .padding(8)
        }
        .buttonStyle(CircuralIconButtonStyle())
    }

    private func backButton() -> some View {
        Button {
            withAnimation {
                viewModel.onBackButton()
            }
        } label: {
            Image(systemName: "chevron.backward")
                .padding(20)
        }
    }

    private func qrButton() -> some View {
        Button {
            withAnimation {
                viewModel.navigateTo(.qr)
            }
        } label: {
            Image(.qr_large)
                .padding()
        }
    }

    private func copyButton() -> some View {
        Button {
            viewModel.onCopyButton()
        } label: {
            Image(.copy_large)
                .padding()
        }
    }
}
