//
//  BackButton.swift
//  PVCWindowsGenerator
//
//  Created by Alex Bofu on 13.04.2023.
//

import SwiftUI

extension Buttons {
    struct BackButton: View {
        let action: VoidCallback?
        
        var body: some View {
            Button {
                action?()
            } label: {
                Circle()
                    .frame(width: 40)
                    .foregroundColor(.lightF5EDEC)
                    .overlay {
                        Image.generalArrowLeft
                            .resizableImage(size: .init(edgeLength: 16), renderingMode: .template)
                            .foregroundColor(.light438BF6)
                            .padding(.leading, 1)
                    }
            }
            .buttonStyle(.plain)
        }
    }
}
