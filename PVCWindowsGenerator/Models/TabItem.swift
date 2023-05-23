//
//  TabItem.swift
//  PVCWindowsGenerator
//
//  Created by Alex Bofu on 18.05.2023.
//

import SwiftUI

enum TabItem: String, CaseIterable, Identifiable {
    
    case home, offers, contracts, menu
    
    var id: String { rawValue }
    
    var description: String {
        switch self {
        case .home: return .tabbarHome.capitalized
        case .offers: return .tabbarOffers.capitalized
        case .contracts: return .tabbarContracts.capitalized
        case .menu: return .tabbarMenu.capitalized
        }
    }
    
    var icon: Image {
        switch self {
        case .home: return Image(systemName: "house.circle.fill")
        case .offers: return Image(systemName: "square.and.pencil.circle.fill")
        case .contracts: return Image(systemName: "folder.circle.fill")
        case .menu: return Image(systemName: "ellipsis.circle.fill")
        }
    }
}
