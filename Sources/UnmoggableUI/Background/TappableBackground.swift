//
//  TappableBackground.swift
//  UnmoggableUI
//
//  Created by Lorenzo Cara on 27/01/25.
//

import SwiftUI

public extension View {
    func tappableBackground() -> some View {
            self
                .background(Color.black.opacity(0.00001))
        }
}
