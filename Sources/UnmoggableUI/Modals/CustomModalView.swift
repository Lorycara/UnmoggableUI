//
//  CustomModalView.swift
//  AIChatCourse
//
//  Created by Lorenzo Cara on 23/01/25.
//

import SwiftUI

public struct CustomModalView: View {
    
    var title: String
    var subtitle: String?
    var primaryButtonTitle: String = "Yes"
    var secondaryButtonTitle: String = "No"
    
    var onPrimaryButtonPressed: (() -> Void)?
    var onSecondaryButtonPressed: (() -> Void)?
    
    public var body: some View {
        VStack(spacing: 24) {
            VStack(spacing: 15) {
                Text(title)
                    .bold()
                    .font(.title3)
                    .padding(.top)
                    .foregroundStyle(.black)
                if let subtitle {
                    Text(subtitle)
                        .font(.subheadline)
                        .foregroundStyle(Color(uiColor: .systemGray3))
                }
            }
            
            VStack {
                Text(primaryButtonTitle)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(.red)
                    .cornerRadius(10)
                    .foregroundStyle(.white)
                    .anyButtonStyle {
                        onPrimaryButtonPressed?()
                    }
                Text(secondaryButtonTitle)
                    .frame(maxWidth: .infinity)
                    .padding(.top, 12)
                    .padding(.bottom, 6)
                    .cornerRadius(10)
                    .foregroundStyle(.black)
                    .tappableBackground()
                    .anyButtonStyle {
                        onSecondaryButtonPressed?()
                    }
            }
            .padding()
        }
        .multilineTextAlignment(.center)
        .background(Color(uiColor: .white))
        .cornerRadius(10)
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        VStack(spacing: 40) {
            CustomModalView(title: "Sium")
                .frame(width: 300)
            CustomModalView(title: "Are you enjoing AIChat?", subtitle: "This is my beautiful subtitle", onPrimaryButtonPressed: {
                print("Porcodi")
            })
            .frame(width: 300)
        }
    }
    .colorScheme(.dark)
}
