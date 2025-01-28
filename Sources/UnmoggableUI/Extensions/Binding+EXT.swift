//
//  File.swift
//  UnmoggableUI
//
//  Created by Lorenzo Cara on 27/01/25.
//


//
//  Binding+EXT.swift
//  AIChatCourse
//
//  Created by Lorenzo Cara on 21/01/25.
//
import SwiftUI

public extension Binding where Value == Bool {
    init<T: Sendable>(ifNotNil value: Binding<T?>) {
        self.init {
            value.wrappedValue != nil
        } set: { newValue in
        if !newValue {
            value.wrappedValue = nil
        }
    }

    }
}
