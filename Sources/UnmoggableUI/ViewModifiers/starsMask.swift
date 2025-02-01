
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
                            .frame(width: CGFloat(starIndex + 1 ) / 5 * geometry.size.width, height: 25)
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
