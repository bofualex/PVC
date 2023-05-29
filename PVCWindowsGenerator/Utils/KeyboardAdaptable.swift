//
//  KeyboardAdaptable.swift
//  PVCWindowsGenerator
//
//  Created by Alex Bofu on 29.05.2023.
//

import SwiftUI
import Combine

struct KeyboardAdaptive: ViewModifier {
    
    @State private var keyboardHeight: CGFloat = 0

    func body(content: Content) -> some View {
        content
            .padding(.bottom, keyboardHeight)
            .onReceive(Publishers.keyboardHeight) {
                self.keyboardHeight = $0
            }
    }
}

extension View {
    func keyboardAdaptive() -> some View {
        ModifiedContent(content: self, modifier: KeyboardAdaptive())
    }
}
