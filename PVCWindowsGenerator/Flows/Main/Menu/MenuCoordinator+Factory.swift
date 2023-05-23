//
//  MenuCoordinator+Factory.swift
//  PVCWindowsGenerator
//
//  Created by Alex Bofu on 20.05.2023.
//

import SwiftUI
import Stinsen

extension MenuCoordinator {

    @ViewBuilder
    func makeStart() -> some View {
        MenuView(
            viewModel: .init(
                authenticationService: dependencyContainer.authService
            )
        )
    }
}


