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

    static func tabBarView() -> some View {
        TabBarView(viewModel: .init())
    }
    
    static func homeView(networkService: NetworkServiceProtocol) -> some View {
        HomeView(viewModel: .init(networkService: networkService))
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
