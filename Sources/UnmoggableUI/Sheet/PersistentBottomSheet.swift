//
//  PersistentBottomSheet.swift
//  UnmoggableUI
//
//  Created by Lorenzo Cara on 27/01/25.
//
import SwiftUI

public extension View {
    @ViewBuilder
    func persistentBottomSheet<SheetContent: View>(
        initialHeight: CGFloat = 100,
        sheetCornerRadius: CGFloat = 15,
        @ViewBuilder content: @escaping () -> SheetContent
    ) -> some View {
        self
            .modifier(BottomSheetModifier(initialHeight: initialHeight, sheetCornerRadius: sheetCornerRadius, sheetView: content()))
    }
}

// Helper View Modifier
fileprivate struct BottomSheetModifier<SheetContent: View>: ViewModifier {
    var initialHeight: CGFloat
    var sheetCornerRadius: CGFloat
    var sheetView: SheetContent
    // View Properties
    @State private var showSheet: Bool = true
    func body(content: Content) -> some View {
        content
            .sheet(isPresented: $showSheet) {
                sheetView
                    .presentationDetents([.height(initialHeight), .medium, .fraction(0.99)])
                    .presentationCornerRadius(sheetCornerRadius)
                    .presentationBackgroundInteraction(.enabled(upThrough: .medium))
                    .interactiveDismissDisabled()
            }
    }
}

#Preview {
    @Previewable @State var isPresented: Bool = false
    NavigationStack {
        ScrollView {
            Text("Sium")
                .onTapGesture {
                    isPresented.toggle()
                }
            
            Rectangle()
                .frame(height: 200)
                .opacity(isPresented ? 1 : 0)
        }
        .persistentBottomSheet(
            initialHeight: 100,
            sheetCornerRadius: 15) {
            PreviewView()
            }
    }
}

fileprivate struct PreviewView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                HStack {
                    Text("Sium")
                        .frame(maxWidth: .infinity)
                    Text("Sium")
                        .frame(maxWidth: .infinity)
                }
            }
        }
    }
}
