//
//  ActivityIndicator.swift
//  PVCWindowsGenerator
//
//  Created by Alex Bofu on 13.04.2023.
//

import SwiftUI

struct ActivityIndicator: View {
    
    var tint: Color = .gray
    var scale: CGFloat = 1
    
    var body: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: tint))
            .scaleEffect(scale)
    }
}

struct ActivityIndicator_Previews: PreviewProvider {
    static var previews: some View {
        ActivityIndicator()
    }
}
