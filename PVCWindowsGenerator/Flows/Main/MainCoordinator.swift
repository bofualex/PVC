//
//  MainCoordinator.swift
//  PVCWindowsGenerator
//
//  Created by Alex Bofu on 18.05.2023.
//

import SwiftUI
import Stinsen

final class MainCoordinator: NavigationCoordinatable {
    
    let stack = NavigationStack(initial: \MainCoordinator.start)
    let dependencyContainer: any DependencyContainerProtocol
    
    @Root var start = makeStart

    init(dependencyContainer: any DependencyContainerProtocol) {
        self.dependencyContainer = dependencyContainer
    }
}

extension MainCoordinator {
    static let mocked = MainCoordinator(dependencyContainer: DependencyContainerMock.default)
    static let mockedRouter = NavigationRouter(
        id: Int.random(in: .min ... .max),
        coordinator: MainCoordinator.mocked
    )
}

