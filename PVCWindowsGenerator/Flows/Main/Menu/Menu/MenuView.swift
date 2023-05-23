//
//  MenuView.swift
//  PVCWindowsGenerator
//
//  Created by Alex Bofu on 20.05.2023.
//

import SwiftUI

struct MenuView: View {
    
    @ObservedObject var viewModel: MenuViewModel
    
    @EnvironmentObject private var router: MenuCoordinator.Router

    var body: some View {
        NavigationBar(
            barType: .title(title: .menuScreenTitle.capitalized),
            isBackButtonHidden: true,
            contentView: {
                content
            }
        )
        .fillBackground(.blue)
    }
    
    private var content: some View {
        VStack(alignment: .center, spacing: 24) {
            Buttons.FilledButton(
                title: .generalLogout.capitalized,
                action: viewModel.logout
            )
            .frame(width: 150)
        }
        .padding(.horizontal, 24)
        .padding(.top, 36)
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(
            viewModel: .init(
                authenticationService: AuthenticationServiceMock()
            )
        )
        .environmentObject(MenuCoordinator.mockedRouter)
    }
}
