//
//  TabBarShape.swift
//  PVCWindowsGenerator
//
//  Created by Alex Bofu on 19.05.2023.
//

import SwiftUI

struct TabBarShape: Shape {
    
    var centerX : CGFloat
    var animatableData: CGFloat{
        get{ return centerX }
        set{ centerX = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        return Path{path in
            path.move(to: .init(x: 0, y: 10))
            path.addLine(to: .init(x: 0, y: rect.height))
            path.addLine(to: .init(x: rect.width, y: rect.height))
            path.addLine(to: .init(x: rect.width, y: 10))
            path.move(to: .init(x: centerX - 35, y: 10))
            path.addQuadCurve(
                to: .init(x: centerX + 35, y: 10),
                control: CGPoint(x: centerX, y: -22.5)
            )
        }
    }
}
