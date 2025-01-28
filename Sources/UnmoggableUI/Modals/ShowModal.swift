import SwiftUI

public struct ModalSupportView <Content: View>: View {
    @Binding var showModal: Bool
    @ViewBuilder var content: Content
    
    public var body: some View {
        ZStack {
            if showModal {
                Color.black.ignoresSafeArea().opacity(0.5)
                    .transition(.opacity.animation(.smooth))
                    .onTapGesture {
                        showModal = false
                    }
                    .zIndex(1)
                content
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea()
                    .zIndex(2)
            }
        }
        .zIndex(9999)
        .animation(.bouncy, value: showModal)
    }
}

public extension View {
    /// Apply on the NavStack or views that cover the entire screen.
    /// Shows an injected modal over a dark background.
    /// - Parameters:
    ///   - showModal: boolean to control the presentation
    ///   - transition: transition with which will get presented
    ///   - content: modal to present
    func showModal(_ showModal: Binding<Bool>, transition: AnyTransition, @ViewBuilder content: () -> some View) -> some View {
        self
            .overlay {
                ModalSupportView(showModal: showModal) {
                    content()
                        .transition(transition)
                }
            }
    }
}

// Usage example
#Preview {
    @Previewable @State var showModal: Bool = false
    NavigationStack{
        VStack {
            Button("Okay"){
                showModal.toggle()
            }
        }
    }
    .showModal(
        $showModal,
        transition: .slide) {
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 100, height: 100)
        }
}
