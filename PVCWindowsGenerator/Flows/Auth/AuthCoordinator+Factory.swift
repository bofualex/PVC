//
//  AuthenticationCoordinator+Factory.swift
//  PVCWindowsGenerator
//
//  Created by Alex Bofu on 17.04.2023.
//

import SwiftUI
import Stinsen

extension AuthCoordinator {
    
    @ViewBuilder
    func makeStart() -> some View {
        RoutesFactory.authorizationView(
            authService: dependencyContainer.authService
        )
    }
}
