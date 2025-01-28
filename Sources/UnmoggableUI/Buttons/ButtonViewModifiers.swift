//
//  ButtonViewModifiers.swift
//  AIChatCourse
//
//  Created by Lorenzo Cara on 11/01/25.
//

import SwiftUI

struct HighlightButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .overlay {
                configuration.isPressed ? Color.accentColor.opacity(0.3) : Color.clear
            }
            .animation(.smooth, value: configuration.isPressed)
    }
}

struct PressableButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.75 : 1)
            .animation(.smooth, value: configuration.isPressed)
    }
}

enum ButtonStyleOption {
    case highlight, press, plain
}

@available(iOS 14, *)
public extension View {
    
    /// Wrap a View in a Link and add a custom ButtonStyle.
    @ViewBuilder
    func asWebLink(url: @escaping () -> URL?) -> some View {
        if let url = url() {
            Link(destination: url) {
                self
            }
        } else {
            self
                .onAppear {
                    print("‼️ SwiftfulUI Warning: URL is nil! \(#file) \(#line)")
                }
        }
    }
    
}

public extension View {
    
    @ViewBuilder
    func anyButtonStyle(_ style: ButtonStyleOption = .plain, action: @escaping () -> Void) -> some View {
        switch style {
        case .highlight:
            self.highlightButton(action: action)
        case .press:
            self.pressableButton(action: action)
        case .plain:
            self.plainButton(action: action)
        }
        
    }
    
    private func plainButton(action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            self
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    private func highlightButton(action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            self
        }
        .buttonStyle(HighlightButtonStyle())
    }
    
    private func pressableButton(action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            self
        }
        .buttonStyle(PressableButtonStyle())
    }
    
    func removeListRowFormatting() -> some View {
        self
            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            .listRowBackground(Color.clear)
    }

}

#Preview {
    VStack {
        Text("siumm")
            .anyButtonStyle(.press) {
                print("IUMMSA")
            }
        
    Text("Link to google")
            .asWebLink {
                URL(string: "https://google.com")
            }
    }

}
