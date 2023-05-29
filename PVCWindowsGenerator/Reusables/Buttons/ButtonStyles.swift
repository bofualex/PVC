//
//  ButtonStyles.swift
//  PVCWindowsGenerator
//
//  Created by Alex Bofu on 13.04.2023.
//

import SwiftUI

enum ButtonSize {
    case extraSmall
    case small
    case medium
    case large
    
    var insets: EdgeInsets {
        var verticalInset: CGFloat
        var horizontalInset: CGFloat
        
        switch self {
        case .extraSmall:
            verticalInset = 8
            horizontalInset = 12
            
        case .small:
            verticalInset = 12
            horizontalInset = 16
            
        case .medium:
            verticalInset = 16
            horizontalInset = 24
            
        case .large:
            verticalInset = 24
            horizontalInset = 48
        }
        
        return EdgeInsets(top: verticalInset, leading: horizontalInset, bottom: verticalInset, trailing: horizontalInset)
    }
}

struct ButtonStyles {
    
    struct Bordered: ButtonStyle {
        
        let isEnabled: Bool
        let fillColor: Color
        let borderColor: Color
        let size: ButtonSize
        let animatedOnPress: Bool
        
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .font(.rubikSemiBold14)
                .foregroundColor(fillColor)
                .minimumScaleFactor(0.5)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .padding(size.insets)
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(fillColor)
                )
                .roundedBorder(borderColor, cornerRadius: 15, lineWidth: 1)
                .opacity(configuration.isPressed || !isEnabled ? 0.5 : 1)
        }
    }

    struct Filled: ButtonStyle {
        
        let isEnabled: Bool
        let fillColor: Color
        let size: ButtonSize
        var font: Font = .rubikBold16
        var foregroundColor: Color = .lightFFFFFF
        
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .font(font)
                .minimumScaleFactor(0.5)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .foregroundColor(foregroundColor)
                .padding(size.insets)
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(fillColor)
                )
                .opacity(configuration.isPressed ? 0.5 : 1)
                .opacity(isEnabled ? 1 : 0.5)
        }
    }

    struct VerticalImageText: ButtonStyle {
        let font: Font
        let backgroundColor: Color
        let foregroundColor: Color
        let borderColor: Color
            
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .font(font)
                .foregroundColor(foregroundColor)
                .lineLimit(1)
                .padding(.horizontal, 10)
                .frame(maxWidth: 120, maxHeight: 78)
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(backgroundColor)
                )
                .roundedBorder(borderColor, cornerRadius: 15, lineWidth: 1.5)
        }
    }
    
    struct Text: ButtonStyle {
        let foregroundColor: Color
        let size: ButtonSize = .small
        let textAlignment: TextAlignment = .trailing
        var font: Font = .rubikSemiBold14
        let isEnabled: Bool
        
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .font(font)
                .minimumScaleFactor(0.9)
                .lineLimit(1)
                .foregroundColor(foregroundColor)
                .padding(.leading, textAlignment == .trailing ? size.insets.trailing : 0)
                .padding(.trailing, textAlignment == .leading ? size.insets.leading : 0)
                .frame(height: 48)
                .opacity(configuration.isPressed || !isEnabled ? 0.5 : 1)
        }
    }
}
