//
//  VerticalImageTextButton.swift
//  PVCWindowsGenerator
//
//  Created by Alex Bofu on 13.04.2023.
//

import SwiftUI

extension Buttons {
    struct VerticalImageTextButton: View {
        let title: String
        let imageName: String
        var font: Font = .rubikSemiBold14
        var backgroundColor: Color = .lightFFFFFF.opacity(0.001)
        var foregroundColor: Color = .lightC34246
        var borderColor: Color = .lightC34246
        var isSystemImage = false
        var action: VoidCallback? = nil

        var body: some View {
            Button {
                action?()
            } label: {
                VStack(spacing: 5) {
                    image
                    Text(title)
                }
                .foregroundColor(foregroundColor)
            }
            .buttonStyle(
                ButtonStyles.VerticalImageText(
                    font: font,
                    backgroundColor: backgroundColor,
                    foregroundColor: foregroundColor,
                    borderColor: borderColor
                )
            )
        }
            
        @ViewBuilder var image: some View {
            if isSystemImage {
                Image(systemName: imageName)
                    .renderingMode(.template)
            } else {
                Image(imageName)
                    .renderingMode(.template)
            }
        }
    }
}
