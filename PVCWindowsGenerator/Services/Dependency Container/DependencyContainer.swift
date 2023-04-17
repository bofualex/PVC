//
//  DependencyContainer.swift
//  PVCWindowsGenerator
//
//  Created by Alex Bofu on 11.04.2023.
//

import Foundation

protocol DependencyContainerProtocol {
    associatedtype AuthService = AuthenticationServiceProtocol
    associatedtype NetworkService = NetworkServiceProtocol
    associatedtype StorageService = StorageServiceProtocol

    var authService: AuthService { get }
    var networkService: NetworkService { get }
    var storageService: StorageService { get }
}

class DependencyContainer: DependencyContainerProtocol {
    
    let authService: AuthenticationService
    let networkService: NetworkService
    let storageService: StorageService
    
    init(
        authService: AuthenticationService,
        networkService: NetworkService,
        storageService: StorageService
    ) {
        self.authService = authService
        self.networkService = networkService
        self.storageService = storageService
    }
}

extension DependencyContainer {
    static let defaultContainer = DependencyContainer(
        authService: .init(),
        networkService: .init(),
        storageService: .init()
    )
}

class DependencyContainerMock: DependencyContainerProtocol {
    
    let authService: AuthenticationServiceMock
    let networkService: NetworkServiceMock
    let storageService: StorageServiceMock
    
    init(
        authService: AuthenticationServiceMock,
        networkService: NetworkServiceMock,
        storageService: StorageServiceMock
    ) {
        self.authService = authService
        self.networkService = networkService
        self.storageService = storageService
    }
}
