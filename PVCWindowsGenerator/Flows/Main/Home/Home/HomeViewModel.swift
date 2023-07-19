//
//  HomeViewModel.swift
//  PVCWindowsGenerator
//
//  Created by Alex Bofu on 22.06.2023.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    
    @Published var inProgressContracts = [Contract]()
    @Published var isLoadingContracts = false
    
    private let networkService: NetworkServiceProtocol
    
    //MARK: - init
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
        
        getInProgressContracts()
    }
    
    //MARK: - private
    private func getInProgressContracts() {
        isLoadingContracts = true
    }
}

extension HomeViewModel {
    static let mocked = HomeViewModel(networkService: NetworkServiceMock())
}
