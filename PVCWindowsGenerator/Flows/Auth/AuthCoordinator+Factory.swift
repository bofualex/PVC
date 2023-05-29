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
    func makeLoginView(with email: String) -> some View {
        RoutesFactory.loginView(
            authService: dependencyContainer.authService,
            email: email
        )
    }
    
    @ViewBuilder
    func makeSignupView(with email: String) -> some View {
        RoutesFactory.signupView(
            authService: dependencyContainer.authService,
            email: email
        )
    }
    
    @ViewBuilder
    func makeStart() -> some View {
        RoutesFactory.authorizationView(
            authService: dependencyContainer.authService
        )
    }
}
