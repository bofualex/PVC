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
    let dependencyContainer: DependencyContainer
    
    @Root var start = makeStart
    @Route(.push) var loginView = makeLoginView
    
    init(dependencyContainer: DependencyContainer) {
        self.dependencyContainer = dependencyContainer
    }
}
