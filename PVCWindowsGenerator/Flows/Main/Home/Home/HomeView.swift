//
//  HomeView.swift
//  PVCWindowsGenerator
//
//  Created by Alex Bofu on 20.05.2023.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel: HomeViewModel
    
    @Environment(\.safeAreaInset) var safeAreaInset
    
    @EnvironmentObject private var router: HomeCoordinator.Router
        
    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]

    var body: some View {
        NavigationBar(
            barType: .none,
            isBackButtonHidden: true,
            contentView: {
                content
            }
        )
        .fillWithDefaultScreenBackground()
    }
    
    private var content: some View {
        VStack(alignment: .center, spacing: 24) {
            inProgressContracts

            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(HomeMenuItem.gridCases) { item in
                    card(for: item)
                }
            }
        }
        .padding(.horizontal, 24)
        .padding(.top, safeAreaInset.top + 36)
    }
    
    @ViewBuilder
    private var inProgressContracts: some View {
        if !viewModel.inProgressContracts.isEmpty {
            Section {
                
            } header: {
                sectionHeader(with: .homeMenuSectionInProgress)
            }
        }
    }
    
    private func card(for item: HomeMenuItem) -> some View {
        Text(item.title)
            .foregroundColor(.light2B2B2B)
            .font(.rubikMedium16)
            .frame(maxWidth: .infinity)
            .frame(height: 70)
            .opacity(0.6)
            .cardViewBackground(backgroundColor: .lightC6D7DC.opacity(0.4))
            .overlay(alignment: .topTrailing) {
                item.icon
                    .resizableImage(size: .init(edgeLength: 16))
                    .padding([.top, .trailing], 12)
            }
    }
    
    private func sectionHeader(with text: String) -> some View {
        Text(text)
            .font(.rubikBold15)
            .foregroundColor(.light2B2B2B)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(
            viewModel: .mocked
        )
            .environmentObject(HomeCoordinator.mockedRouter)
    }
}
