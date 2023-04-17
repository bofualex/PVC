//
//  Environment+Custom.swift
//  PVCWindowsGenerator
//
//  Created by Alex Bofu on 17.04.2023.
//

import SwiftUI

struct ScreenSizeKey: EnvironmentKey {
    static let defaultValue = UIScreen.main.bounds.size
}

struct SafeAreaInsetKey: EnvironmentKey {
    private static let uikitInsets = UIApplication.shared.safeAreaInsets ?? .zero
    
    static let defaultValue = EdgeInsets(
        top: uikitInsets.top,
        leading: uikitInsets.left,
        bottom: uikitInsets.bottom,
        trailing: uikitInsets.right
    )
}

extension EnvironmentValues {
    var safeAreaInset: EdgeInsets {
        get { self[SafeAreaInsetKey.self] }
    }
    
    var screenSize: CGSize {
        get { self[ScreenSizeKey.self] }
    }
}
