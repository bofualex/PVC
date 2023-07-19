//
//  View+CardModifier.swift
//  PVCWindowsGenerator
//
//  Created by Alex Bofu on 10.06.2023.
//

import SwiftUI

struct CardViewModifier: ViewModifier {
    
    let backgroundColor: Color
    let action: VoidCallback?
    
    func body(content: Content) -> some View {
        Button {
            action?()
        } label: {
            content
                .padding(.all, 24)
                .background {
                    backgroundColor
                        .cornerRadius(12)
                        .shadow(color: .light2B2B2B.opacity(0.1), radius: 3, x: 0, y: 0)
                }
        }
    }
}
