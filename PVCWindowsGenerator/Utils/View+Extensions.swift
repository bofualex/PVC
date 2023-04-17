//
//  View+Extensions.swift
//  PVCWindowsGenerator
//
//  Created by Alex Bofu on 13.04.2023.
//

import UIKit
import SwiftUI
import Combine

extension View {

    @inlinable
    func eraseToAnyView() -> AnyView {
        return AnyView(self)
    }
    
    func roundedCorners(_ corners: UIRectCorner, radius: CGFloat) -> some View {
        clipShape(RoundedCornerShape(radius: radius, corners: corners))
    }
    
    func roundedBorder(_ color: Color, cornerRadius: CGFloat, lineWidth: CGFloat = 1.5) -> some View {
        modifier(RoundedBorderModifier(color: color, cornerRadius: cornerRadius, lineWidth: lineWidth))
    }

    func readContentFrame(
        in coordinateSpace: CoordinateSpace = .global,
        _ onChanged: @escaping (CGSize) -> Void
    ) -> some View {
        self.background(
            GeometryReader { proxy -> Color in
                let frame = proxy.frame(in: coordinateSpace)
                onChanged(frame.size)
                return Color.clear
            }
        )
    }

    func frame(size: CGSize) -> some View {
        return self
            .frame(width: size.width, height: size.height)
    }
    
    func safeAreaTint(
        _ tintColor: Color = .lightFFFFFF,
        edge safeAreaInsetEdge: Edge.Set,
        alignment: Alignment = .top
    ) -> some View {
        overlay(
            tintColor
                .frame(height: UIApplication.shared.safeAreaInset(edge: safeAreaInsetEdge))
                .ignoresSafeArea(.all, edges: .top),
            alignment: alignment
        )
    }
    
    func fillBackground(
        _ color: Color,
        edges: Edge.Set = .vertical
    ) -> some View {
        background(color.ignoresSafeArea(.container, edges: edges))
    }

    func readKeyboardHeight(_ keyboardHeight: Binding<CGFloat>) -> some View {
        self.onReceive(Publishers.keyboardHeight) { currentKeyboardHeight in
            withAnimation(.linear(duration: 0.23)) {
                keyboardHeight.wrappedValue = currentKeyboardHeight
            }
        }
    }
    
    func hideKeyboard() {
        dismissKeyboard()
    }
    
    @ViewBuilder
    func isScrollable(if condition: Bool, maxHeight: CGFloat = .infinity) -> some View {
        if condition {
            ScrollView {
                self
            }
            .frame(maxHeight: maxHeight)
        } else {
            self
        }
    }

    @ViewBuilder
    func isHidden(_ hidden: Bool, remove: Bool = false) -> some View {
        if hidden {
            if !remove {
                self.hidden()
            }
        } else {
            self
        }
    }
}

struct EmailViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .keyboardType(.emailAddress)
            .autocapitalization(.none)
            .disableAutocorrection(true)
            .frame(height: 50)
            .padding(.horizontal)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.lightC34246)
            )
    }
}

struct PasswordViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .autocapitalization(.none)
            .disableAutocorrection(true)
            .frame(height: 50)
            .padding(.horizontal)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.lightC34246)
            )
    }
}


func becomeFirstResponder() {
    // a trick from Stack Overflow: https://stackoverflow.com/questions/54953868/uiapplications-sendaction-works-even-if-targetforaction-is-nil
    UIApplication.shared.sendAction(#selector(UIResponder.becomeFirstResponder), to: nil, from: nil, for: nil)
}

func dismissKeyboard() {
    // a trick from Stack Overflow: https://stackoverflow.com/questions/54953868/uiapplications-sendaction-works-even-if-targetforaction-is-nil
    UIApplication.shared.sendAction(
        #selector(UIResponder.resignFirstResponder),
        to: nil,
        from: nil,
        for: nil
    )
}
