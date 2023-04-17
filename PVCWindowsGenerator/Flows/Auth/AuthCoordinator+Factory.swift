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
    func makeLoginView() -> some View {
        LoginView(
            viewModel: LoginViewModel(authService: dependencyContainer.authService)
        )
    }
    
    @ViewBuilder
    func makeStart() -> some View {
        EmailCheckView(
            viewModel: EmailCheckViewModel(authService: dependencyContainer.authService)
        )
    }
}
