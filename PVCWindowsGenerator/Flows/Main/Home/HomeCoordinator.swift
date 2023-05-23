//
//  HomeCoordinator.swift
//  PVCWindowsGenerator
//
//  Created by Alex Bofu on 20.05.2023.
//

import SwiftUI
import Stinsen

final class HomeCoordinator: NavigationCoordinatable {
    
    let stack = NavigationStack(initial: \HomeCoordinator.start)
    let dependencyContainer: any DependencyContainerProtocol
    
    @Root var start = makeStart

    init(dependencyContainer: any DependencyContainerProtocol) {
        self.dependencyContainer = dependencyContainer
    }
}

extension HomeCoordinator {
    static let mocked = HomeCoordinator(dependencyContainer: DependencyContainerMock.default)
    static let mockedRouter = NavigationRouter(
        id: Int.random(in: .min ... .max),
        coordinator: HomeCoordinator.mocked
    )
}

