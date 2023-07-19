//
//  HomeMenuItem.swift
//  PVCWindowsGenerator
//
//  Created by Alex Bofu on 10.06.2023.
//

import SwiftUI

struct HomeMenuSection: Identifiable {
    
    var id: String { title }
    
    let title: String
}

extension HomeMenuSection {
    static let inProgressOffers = HomeMenuSection(title: .homeMenuSectionInProgress)
    static let quickActions = HomeMenuSection(title: .homeMenuSectionQuickActions)
}

struct HomeMenuItem: Identifiable {
    
    var id: String { title }
    
    let title: String
    let icon: Image
}

extension HomeMenuItem {
    static let createOffer = HomeMenuItem(
        title: .homeMenuItemCreateOffer,
        icon: Image(systemName: "pencil.and.outline")
    )
    static let materials = HomeMenuItem(
        title: .homeMenuItemMaterials,
        icon: Image(systemName: "chart.bar.fill")
    )
    static let pendingToInstall = HomeMenuItem(
        title: .homeMenuItemPendingToInstall,
        icon: Image(systemName: "window.casement")
    )
    static let inTheMaking = HomeMenuItem(
        title: .homeMenuItemInTheMaking,
        icon: Image(systemName: "building.fill")
    )
    static let team = HomeMenuItem(
        title: .homeMenuItemTeam,
        icon: Image(systemName: "person.3.fill")
    )
    static let vehicles = HomeMenuItem(
        title: .homeMenuItemVehicles,
        icon: Image(systemName: "car.2.fill")
    )
    
    static let gridCases: [HomeMenuItem] = [.createOffer, .materials, .pendingToInstall, .inTheMaking, .team, .vehicles]
}
