//
//  CarouselView.swift
//  AIChatCourse
//
//  Created by Lorenzo Cara on 10/01/25.
//

import SwiftUI
// INJECT A VIEW
// USE A GENERIC

/// Iterates over the array creating a page for each item. The page is injected
public struct CarouselView<T: Hashable, V: View>: View {
    let avatars: [T]
    let content: (T) -> V
    
    // MARK: LOGIC
    @State private var selection: T?
    @Namespace private var selectionCircle
    
    public var body: some View {
        VStack {
            pagingScroll
                .onChange(of: avatars.count, { _, _ in
                    updateSelection()
                })
                .onAppear {
                    updateSelection()
                }
            
            bullets
        }
        .frame(height: 200)
        .animation(.bouncy, value: selection)
    }
}

#Preview {
//    CarouselView(avatars: AvatarModel.mocks, content: { HeroCellView(avatar: $0)})
}

// MARK: COMPONENTSs
extension CarouselView {
    private var pagingScroll: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 0) {
                ForEach(avatars, id: \.self) { avatar in
                    content(avatar)
                        .padding(.horizontal)
                        .scrollTransition(.interactive.threshold(.visible(0.95)), transition: { content, phase in
                            content
                                .scaleEffect(phase.isIdentity ? 1 : 0.9)
                        })
                        .containerRelativeFrame(.horizontal, alignment: .center)
                }
            }
            
        }
        .scrollIndicators(.hidden)
        .scrollTargetLayout()
        .scrollTargetBehavior(.paging)
        .scrollPosition(id: $selection)
    }
    private var bullets: some View {
        HStack {
            ForEach(avatars, id: \.self) { avatar in
                Circle()
                    .foregroundStyle(.secondary.opacity(0.5))
                    .opacity(selection != avatar ? 1 : 0)
                    .overlay {
                        if avatar == selection {
                            Circle()
                                .foregroundStyle(Color.accentColor)
                                .matchedGeometryEffect(id: "selectionCircle", in: selectionCircle)
                        }
                    }
                    .frame(width: 8, height: 8)
            }
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }
}

// MARK: LOGIC
extension CarouselView {
    private func updateSelection() {
        if selection == nil {
            selection = avatars.first
        }
    }
}
