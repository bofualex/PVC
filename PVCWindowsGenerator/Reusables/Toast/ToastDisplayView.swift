//
//  ToastDisplayView.swift
//  PVCWindowsGenerator
//
//  Created by Alex Bofu on 03.05.2023.
//

import SwiftUI

struct ToastDisplayView: View {
    
    @Binding var isPresented: Bool
    let message: String
    let backgroundColor: Color
    
    @State private var yTranslation: CGFloat = .zero
    @State private var isDragging = false
    
    var body: some View {
        if isPresented {
            Text(message)
                .toastTextStyle()
                .frame(maxWidth: .infinity, minHeight: 54)
                .background(backgroundColor.cornerRadius(15))
                .offset(y: yTranslation)
                .padding(.horizontal, 24)
                .gesture(dragGesture())
                .transition(.moveAndFadeFromTop)
                .animation(.easeIn(duration: 0.4), value: yTranslation)
                .animation(.spring(response: 0.4, dampingFraction: 0.6, blendDuration: 1))
                .onAppear {
                    automaticDismiss(after: 2)
                }
        }
    }
    
    private func dragGesture() -> some Gesture {
        DragGesture(minimumDistance: 0, coordinateSpace: .global)
            .onChanged { value in
                let draggedHeight = value.translation.height
                if !isDragging {
                    isDragging = true
                }
                
                guard draggedHeight < .zero else {
                    if draggedHeight < 50 {
                        yTranslation = draggedHeight
                    }
                    return
                }
                
                if abs(draggedHeight) > 40 {
                    isPresented = false
                } else {
                    yTranslation = draggedHeight
                }
            }
            .onEnded { _ in
                yTranslation = .zero
                isDragging = false
                automaticDismiss(after: 1.3)
            }
    }
    
    private func automaticDismiss(after: TimeInterval) {
        DispatchQueue.main.asyncAfter(deadline: .now() + after) {
            if !isDragging {
                isPresented = false
            }
        }
    }
}

extension View {
    
    func toastDisplay(
        isPresented: Binding<Bool>,
        message: String,
        backgroundColor: Color = .green
    ) -> some View {
        
        ZStack(alignment: Alignment(horizontal: .center, vertical: .top)) {
            self
            ToastDisplayView(
                isPresented: isPresented,
                message: message,
                backgroundColor: backgroundColor
            )
            .zIndex(1)
        }
    }
    
    func errorDisplay(
        error: Binding<Error?>,
        backgroundColor: Color = .lightC34246
    ) -> some View {
        var isPresentedBinding: Binding<Bool> {
            Binding {
                return error.wrappedValue != nil
            } set: { newValue in
                if !newValue {
                    error.wrappedValue = nil
                }
            }

        }
        
        return ZStack(alignment: Alignment(horizontal: .center, vertical: .top)) {
            self
            ToastDisplayView(
                isPresented: isPresentedBinding,
                message: error.wrappedValue?.localizedDescription ?? "",
                backgroundColor: .lightC34246
            )
            .zIndex(1)
        }
    }
    

}

fileprivate extension View {
    
    func toastTextStyle() -> some View {
        self
            .font(.rubikRegular14)
            .foregroundColor(.white)
            .lineLimit(3)
            .lineSpacing(2)
            .minimumScaleFactor(0.9)
            .multilineTextAlignment(.leading)
            .padding(16)
    }
}

struct ToastDisplayView_Previews: PreviewProvider {
    
    static var previews: some View {
        ToastDisplayPreview()
    }
    
    private struct ToastDisplayPreview: View {
        @State var error: Error? = ToastError.oneLineMessage
        
        enum ToastError: String, LocalizedError {
            case oneLineMessage = "This is a short message"
            case twoLineMessage = "This is a long message This is a long message This is a long message"
            case threeLineMessage = "This is a short message This is a long message This is a long message This is a long message This is a long message This is a long message This is a long message This is a long message This is a long message This is a long message"
            
            var errorDescription: String? {
                rawValue
            }
        }
        
        var body: some View {
            Color.green
                .errorDisplay(error: $error)
        }
    }
}
