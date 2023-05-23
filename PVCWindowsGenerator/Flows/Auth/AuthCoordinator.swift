//
//  AuthCoordinator.swift
//  PVCWindowsGenerator
//
//  Created by Alex Bofu on 15.04.2023.
//

import SwiftUI
import Stinsen

final class AuthCoordinator: NavigationCoordinatable {
    
    let stack = NavigationStack(initial: \AuthCoordinator.start)
    let dependencyContainer: any DependencyContainerProtocol
    
    @Root var start = makeStart
    @Route(.push) var loginView = makeLoginView
    @Route(.push) var signupView = makeSignupView

    init(dependencyContainer: any DependencyContainerProtocol) {
        self.dependencyContainer = dependencyContainer
    }
}

extension AuthCoordinator {
    static let mocked = AuthCoordinator(dependencyContainer: DependencyContainerMock.default)
    static let mockedRouter = NavigationRouter(
        id: Int.random(in: .min ... .max),
        coordinator: AuthCoordinator.mocked
    )
}
