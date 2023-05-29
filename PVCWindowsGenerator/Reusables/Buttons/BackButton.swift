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
                Image.generalArrowLeft
                    .resizableImage(size: .init(edgeLength: 16), renderingMode: .template)
                    .foregroundColor(.light2B2B2B)
                    .padding(.leading, 1)
            }
            .frame(size: .init(edgeLength: 40))
            .buttonStyle(.plain)
        }
    }
}
