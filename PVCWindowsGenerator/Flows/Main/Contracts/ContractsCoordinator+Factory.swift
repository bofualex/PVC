//
//  ContractsCoordinator+Factory.swift
//  PVCWindowsGenerator
//
//  Created by Alex Bofu on 20.05.2023.
//

import SwiftUI
import Stinsen

extension ContractsCoordinator {

    @ViewBuilder
    func makeStart() -> some View {
        RoutesFactory.contractsView()
    }
}

