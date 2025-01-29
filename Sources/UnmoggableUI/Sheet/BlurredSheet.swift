//
//  BlurredSheet.swift
//  Hairmax
//
//  Created by Lorenzo Cara on 28/01/25.
//

import SwiftUI

public extension View {
    // blurredSheet
    func blurredSheet<Content: View> (_ style: AnyShapeStyle, show: Binding<Bool>, onDismiss: @escaping () -> (), @ViewBuilder content: @escaping () -> Content) -> some View {
        self.sheet(isPresented: show, onDismiss: onDismiss) {
            content()
                .background(RemoveBackgroundColor())
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(
                    Rectangle()
                        .fill(style)
                        .ignoresSafeArea(.container, edges: .all)
                )
        }
    }
    
    //persistentBlurredBottomSheet
    func persistentBlurredBottomSheetfunc<Content: View> (_ style: AnyShapeStyle,initialHeight: CGFloat, presentationDetents: Set<PresentationDetent>? = nil, sheetCornerRadius: CGFloat? = nil , showDragIndicator: Visibility? ,@ViewBuilder content: @escaping () -> Content) -> some View {
        self
            .sheet(isPresented: .constant(true), onDismiss: {}) {
                content()
                    .background(RemoveBackgroundColor())
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(
                        Rectangle()
                            .fill(style)
                            .ignoresSafeArea(.container, edges: .all)
                    )
                    .presentationDetents(presentationDetents ?? [.height(initialHeight), .medium, .fraction(0.99)])
                    .presentationCornerRadius(sheetCornerRadius)
                    .presentationBackgroundInteraction(.enabled(upThrough: .medium))
                    .interactiveDismissDisabled()
                    .presentationDragIndicator(showDragIndicator ?? .automatic)
            }
    }
    
}


fileprivate struct RemoveBackgroundColor: UIViewRepresentable {
    
    func makeUIView(context: Context) -> UIView {
        return UIView()
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        DispatchQueue.main.async {
            uiView.superview?.superview?.backgroundColor = .clear
        }
    }
    
}

