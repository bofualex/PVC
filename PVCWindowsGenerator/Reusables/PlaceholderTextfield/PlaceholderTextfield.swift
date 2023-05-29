//
//  PlaceholderTextfield.swift
//  PVCWindowsGenerator
//
//  Created by Alex Bofu on 02.05.2023.
//

import SwiftUI

struct PlaceholderTextfield: View {
    
    @Binding var text: String
    
    @State private var isShowingSecureText = false
    @State private var placeholderSize = CGSize.zero
    @FocusState private var isFocused: Bool
    
    let placeholder: String
    var error: LocalError? = nil
    var showsBorder = true
    var isSecureTextEntry = false
    var isAutoCorrectDisabled = true
    var keyboardType = UIKeyboardType.default
    var textInputAutocapitalization = TextInputAutocapitalization.never
    var textContentType: UITextContentType?
    var backgroundColor = Color.lightFFFFFF
    var foregroundColor = Color.light2B2B2B
    var errorColor = Color.lightC34246
    var focusedColor = Color.light438BF6
    
    var body: some View {
        ZStack(alignment: text.isEmpty ? .center : .top) {
            VStack(alignment: .leading, spacing: 0) {
                content
                    .overlay(alignment: .trailing) {
                        eyeImageView
                            .padding(.trailing, 12)
                    }
                
                if let error {
                    errorView(error)
                }
            }
            
            if !text.isEmpty {
                HStack {
                    Spacer()
                        .frame(width: 12)
                    placeholderView
                    Spacer()
                }
            }
        }
    }
    
    @ViewBuilder
    private var content: some View {
        inputView
            .focused($isFocused)
            .autocorrectionDisabled(isAutoCorrectDisabled)
            .keyboardType(keyboardType)
            .textInputAutocapitalization(textInputAutocapitalization)
            .textContentType(textContentType)
            .font(.rubikRegular18)
            .foregroundColor(error == nil ? foregroundColor : errorColor)
            .kerning(1.2)
            .frame(height: 30)
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(
                textBackgroundView
            )
            .padding(.vertical, 8)
    }
    
    @ViewBuilder
    private var inputView: some View {
        if isSecureTextEntry {
            if !isShowingSecureText {
                secureTextfieldView
            } else {
                textfieldView
            }
        } else {
            textfieldView
        }
    }
    
    private var textfieldView: some View {
        TextField(placeholder, text: $text)
    }
    
    private var secureTextfieldView: some View {
        SecureField(placeholder, text: $text)
    }
    
    @ViewBuilder
    private var textBackgroundView: some View {
        if showsBorder {
            InterruptedRoundedRectangle(
                cornerRadius: 10,
                interruptionPadding: 2,
                interruptionWidth: text.isEmpty ? 0 : placeholderSize.width
            )
            .stroke(
                (isFocused ? focusedColor : error != nil ? errorColor : foregroundColor                .opacity(0.3)),
                style: .init(
                    lineWidth: 1,
                    lineCap: .round,
                    lineJoin: .round
                )
            )
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(backgroundColor)
            }
        }
    }
    
    @ViewBuilder
    private var eyeImageView: some View {
        if isSecureTextEntry {
            (isShowingSecureText ? Image.generalEyeClosed : Image.generalEyeOpen)
                .resizable()
                .frame(width: 25, height: 14)
                .clipped()
                .foregroundColor(
                    foregroundColor
                        .opacity(0.3)
                )
                .onTapGesture {
                    isShowingSecureText.toggle()
                }
                .animation(.default, value: isShowingSecureText)
        }
    }
    
    private var placeholderView: some View {
        Text(placeholder)
            .foregroundColor(foregroundColor)
            .opacity(0.5)
            .font(.rubikRegular14)
            .kerning(0.8)
            .padding(.horizontal, 4)
            .readContentFrame { size in
                DispatchQueue.main.async {
                    placeholderSize = size
                }
            }
    }
    
    private func errorView(_ error: LocalError) -> some View {
        Text(error.message)
            .font(.rubikRegular14)
            .foregroundColor(errorColor)
            .multilineTextAlignment(.leading)
            .lineSpacing(1.6)
            .kerning(1.1)
            .padding(.horizontal, 16)
    }
}

struct PlaceholderTextfield_Previews: PreviewProvider {
    
    private struct PlaceholderPreview: View {
        
        @State private var text = "ddd"
        
        var body: some View {
            NavigationBar(
                barType: .none,
                isBackButtonHidden: true,
                contentView: {
                    PlaceholderTextfield(
                        text: $text,
                        placeholder: "password",
                        error: LocalError(message: "test"),
                        isSecureTextEntry: false
                    )
                    .padding(.horizontal, 24)
                }
            )
            .fillBackground(.lightF5EDEC)
        }
    }
    
    static var previews: some View {
       PlaceholderPreview()
    }
}

private struct InterruptedRoundedRectangle: Shape {
    
    let cornerRadius: CGFloat
    let interruptionPadding: CGFloat
    let interruptionWidth: CGFloat
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            let width: CGFloat = rect.width
            let height: CGFloat = rect.height
                        
            path.move(
                to: .init(
                    x: 0,
                    y: cornerRadius
                )
            )
            path.addArc(
                center: .init(
                    x: cornerRadius,
                    y: cornerRadius),
                radius: cornerRadius,
                startAngle: .degrees(180),
                endAngle: .degrees(270),
                clockwise: false
            )
            path.addLine(
                to: .init(
                    x: cornerRadius + interruptionPadding,
                    y: 0
                )
            )
            path.move(
                to: .init(
                    x: cornerRadius + interruptionPadding + interruptionWidth,
                    y: 0
                )
            )
            path.addLine(
                to: .init(
                    x: width - cornerRadius,
                    y: 0
                )
            )
            path.addArc(
                center: .init(
                    x: width - cornerRadius,
                    y: cornerRadius),
                radius: cornerRadius,
                startAngle: .degrees(270),
                endAngle: .degrees(360),
                clockwise: false
            )
            path.addLine(
                to: .init(
                    x: width,
                    y: height - cornerRadius
                )
            )
            path.addArc(
                center: .init(
                    x: width - cornerRadius,
                    y: height - cornerRadius),
                radius: cornerRadius,
                startAngle: .degrees(0),
                endAngle: .degrees(90),
                clockwise: false
            )
            path.addLine(
                to: .init(
                    x: cornerRadius,
                    y: height
                )
            )
            path.addArc(
                center: .init(
                    x: cornerRadius,
                    y: height - cornerRadius),
                radius: cornerRadius,
                startAngle: .degrees(90),
                endAngle: .degrees(180),
                clockwise: false
            )
            path.addLine(
                to: .init(
                    x: 0,
                    y: cornerRadius
                )
            )
        }
    }
}
