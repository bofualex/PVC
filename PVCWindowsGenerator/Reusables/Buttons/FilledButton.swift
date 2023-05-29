//
//  FilledButton.swift
//  PVCWindowsGenerator
//
//  Created by Alex Bofu on 13.04.2023.
//

import SwiftUI

extension Buttons {
    struct FilledButton<SupplementaryView: View>: View {
        let title: String
        var isEnabled: Bool = true
        var isLoading: Bool = false
        var fillColor: Color = .lightC34246
        var font: Font = .rubikSemiBold14
        var accentColor: Color = .lightFFFFFF
        var size: ButtonSize = .medium
        let action: VoidCallback?
        
        @ViewBuilder var supplementaryView: SupplementaryView
        
        private var _isEnabled: Bool {
            isEnabled && !isLoading
        }
        
        var body: some View {
            Button {
                action?()
            } label: {
                ZStack {
                    Text(title)
                        .foregroundColor(accentColor)
                    supplementaryView
                }
            }
            .buttonStyle(
                ButtonStyles.Filled(
                    isEnabled: _isEnabled,
                    fillColor: fillColor,
                    size: size,
                    font: font,
                    foregroundColor: accentColor
                )
            )
            .disabled(!_isEnabled)
            .overlay(
                loadingIndicator
                    .padding(.trailing, 6)
                , alignment: .trailing
            )
        }
        
        @ViewBuilder
        private var loadingIndicator: some View {
            if isLoading {
                ActivityIndicator(
                    tint: accentColor,
                    scale: 0.8
                )
                    .padding(.trailing, 6)
                    .transition(.opacity.animation(.linear))
            }
        }
    }
}

extension Buttons.FilledButton where SupplementaryView == EmptyView {
    init(
        title: String,
        isEnabled: Bool = true,
        isLoading: Bool = false,
        fillColor: Color = .light9DC2CE,
        font: Font = .rubikSemiBold16,
        accentColor: Color = .lightFFFFFF,
        size: ButtonSize = .medium,
        action: VoidCallback?
    ) {
        self.title = title
        self.isEnabled = isEnabled
        self.isLoading = isLoading
        self.fillColor = fillColor
        self.font = font
        self.accentColor = accentColor
        self.size = size
        self.action = action
        self.supplementaryView = EmptyView()
    }
}

