//
//  NavigationBar+Extensions.swift
//  PVCWindowsGenerator
//
//  Created by Alex Bofu on 15.04.2023.
//

import SwiftUI

extension NavigationBar {
    enum BarType {
        case logo(image: Image)
        case title(title: String)
        case none
    }
}

extension NavigationBar {
    
    init(barType: BarType,
         isBackButtonHidden: Bool = false,
         @ViewBuilder contentView: @escaping () -> ContentView,
         @ViewBuilder rightView: @escaping () -> RightView,
         leftButtonAction: VoidCallback? = nil
    ) {
        self.barType = barType
        self.isBackButtonHidden = isBackButtonHidden
        self.leftButtonAction = nil
        self.contentView = contentView()
        self.rightView = rightView()
    }
}

extension NavigationBar where RightView == EmptyView {
    
    init(barType: BarType,
         isBackButtonHidden: Bool = false,
         @ViewBuilder contentView: @escaping () -> ContentView,
         leftButtonAction: VoidCallback? = nil
    ) {
        self.barType = barType
        self.isBackButtonHidden = isBackButtonHidden
        self.leftButtonAction = leftButtonAction
        self.contentView = contentView()
        self.rightView = EmptyView()
    }
}
