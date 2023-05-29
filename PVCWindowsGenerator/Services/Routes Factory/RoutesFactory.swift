//
//  RoutesFactory.swift
//  PVCWindowsGenerator
//
//  Created by Alex Bofu on 24.05.2023.
//

import SwiftUI

enum RoutesFactory {
    
    static func authorizationView(
        authService: AuthenticationServiceProtocol
    ) -> some View {
        AuthorizationView(
            viewModel: .init(
                authService: authService
            )
        )
    }
    
    static func emailCheckView(
        authService: AuthenticationServiceProtocol
    ) -> some View {
        EmailCheckView(
            viewModel: .init(
                authService: authService
            )
        )
    }
    
    static func loginView(
        authService: AuthenticationServiceProtocol,
        email: String
    ) -> some View {
        LoginView(
            viewModel: .init(
                authService: authService,
                email: email
            )
        )
    }
    
    static func signupView(
        authService: AuthenticationServiceProtocol,
        email: String
    ) -> some View {
        SignupView(
            viewModel: .init(
                authService: authService,
                email: email
            )
        )
    }
    
    static func tabBarView() -> some View {
        TabBarView(viewModel: .init())
    }
    
    static func homeView() -> some View {
        HomeView()
    }
    
    static func offersView() -> some View {
        OffersView()
    }
    
    static func contractsView() -> some View {
        ContractsView()
    }
    
    static func menuView(
        authService: AuthenticationServiceProtocol
    ) -> some View {
        MenuView(
            viewModel: .init(authenticationService: authService)
        )
    }
}
