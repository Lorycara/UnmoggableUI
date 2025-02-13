import SwiftUI

public struct CarouselView<T: Hashable, V: View>: View {
    let avatars: [T]
    let content: (T) -> V
    
    @Binding private var selection: T?
    @State private var internalSelection: T?
    @Namespace private var selectionCircle

    public init(avatars: [T], selection: Binding<T?>? = nil, content: @escaping (T) -> V) {
        self.avatars = avatars
        self._selection = selection ?? .constant(nil)
        self.content = content
    }

    private var computedSelection: Binding<T?> {
        Binding(
            get: { selection ?? internalSelection },
            set: { newValue in
                if selection != nil {
                    selection = newValue
                } else {
                    internalSelection = newValue
                }
            }
        )
    }

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
        .animation(.bouncy, value: computedSelection.wrappedValue)
    }
}

// MARK: COMPONENTS
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
        .scrollPosition(id: computedSelection)
    }
    
    private var bullets: some View {
        HStack {
            ForEach(avatars, id: \.self) { avatar in
                Circle()
                    .foregroundStyle(.secondary.opacity(0.5))
                    .opacity(computedSelection.wrappedValue != avatar ? 1 : 0)
                    .overlay {
                        if avatar == computedSelection.wrappedValue {
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
        if computedSelection.wrappedValue == nil {
            computedSelection.wrappedValue = avatars.first
        }
    }
}

#Preview {
    @State var selection: String?
    let imagesurls = ["ciao", "sium", "https://image.shutterstock.com/image-photo/young-man-boho-style-shirt-260nw-2009943446.jpg"]
    
    VStack {
        CarouselView(avatars: imagesurls, selection: $selection) { text in
            Text(text)
        }
        CarouselView(avatars: imagesurls) { text in
            Text(text)
        }
    }
}
