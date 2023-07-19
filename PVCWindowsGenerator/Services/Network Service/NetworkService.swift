//
//  NetworkService.swift
//  PVCWindowsGenerator
//
//  Created by Alex Bofu on 11.04.2023.
//

import Foundation
import FirebaseFirestore

protocol NetworkServiceProtocol {
    
    func getContracts(by status: Contract.Status) async throws -> [Contract]
    
}

class NetworkService: NetworkServiceProtocol {
    
    private let db = Firestore.firestore()
    
    func getContracts(by status: Contract.Status) async throws -> [Contract] {
        try await db.getCollection(from: .contracts)
    }
}

class NetworkServiceMock: NetworkServiceProtocol {
    
    func getContracts(by status: Contract.Status) async throws -> [Contract] {
        try await Task.sleep(for: .seconds(5))
        
        return Contract.mocked
    }
}
