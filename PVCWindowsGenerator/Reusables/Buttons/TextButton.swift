//
//  TextButton.swift
//  PVCWindowsGenerator
//
//  Created by Alex Bofu on 13.04.2023.
//

import SwiftUI

extension Buttons {
    struct TextButton: View {
        let title: String
        var isEnabled: Bool = true
        var isLoading: Bool = false
        var foregroundColor: Color = .light2B2B2B
        var font: Font = .rubikSemiBold14
        var size: ButtonSize = .medium
        var action: VoidCallback? = nil
                
        private var _isEnabled: Bool {
            isEnabled && !isLoading
        }
        
        var body: some View {
            Button {
                action?()
            } label: {
                if isLoading {
                    ActivityIndicator(scale: 0.8)
                } else {
                    Text(title)
                }
            }
            .animation(.default, value: isLoading)
            .buttonStyle(
                ButtonStyles.Text(
                    foregroundColor: foregroundColor,
                    font: font,
                    isEnabled: _isEnabled
                )
            )
            .disabled(!_isEnabled)
        }
    }
}
