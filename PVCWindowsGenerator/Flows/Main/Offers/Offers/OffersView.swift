//
//  OffersView.swift
//  PVCWindowsGenerator
//
//  Created by Alex Bofu on 20.05.2023.
//

import SwiftUI

struct OffersView: View {
    
    @EnvironmentObject private var router: OffersCoordinator.Router

    var body: some View {
        NavigationBar(
            barType: .title(title: .offersScreenTitle.capitalized),
            isBackButtonHidden: true,
            contentView: {
                content
            }
        )
        .fillWithDefaultScreenBackground()
    }
    
    private var content: some View {
        VStack(alignment: .center, spacing: 24) {
            Spacer()
        }
        .padding(.horizontal, 24)
        .padding(.top, 36)
    }
}

struct OffersView_Previews: PreviewProvider {
    static var previews: some View {
        OffersView()
            .environmentObject(OffersCoordinator.mockedRouter)
    }
}
