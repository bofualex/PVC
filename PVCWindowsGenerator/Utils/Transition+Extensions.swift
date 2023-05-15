//
//  Transition+Extensions.swift
//  PVCWindowsGenerator
//
//  Created by Alex Bofu on 03.05.2023.
//

import SwiftUI

extension AnyTransition {
    
    static var moveAndFadeFromTop: Self {
        let removeTransition = Self.move(edge: .top).combined(with: .opacity)
        return .asymmetric(
            insertion: .move(edge: .top),
            removal: removeTransition.animation(.linear(duration: 0.3))
        )
    }
    
    static var moveAndFadeFromBottom: Self {
        let removeTransition = Self.move(edge: .bottom).combined(with: .opacity)
        return .asymmetric(
            insertion: .move(edge: .bottom),
            removal: removeTransition.animation(.linear(duration: 0.3))
        )
    }
}
