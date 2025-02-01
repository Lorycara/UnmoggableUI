
import SwiftUI

struct yellowStartsViewModifier: ViewModifier {
    var starIndex: Int
    var starsColor: Color
    
    func body(content: Content) -> some View {
        content
            .overlay(
                ZStack(alignment: .leading){
                    GeometryReader{ geometry in
                        Rectangle()
                            .frame(width: CGFloat(starIndex + 1 ) / 5 * geometry.size.width, height: geometry.size.height)
                            .foregroundStyle(starsColor)
                    }
                    
                }
                    .mask(content)
                    .allowsHitTesting(false)
                ,
                alignment: .leading)
    }
}

extension View {
    public func starsMask(starIndex: Int, starsColor: Color = .yellow) -> some View {
        modifier(yellowStartsViewModifier(starIndex: starIndex, starsColor: starsColor))
    }
}

#Preview {
    @Previewable @State var starIndex: Int = 0
    ZStack {
        HStack(spacing: 20){
            ForEach(0..<5){ index in
                Image(systemName: "star.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .onTapGesture {
                        withAnimation(.spring()) {
                            starIndex = index
                        }
                    }
            }
        }
    }
    .starsMask(starIndex: starIndex)
}
