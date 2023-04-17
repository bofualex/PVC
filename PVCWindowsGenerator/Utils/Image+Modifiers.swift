//
//  Image+Modifiers.swift
//  PVCWindowsGenerator
//
//  Created by Alex Bofu on 13.04.2023.
//

import SwiftUI

extension Image {
    func resizableImage(
        size: CGSize,
        contentMode: ContentMode = .fill,
        renderingMode: Image.TemplateRenderingMode? = nil
    ) -> some View {
        self
            .renderingMode(renderingMode)
            .resizable()
            .aspectRatio(contentMode: contentMode)
            .frame(width: size.width, height: size.height)
            .clipped()
    }
    
    func fillImageToSafeArea() -> some View {
        self
            .resizable()
            .scaledToFill()
            .ignoresSafeArea(.container, edges: .all)
    }
}
