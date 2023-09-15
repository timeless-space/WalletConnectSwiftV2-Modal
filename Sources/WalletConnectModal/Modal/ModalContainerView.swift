import SwiftUI

struct ModalContainerView: View {
    @Environment(\.presentationMode) var presentationMode

    @State var showModal = false

    var body: some View {
        VStack(spacing: 0) {
            Color.clear

            if showModal {
                ModalSheet(
                    viewModel: .init(
                        isShown: $showModal,
                        interactor: DefaultModalSheetInteractor()
                    )
                )
                .environment(\.projectId, WalletConnectModal.config.projectId)
                .transition(.move(edge: .bottom))
                .animation(.spring(), value: showModal)
            }
        }
        .background(
            Color.thickOverlay
                .colorScheme(.light)
                .opacity(showModal ? 1 : 0)
                .transform {
                    $0.onTapGesture {
                        withAnimation {
                            showModal = false
                        }
                    }
                }
        )
        .onChangeBackported(of: showModal, perform: { newValue in
            if newValue == false {
                withAnimation {
                    dismiss()
                }
            }
        })
        .onAppear {
            withAnimation {
                showModal = true
            }
        }
    }

    private func dismiss() {
        // Small delay so the sliding transition can happen before cross disolve starts
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            presentationMode.wrappedValue.dismiss()
        }
    }
}
