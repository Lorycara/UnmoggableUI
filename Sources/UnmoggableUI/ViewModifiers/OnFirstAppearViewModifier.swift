//
//  OnFirstAppearViewModifier.swift
//  AIChatCourse
//
//  Created by Lorenzo Cara on 23/01/25.
//

import SwiftUI
struct OnFirstAppearViewModifier: ViewModifier {
    @State private var didAppear = false
    let action: () -> Void
    
    func body(content: Content) -> some View {
        content
            .onAppear {
                guard !didAppear else { return }
                didAppear = true
                action()
            }
    }
}
struct OnFirstTaskViewModifier: ViewModifier {
    @State private var didAppear = false
    let action: () async -> Void
    
    func body(content: Content) -> some View {
        content
            .task {
                guard !didAppear else { return }
                didAppear = true
                await action()
            }
    }
}

public extension View {
    
    func onFirstAppear(_ action: @escaping () -> Void) -> some View {
        modifier(OnFirstAppearViewModifier(action: action))
    }
    func onFirstTask(_ action: @escaping () -> Void) -> some View {
        modifier(OnFirstAppearViewModifier(action: action))
    }
}
