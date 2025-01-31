import SwiftUI

public extension View {
    func asNavigationLink(destination: () -> some View) -> some View {
        NavigationLink {
            AnyView(destination())
        } label: {
            self
        }

    }
}
