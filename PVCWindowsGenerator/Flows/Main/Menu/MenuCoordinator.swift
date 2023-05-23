//
//  MenuCoordinator.swift
//  PVCWindowsGenerator
//
//  Created by Alex Bofu on 20.05.2023.
//

import SwiftUI
import Stinsen

final class MenuCoordinator: NavigationCoordinatable {
    
    let stack = NavigationStack(initial: \MenuCoordinator.start)
    let dependencyContainer: any DependencyContainerProtocol
    
    @Root var start = makeStart

    init(dependencyContainer: any DependencyContainerProtocol) {
        self.dependencyContainer = dependencyContainer
    }
}

extension MenuCoordinator {
    static let mocked = MenuCoordinator(dependencyContainer: DependencyContainerMock.default)
    static let mockedRouter = NavigationRouter(
        id: Int.random(in: .min ... .max),
        coordinator: MenuCoordinator.mocked
    )
}


