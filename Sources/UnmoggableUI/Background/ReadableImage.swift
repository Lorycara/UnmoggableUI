import Foundation
import SwiftUI

struct ReadableImage: ViewModifier {
    
    var shadowColor: Color = .black.opacity(0.8)

    public func body(content: Content) -> some View {
        content
            .overlay(
                LinearGradient(colors: [shadowColor.opacity(0), shadowColor.opacity(0.6)], startPoint: .center, endPoint: .bottom), alignment: .bottom )
    }
    
}

struct ReadableImageBlack: ViewModifier {
    
    var shadowColor: Color = .black

    public func body(content: Content) -> some View {
        content
            .overlay(
                LinearGradient(colors: [shadowColor.opacity(0), shadowColor.opacity(0.4), shadowColor.opacity(0.7), shadowColor.opacity(0.8)], startPoint: .center, endPoint: .bottom), alignment: .bottom )
    }
    
}
struct ReadableImageBig: ViewModifier {
    
    var shadowColor: Color = .black.opacity(0.8)

    public func body(content: Content) -> some View {
        content
            .overlay(
                LinearGradient(colors: [shadowColor.opacity(0), shadowColor.opacity(0.6), shadowColor.opacity(0.8)], startPoint: .top, endPoint: .bottom), alignment: .bottom )
    }
    
}

public extension View {
    
    /// Add a color background with corner radius.
    func readableBigImage() -> some View {
        modifier(ReadableImageBig())
    }
    func readableImage() -> some View {
        modifier(ReadableImage())
    }
    func readableBlackImage() -> some View {
        modifier(ReadableImageBlack())
    }
    
}
