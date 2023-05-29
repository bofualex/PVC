//
//  MainCoordinator+Factory.swift
//  PVCWindowsGenerator
//
//  Created by Alex Bofu on 18.05.2023.
//

import SwiftUI
import Stinsen

extension MainCoordinator {
    
    @ViewBuilder
    func makeStart() -> some View {
        RoutesFactory.tabBarView()
            .environmentObject(self)
    }
    
    var home: some View {
        NavigationViewCoordinator (
            HomeCoordinator(dependencyContainer: dependencyContainer)
        )
        .view()
    }
    
    var offers: some View {
        NavigationViewCoordinator (
            OffersCoordinator(dependencyContainer: dependencyContainer)
        )
        .view()
    }
    
    var contracts: some View {
        NavigationViewCoordinator (
            ContractsCoordinator(dependencyContainer: dependencyContainer)
        )
        .view()
    }
    
    var menu: some View {
        NavigationViewCoordinator (
            MenuCoordinator(dependencyContainer: dependencyContainer)
        )
        .view()
    }
}

