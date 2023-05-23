//
//  ContractsView.swift
//  PVCWindowsGenerator
//
//  Created by Alex Bofu on 20.05.2023.
//

import SwiftUI

struct ContractsView: View {
    
    @EnvironmentObject private var router: ContractsCoordinator.Router

    var body: some View {
        NavigationBar(
            barType: .title(title: .contractsScreenTitle.capitalized),
            isBackButtonHidden: true,
            contentView: {
                content
            }
        )
        .fillBackground(.indigo)
    }
    
    private var content: some View {
        VStack(alignment: .center, spacing: 24) {
            Spacer()
        }
        .padding(.horizontal, 24)
        .padding(.top, 36)
    }
}

struct ContractsView_Previews: PreviewProvider {
    static var previews: some View {
        ContractsView()
            .environmentObject(ContractsCoordinator.mockedRouter)
    }
}
