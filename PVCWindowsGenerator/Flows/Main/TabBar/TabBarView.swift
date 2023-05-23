//
//  TabBarView.swift
//  PVCWindowsGenerator
//
//  Created by Alex Bofu on 18.05.2023.
//

import SwiftUI

struct TabBarView : View {
    
    @EnvironmentObject private var router: MainCoordinator.Router
    @EnvironmentObject private var coordinator: MainCoordinator

    @ObservedObject var viewModel: TabBarViewModel
    
    init(viewModel: TabBarViewModel) {
        self.viewModel = viewModel
        
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View{
        VStack(spacing: 0) {
            TabView(selection: $viewModel.selectedTab) {
                coordinator.home
                    .tag(viewModel.tabItems[0])
                    .ignoresSafeArea(.all)
                coordinator.offers
                    .tag(viewModel.tabItems[1])
                    .ignoresSafeArea(.all)
                coordinator.contracts
                    .tag(viewModel.tabItems[2])
                    .ignoresSafeArea(.all)
                coordinator.menu
                    .tag(viewModel.tabItems[3])
                    .ignoresSafeArea(.all)
            }
            
            Spacer(minLength: 0)
            
            AnimatableTabBarView(
                tabItems: viewModel.tabItems,
                selected: $viewModel.selectedTab
            )
        }
        .ignoresSafeArea(.all, edges: .bottom)
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView(
            viewModel: .init()
        )
        .environmentObject(MainCoordinator.mocked)
        .environmentObject(MainCoordinator.mockedRouter)
    }
}
