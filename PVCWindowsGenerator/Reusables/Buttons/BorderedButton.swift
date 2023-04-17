//
//  BorderedButton.swift
//  PVCWindowsGenerator
//
//  Created by Alex Bofu on 13.04.2023.
//

import SwiftUI

extension Buttons {
    struct BorderedButton: View {
        let title: String
        var isEnabled: Bool = true
        var isLoading: Bool = false
        var backgroundColor: Color = .lightFFFFFF.opacity(0.001)
        var foregroundColor: Color = .lightC34246
        var borderColor: Color = .light438BF6
        var size: ButtonSize = .medium
        var animatedOnPress: Bool = true
        var action: VoidCallback? = nil
        
        private var _isEnabled: Bool {
            isEnabled && !isLoading
        }
        
        var body: some View {
            Button {
                action?()
            } label: {
                Text(title)
                    .foregroundColor(foregroundColor)
            }
            .buttonStyle(
                ButtonStyles.Bordered(
                    isEnabled: _isEnabled,
                    fillColor: backgroundColor,
                    borderColor: borderColor,
                    size: size,
                    animatedOnPress: animatedOnPress
                )
            )
            .disabled(!_isEnabled)
            .overlay(loadingIndicator, alignment: .trailing)
        }
        
        @ViewBuilder
        private var loadingIndicator: some View {
            if isLoading {
                ActivityIndicator(scale: 0.8)
                    .padding(.trailing, 6)
                    .transition(.opacity.animation(.linear))
            }
        }
    }
}
