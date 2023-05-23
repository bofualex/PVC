//
//  OffersCoordinator.swift
//  PVCWindowsGenerator
//
//  Created by Alex Bofu on 20.05.2023.
//

import SwiftUI
import Stinsen

final class OffersCoordinator: NavigationCoordinatable {
    
    let stack = NavigationStack(initial: \OffersCoordinator.start)
    let dependencyContainer: any DependencyContainerProtocol
    
    @Root var start = makeStart

    init(dependencyContainer: any DependencyContainerProtocol) {
        self.dependencyContainer = dependencyContainer
    }
}

extension OffersCoordinator {
    static let mocked = OffersCoordinator(dependencyContainer: DependencyContainerMock.default)
    static let mockedRouter = NavigationRouter(
        id: Int.random(in: .min ... .max),
        coordinator: OffersCoordinator.mocked
    )
}

