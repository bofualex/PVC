//
//  TabBarViewModel.swift
//  PVCWindowsGenerator
//
//  Created by Alex Bofu on 19.05.2023.
//

import SwiftUI

class TabBarViewModel: ObservableObject {
    
    @Published var tabItems = TabItem.allCases
    @Published var selectedTab = TabItem.home
    
}
