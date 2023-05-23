//
//  HomeView.swift
//  PVCWindowsGenerator
//
//  Created by Alex Bofu on 20.05.2023.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var router: HomeCoordinator.Router

    var body: some View {
        NavigationBar(
            barType: .title(title: .homeScreenTitle.capitalized),
            isBackButtonHidden: true,
            contentView: {
                content
            }
        )
        .fillBackground(.green)
    }
    
    private var content: some View {
        VStack(alignment: .center, spacing: 24) {
            Spacer()
        }
        .padding(.horizontal, 24)
        .padding(.top, 36)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(HomeCoordinator.mockedRouter)
    }
}
