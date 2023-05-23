//
//  ContractsCoordinator.swift
//  PVCWindowsGenerator
//
//  Created by Alex Bofu on 20.05.2023.
//

import SwiftUI
import Stinsen

final class ContractsCoordinator: NavigationCoordinatable {
    
    let stack = NavigationStack(initial: \ContractsCoordinator.start)
    let dependencyContainer: any DependencyContainerProtocol
    
    @Root var start = makeStart

    init(dependencyContainer: any DependencyContainerProtocol) {
        self.dependencyContainer = dependencyContainer
    }
}

extension ContractsCoordinator {
    static let mocked = ContractsCoordinator(dependencyContainer: DependencyContainerMock.default)
    static let mockedRouter = NavigationRouter(
        id: Int.random(in: .min ... .max),
        coordinator: ContractsCoordinator.mocked
    )
}

