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
        LoginView(
            viewModel: LoginViewModel(
                authService: dependencyContainer.authService,
                email: email
            )
        )
    }
    
    @ViewBuilder
    func makeSignupView(with email: String) -> some View {
        SignupView(
            viewModel: SignupViewModel(
                authService: dependencyContainer.authService,
                email: email
            )
        )
    }
    
    @ViewBuilder
    func makeStart() -> some View {
        EmailCheckView(
            viewModel: EmailCheckViewModel(
                authService: dependencyContainer.authService
            )
        )
    }
}
